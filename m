From: Stephen Bash <bash@genarts.com>
Subject: Re: git log for a merged branch
Date: Mon, 13 Sep 2010 10:13:38 -0400 (EDT)
Message-ID: <15224422.248536.1284387218322.JavaMail.root@mail.hq.genarts.com>
References: <AANLkTikbnoR_=x1_Aq4jh1BuMarEMxXkY=iX0iOjdgyt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michele Ballabio <barra_cuda@katamail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Santi_B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Sep 13 16:13:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov9n5-0003HU-Nm
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 16:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836Ab0IMONq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 10:13:46 -0400
Received: from hq.genarts.com ([173.9.65.1]:27134 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750997Ab0IMONp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 10:13:45 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 930591E2636D;
	Mon, 13 Sep 2010 10:13:44 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fBvzz6wkqRwS; Mon, 13 Sep 2010 10:13:38 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 6F8061E26371;
	Mon, 13 Sep 2010 10:13:38 -0400 (EDT)
In-Reply-To: <AANLkTikbnoR_=x1_Aq4jh1BuMarEMxXkY=iX0iOjdgyt@mail.gmail.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156092>

----- Original Message -----
> From: "Santi B=C3=A9jar" <santi@agolina.net>
> To: "Stephen Bash" <bash@genarts.com>
> Cc: "Michele Ballabio" <barra_cuda@katamail.com>, "Git Mailing List" =
<git@vger.kernel.org>
> Sent: Monday, September 13, 2010 10:00:18 AM
> Subject: Re: git log for a merged branch
>=20
> If there is more than one merge-base you=C2=B4ll have to use:
>=20
> git log mergecmt^2 --not $(git merge-base mergecmt^1 mergecmt^2)
>=20
> and you may use this shorter form:
>=20
> git log mergecmt^2 --not $(git merge-base mergecmt^@)

That's surprisingly compact...  Impressive.

Slightly changing the topic, we normally tag the release branch, then m=
erge, then delete the branch.  Is there a simple way to determine merge=
mt from the release tag?

Thanks,
Stephen
