From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Teach "git checkout" to use git-show-ref
Date: Sat, 16 Sep 2006 00:11:38 +0200
Organization: At home
Message-ID: <eef8dq$nbc$1@sea.gmane.org>
References: <Pine.LNX.4.64.0609151108560.4388@g5.osdl.org> <Pine.LNX.4.64.0609151455150.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Sep 16 00:11:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOLuM-0003MM-N8
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 00:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWIOWLf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 15 Sep 2006 18:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWIOWLf
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 18:11:35 -0400
Received: from main.gmane.org ([80.91.229.2]:63198 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932313AbWIOWLf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 18:11:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GOLuC-0003JA-Vx
	for git@vger.kernel.org; Sat, 16 Sep 2006 00:11:29 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Sep 2006 00:11:28 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Sep 2006 00:11:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27104>

Linus Torvalds wrote:

> @@ -51,7 +51,7 @@ while [ "$#" !=3D "0" ]; do
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0fi
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0new=3D"$rev"
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0new_name=3D"$arg^0"
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
if [ -f "$GIT_DIR/refs/heads/$arg" ]; then
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
if git-show-ref --verify --quiet -- "refs/heads/$arg" ]; then
  +                       if git-show-ref --verify --quiet -- "refs/hea=
ds/$arg"; then
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0branch=3D"$arg"
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0fi
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0elif rev=3D$(git-rev-=
parse --verify "$arg^{tree}" 2>/dev/null)

There is leftover ] before ; in if.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
