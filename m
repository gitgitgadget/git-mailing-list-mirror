From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] rebase with preserve merges should not show merged
	commits
Date: Sat, 22 Mar 2008 16:12:34 +0100
Message-ID: <20080322151234.GA19558@atjola.homenet>
References: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de> <20080322015252.GA7570@atjola.homenet> <20080322140648.GA3189@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sat Mar 22 16:13:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd5PM-0002HS-Kx
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 16:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbYCVPMi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Mar 2008 11:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbYCVPMi
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 11:12:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:33246 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750895AbYCVPMh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 11:12:37 -0400
Received: (qmail invoked by alias); 22 Mar 2008 15:12:35 -0000
Received: from i577AC47C.versanet.de (EHLO atjola.local) [87.122.196.124]
  by mail.gmx.net (mp030) with SMTP; 22 Mar 2008 16:12:35 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1++fEtXXtG+zBKapWojA60ixp6Kvci/pfP5FMfP+x
	az7mRwO0Cpryqj
Content-Disposition: inline
In-Reply-To: <20080322140648.GA3189@alea.gnuu.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77816>

On 2008.03.22 15:06:48 +0100, J=F6rg Sommer wrote:
> Bj=F6rn Steinbrink schrieb am Sat 22. Mar, 02:52 (+0100):
> > On 2008.03.22 02:19:42 +0100, J=F6rg Sommer wrote:
> > > The current version of git-rebase--interactive shows the user the=
 commits
> > > coming from a merge.
> > >=20
> > > M---A---B
> > >  \       \
> > >   o---o---+---o branch
> > >=20
> > > Rebasing branch on M with preserve merges gives the commits A and=
 B. But
> > > if you mark them for editing or remove them the rebase fails. You=
 must
> > > keep them as they are. It's useless to bother the user with these=
 commits
> > > and might lead to mistakes.
> >=20
> > Uhm, why do you completely remove the possibility to edit A
>=20
> Ahh, now I see what you've tried to say. I did add the option
> --first-parent for rebase interactive *without* preserve merges, too.
> I'll update my patch.

I didn't even look at it closely enough to notice that.
--preserve-merges preserves the structure of the history. You seem to
interpret it as to preserve the merges against the original parents,
except for the first one, and that's simply not what it's meant to do. =
I
can see how that might be useful, but you'd have to add that as an
additional mode of operation, and not break the normal one.

Bj=F6rn
