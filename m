From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: qgit-0.4
Date: Fri, 10 Jun 2005 21:43:24 +0200
Message-ID: <42A9ED5C.1070604@gorzow.mm.pl>
References: <20050610183537.39108.qmail@web26301.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 21:40:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgpLd-0001xZ-JA
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 21:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVFJTnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 10 Jun 2005 15:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVFJTnk
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 15:43:40 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:20172 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261185AbVFJTnj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2005 15:43:39 -0400
Received: (qmail 27463 invoked from network); 10 Jun 2005 19:43:35 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.161.223])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 10 Jun 2005 19:43:35 -0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zen.uplink (Postfix) with ESMTP id 38FD35EB670;
	Fri, 10 Jun 2005 21:43:24 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050425)
X-Accept-Language: en-us, en
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050610183537.39108.qmail@web26301.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marco Costalba wrote:

>Here is qgit-0.4, a git GUI viewer
>
>New in this version:
>
>- file history
>
>- command line arguments passed to git-rev-list, eg: qgit v2.6.12-rc6 =
^v2.6.12-rc4
>
>- complete rewrite of start-up thread, should be faster now, expeciall=
y with warm start
>
> =20
>
>
It certainly is faster. However, I have some gripes with it:
- it doesn't support national characters
- it doesn't decode dates (author Rados=B3aw Szkodzi=F1ski
<astralstorm@gorzow.mm.pl> 1118416741 +0200)
- you could run git-rev-list niced, and maybe with --pretty and
--merge-order
- somehow the program is much slower than gitk and I don't think it's
caused by qt or C++

AstralStorm
