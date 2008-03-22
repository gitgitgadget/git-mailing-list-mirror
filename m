From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] rebase with preserve merges should not show merged
	commits
Date: Sat, 22 Mar 2008 02:52:52 +0100
Message-ID: <20080322015252.GA7570@atjola.homenet>
References: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sat Mar 22 02:53:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jcsvd-00080f-Qu
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 02:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbYCVBw4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Mar 2008 21:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752840AbYCVBw4
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 21:52:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:39875 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751558AbYCVBwz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 21:52:55 -0400
Received: (qmail invoked by alias); 22 Mar 2008 01:52:53 -0000
Received: from i577AC47C.versanet.de (EHLO atjola.local) [87.122.196.124]
  by mail.gmx.net (mp058) with SMTP; 22 Mar 2008 02:52:53 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/f2VhvmITfvQ65nCHYGERnvZEdVZEeHCqp/euKE9
	+x775JTsAv8hZy
Content-Disposition: inline
In-Reply-To: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77790>

On 2008.03.22 02:19:42 +0100, J=F6rg Sommer wrote:
> The current version of git-rebase--interactive shows the user the com=
mits
> coming from a merge.
>=20
> M---A---B
>  \       \
>   o---o---+---o branch
>=20
> Rebasing branch on M with preserve merges gives the commits A and B. =
But
> if you mark them for editing or remove them the rebase fails. You mus=
t
> keep them as they are. It's useless to bother the user with these com=
mits
> and might lead to mistakes.

Uhm, why do you completely remove the possibility to edit A instead of
fixing the code so that the editing actually works?

Bj=F6rn
