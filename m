From: Konstantin Kivi <kkivi@yandex.ru>
Subject: Re: git fetch vs push, git am questions
Date: Tue, 07 Dec 2010 15:31:23 +0300
Message-ID: <60371291725083@web106.yandex.ru>
References: <99351291667275@web152.yandex.ru> <20101207002104.GG3264@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Dec 07 13:42:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPws5-0003mx-2x
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 13:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974Ab0LGMmM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 07:42:12 -0500
Received: from forward7.mail.yandex.net ([77.88.61.37]:45740 "EHLO
	forward7.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab0LGMmL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 07:42:11 -0500
X-Greylist: delayed 634 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Dec 2010 07:42:11 EST
Received: from web106.yandex.ru (web106.yandex.ru [77.88.61.7])
	by forward7.mail.yandex.net (Yandex) with ESMTP id 752381B0911A;
	Tue,  7 Dec 2010 15:31:24 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1291725084; bh=M1zrgx70+7QEojpNn1lqNOiPgmsKizt9LSBK7QZPCng=;
	h=From:To:Cc:In-Reply-To:References:Subject:MIME-Version:Message-Id:
	 Date:Content-Transfer-Encoding:Content-Type;
	b=aaCSlPrpjacrvwVwq8JR0nQ2e0zI4E6THm9YrJd0o6j8EwuH3pY8mRIC/C/fsLJjP
	 6PEhnddwq469usln4RCJUgEzuNQPSohHwEwN2lXDBMkWNh3xXDQX3k4kogRWBnnEWn
	 htRnOveUrb193Eaonc57Ob4bxQbMds5md3FtvP+I=
Received: from localhost (localhost.localdomain [127.0.0.1])
	by web106.yandex.ru (Yandex) with ESMTP id 6732F50809B;
	Tue,  7 Dec 2010 15:31:24 +0300 (MSK)
Received: from Comtekh-N-gw.rosprint.net (Comtekh-N-gw.rosprint.net [195.151.248.41]) by mail.yandex.ru with HTTP;
	Tue, 07 Dec 2010 15:31:23 +0300
In-Reply-To: <20101207002104.GG3264@localhost.localdomain>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163077>



07.12.10, 03:21, "Konstantin Khomoutov" <flatworm@users.sourceforge.net=
>:


>  `git pull` does exactly that: fetch + merge (which should result in
>  fast-forward in your case).

pull does not work on bare repos.

>  > I also found that there is a notions of current branch in bare rep=
ository
> > =9AHow can I change current branch in bare repositry?

I think I will understand things better if I get what is 'current branc=
h' for bare repository
and how to change it

>  By re-writing the HEAD ref (this behaviour is documented in the man =
page
>  of the `git clone` command, see the "--branch" option for instance).

The repository already exists, so git-clone  will not help

>  You can use the `git symbolic-ref` to update the HEAD ref.
> =20

Do you mean something like=20
git symbolic-ref  master origin/master ?


>  [...]
> =20
>  P.S.
>  It's a bit strange you're playing with a bare repository in this way=
=2E
>  Usually a bare repository is supposed to be pushed to and pulled fro=
m,
>  not the other way round. Not that it's bad, but it may turn out you'=
re
>  inventing a convoluted workflow when there may be a simpler solution=
=2E

Yes, I see that push is easier, I only want to be sure I have full cont=
rol on what is going on.


--=20
=F3 =D5=D7=C1=D6=C5=CE=C9=C5=CD, =EB=CF=CE=D3=D4=C1=CE=D4=C9=CE =EB=C9=D7=
=C9
