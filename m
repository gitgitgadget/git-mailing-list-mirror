From: Mike Stump <mikestump@comcast.net>
Subject: Re: cherry picking and merge
Date: Fri, 1 Aug 2014 09:56:51 -0700
Message-ID: <AC750A73-4FE9-4BCB-9A51-4DE28F2110A7@comcast.net>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <20140801024329.GA28914@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Aug 01 19:03:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDGEd-0005oW-Gp
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 19:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbaHARDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 13:03:11 -0400
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:53643 "EHLO
	qmta06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751460AbaHARDK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 13:03:10 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Aug 2014 13:03:10 EDT
Received: from omta07.emeryville.ca.mail.comcast.net ([76.96.30.59])
	by qmta06.emeryville.ca.mail.comcast.net with comcast
	id ZU2M1o0041GXsucA6Ux40Z; Fri, 01 Aug 2014 16:57:04 +0000
Received: from [IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d] ([IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d])
	by omta07.emeryville.ca.mail.comcast.net with comcast
	id ZUx31o00s2ztT3H8UUx4cp; Fri, 01 Aug 2014 16:57:04 +0000
In-Reply-To: <20140801024329.GA28914@vauxhall.crustytoothpaste.net>
X-Mailer: Apple Mail (2.1878.6)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1406912224;
	bh=9M1xP1c4ao9a+XXNmOrxoE/DjVEHT5V6uFuy+eB221Q=;
	h=Received:Received:Content-Type:Mime-Version:Subject:From:Date:
	 Message-Id:To;
	b=byglpUPpsCKBsgQHw2X9/qsLn/oSJxLEUrd+u94nut+F6OWJC89J1dAS1MhpxjljF
	 wDXAcYFnFUvzrujIZuu46WvMDxhGxxNrGZwpxOGTpPo/zGL0KOav0bZV47R3sAHA5K
	 o0t0dIIvH1s4pmhEsROSkln6O5KKo1c/Ut5AOYZR/iGsFpEPEO3hBhNVXz6SWkQSZ7
	 IQgoccytsccY/0/BQ7xgJ2Mq1mM4ABLYaO3yZFe8PbVFeQqGQV8x0Xqjmfc7fx6108
	 zzRxIlnm8rHpW0k1wyL1RZM6joFaRuSk8QD3V463fnY+OnwCPyd0YzkE7MuLYWhsVE
	 kviuY67OBfuew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254632>

On Jul 31, 2014, at 7:43 PM, brian m. carlson <sandals@crustytoothpaste=
=2Enet> wrote:
>=20
> You're not the first person to be surprised by the way merge works.

I=92m not the first, because the merge command is broken.  Once fixed, =
I would be happy to be the last.  Until then, the bug remains unfixed. =
 I=92m sending the mail to petition for this bug to be fixed.

> From the git-merge manage:
>=20
>  [This behavior] occurs because only the heads and the merge base are
>  considered when performing a merge, not the individual commits.

=46rom:

google(=94git merge=94):

> git-merge - Join two or more development histories together

Either, the command should do as documented, or be fixed.  In that refe=
rence, there is no mention that merge will not merge.  There is no ment=
ion that merge isn=92t the command I want to merge, but that I should u=
se rebase.

=46urther, google(=93git rebase=94) says:

> There is no difference in the end product of the integration,

Clearly, this is a lie.  There is a difference.

Now, about rebase:

> Do not rebase commits that you have pushed to a public repository.
>=20
> If you follow that guideline, you=92ll be fine. If you don=92t, peopl=
e will hate you, and you=92ll be scorned by friends and family.


Since everything I do goes up and down into repositories and I don=92t =
want my friends and family to scorn me, rebase isn=92t the command I wa=
nt to use.

I want to use the simple, it works, named for the operation I want to p=
erform, merge.  I=92m a simple user, and the simple command I want to w=
ork.  You can name the old merge command, merge-mostly or merge-fast an=
d the new one can be called merge.

> (That was added after 1.7.9.5.)

I don=92t want bugs documented, I want them fixed.  I=92m not reporting=
 a doc bug, the doc is correct.

> If you want the behavior of applying multiple patches in a row, you w=
ant
> to use git rebase, not git merge.  Since rebase re-applies the patche=
s
> of each of your commits on top of another branch, the identical chang=
e
> won't cause conflicts.

But, I don=92t want the series of patches, I just want a simple,  merge=
d feature X on trunk single commit that merge does.

Given branch B, master M, and cherry picked C, what I want merged is B-=
(M+C), not B-M.  The problem with B-M, is that when you do B +=3D C (ak=
a cherry pick from master onto your branch), then M +=3D B-M (merge you=
r branch into master), that C is then replicated.  This replication is =
wrong, always wrong, never right, incorrect, broken.  This is the bug I=
 want fixed.