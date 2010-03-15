From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: FEATURE REQUEST: Comment assignment on branches
Date: Mon, 15 Mar 2010 22:10:06 +0100
Message-ID: <4B9EA22E.1010103@lsrfire.ath.cx>
References: <be8f531d1003150133n3ea64109u7d573dbd533ffa48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Maxim Treskin <zerthurd@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 22:10:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrHYJ-0001Vb-2z
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 22:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936821Ab0COVKM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 17:10:12 -0400
Received: from india601.server4you.de ([85.25.151.105]:59909 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936744Ab0COVKL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 17:10:11 -0400
Received: from [10.0.1.100] (p57B7CEE7.dip.t-dialin.net [87.183.206.231])
	by india601.server4you.de (Postfix) with ESMTPSA id 2715D2F804E;
	Mon, 15 Mar 2010 22:10:09 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <be8f531d1003150133n3ea64109u7d573dbd533ffa48@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142252>

Am 15.03.2010 09:33, schrieb Maxim Treskin:
> Hello
>=20
> Is it possible to add comments assignment to branches?
> Something like:
>=20
> $ git branch --comment=3D"New branch with implementation of some feat=
ures" br14
>=20
> $ git branch
>   br14
> * master
>=20
> $ git branch --comments
>   br14           (New branch with implementation of some features)
> * master
>=20
> and when configuration variable branch.comments =3D=3D true, this beh=
avior
> is default.

Hmm.  You could name your branch
"br14/new-branch-with-implementation-of-some-features" instead of
"br14".  With command line completion you would only have to hit two
extra keys (slash tab) and could enjoy a meaningful branch name everywh=
ere.

Ren=C3=A9
