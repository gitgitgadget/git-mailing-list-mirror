From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] Display 'theirs' branch name when possible in merge.
Date: Sat, 23 Dec 2006 10:11:28 +0100
Organization: At home
Message-ID: <emirms$kh3$1@sea.gmane.org>
References: <6115ec06459724c7c37c355805462cb61715e9c5.1166863413.git.spearce@spearce.org> <20061223084447.GB10203@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Dec 23 10:09:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy2sd-000398-61
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 10:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbWLWJJM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Dec 2006 04:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbWLWJJM
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 04:09:12 -0500
Received: from main.gmane.org ([80.91.229.2]:50664 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302AbWLWJJK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 04:09:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gy2sE-0001mJ-GC
	for git@vger.kernel.org; Sat, 23 Dec 2006 10:08:58 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 10:08:58 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 10:08:58 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35305>

Shawn O. Pearce wrote:

> Displaying the SHA1 of 'their' branch (the branch being merged into
> the current branch) is not nearly as friendly as just displaying
> the name of that branch, especially if that branch is already local
> to this repository.
>=20
> git-merge now sets the environment variable 'GITHEAD_%(sha1)=3D%(name=
)'
> for each argument it gets passed, making the actual input name that
> resolved to the commit '%(sha1)' easily available to the invoked
> merge strategy.
>=20
> git-merge-recursive makes use of these environment variables when
> they are available by using '%(name)' whenever it outputs the commit
> identification rather than '%(sha1)'. =A0This is most obvious in the
> conflict hunks created by xdl_merge:
>=20
> =A0 $ git mege sideb~1
      git merge sideb~1
> =A0 <<<<<<< HEAD:INSTALL
> =A0 =A0 =A0Good!
> =A0 =3D=3D=3D=3D=3D=3D=3D
> =A0 =A0 =A0Oops.
> =A0 >>>>>>> sideb~1:INSTALL

Very nice. Thanks.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
