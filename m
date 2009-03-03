From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: move files between disparate repos and maintain version history
Date: Tue, 3 Mar 2009 20:22:24 +0100
Message-ID: <20090303192224.GB9964@m62s10.vlinux.de>
References: <0d8965bb-e2ed-4f49-b323-c110f605ae2c@33g2000yqm.googlegroups.com> <20090303041300.GA18136@coredump.intra.peff.net> <f95d47890903030858xb398b5fy1aeabb19166e6077@mail.gmail.com> <20090303171835.GB454@coredump.intra.peff.net> <f95d47890903031008s36873f6ex94c7096f79cd6de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Copeland <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 20:22:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeaBt-0003Dv-Dr
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 20:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbZCCTUg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 14:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbZCCTUg
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 14:20:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:60493 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750771AbZCCTUf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 14:20:35 -0500
Received: (qmail invoked by alias); 03 Mar 2009 19:20:29 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp056) with SMTP; 03 Mar 2009 20:20:29 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19stIsXwJBsoGoiifjki4rqsSDiRvTR9ij/8Ml5ET
	9KKb/bfELZZc9P
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 536B9199AF; Tue,  3 Mar 2009 20:22:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f95d47890903031008s36873f6ex94c7096f79cd6de@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112150>

On Tue, Mar 03, 2009 at 01:08:17PM -0500, David Copeland wrote:
> The patch file looks correct.  I'm wondering if this is a result of
> both repos being connected to svn?
>=20
> my process was:
>=20
> - format patch
> - go to other repo

> - git svn rebase

This will change the date of commits already in svn because it uses
git rebase (with all its problems, see its manpage)

> - apply patch
> - git svn dcommit
>=20
> Could dcommit change the dates since, to svn, they are appear as
> commits right now?
>=20
> Dave
>=20
> On Tue, Mar 3, 2009 at 12:18 PM, Jeff King <peff@peff.net> wrote:
> > On Tue, Mar 03, 2009 at 11:58:42AM -0500, David Copeland wrote:
> >
> >> The first option worked, insomuch the history of diffs is preserve=
d,
> >> but the dates are all today.
> >
> > That's odd. It works fine here. Can you confirm that the correct da=
tes
> > in the "patches" file (i.e., the output of format-patch)? What are =
you
> > using to look at the patches? Note that gitk will show you both the
> > "committer" and the "author" fields. The "author" field should have=
 the
> > original author and time of the patch, but the "committer" will be =
you,
> > today.
> >
> >> The second option was a little over my head; is the idea there tha=
t
> >> you are setting up a branch that has ONLY the files I care about (=
with
> >> all their history), and then I pull from the other repo as if they=
 are
> >> related? =A0That seems like it might preserve the dates...
> >
> > Yes, that is exactly what is happening in the second example.
> >
> > -Peff
