From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: git-rev-list --merge-order hangs
Date: Wed, 08 Jun 2005 17:28:01 +0200
Message-ID: <42A70E81.7090308@gorzow.mm.pl>
References: <42A69550.1030105@gorzow.mm.pl>	 <2cfc4032050608002258e58897@mail.gmail.com>	 <2cfc403205060800337e1ecca0@mail.gmail.com> <2cfc4032050608020215152887@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 17:27:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg2Q6-0002KX-8J
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 17:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVFHP23 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 11:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVFHP22
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 11:28:28 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:37014 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261325AbVFHP2O (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 11:28:14 -0400
Received: (qmail 17457 invoked from network); 8 Jun 2005 15:28:10 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.161.223])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <jon@blackcubes.dyndns.org>; 8 Jun 2005 15:28:10 -0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zen.uplink (Postfix) with ESMTP id 86E3B5CED24;
	Wed,  8 Jun 2005 17:28:01 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050425)
X-Accept-Language: en-us, en
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc4032050608020215152887@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jon Seymour wrote:

>Actually, one case that I may not have considered properly is a commit
>near the head that has no parents.
>
>      git-rev-list --parents v2.6.12-rc6-astorm1 ^v2.6.12-rc6
>
>should tell you if this case exists. Ideally such a case should not
>occur, but that isn't a logical certainity, so I should handle it
>better than I currently do.
>
>Please let me know if this may explain your case. 
>  
>
This just threw tons of SHA1 hashes at me without complaining.
I've also tried git-rev-list HEAD >/dev/null without any chage whatsoever.

The tree is not secret, You can try (very slow) rsync at:
rsync://astralstorm.servegame.com/linux-2.6-astorm

Just update latest linux-2.6 with it to save time.
(mine is up to commit 1d6757fbff5bc86e94e59ab0d7bdd7e71351d839)

AstralStorm
