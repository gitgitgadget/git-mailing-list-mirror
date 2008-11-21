From: Gary Yang <garyyang6@yahoo.com>
Subject: '/pub/git/u-boot.git': not in whitelist. Please help!
Date: Thu, 20 Nov 2008 18:20:57 -0800 (PST)
Message-ID: <202329.35126.qm@web37906.mail.mud.yahoo.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 03:22:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Lew-0004lT-5d
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 03:22:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbYKUCU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 21:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbYKUCU6
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 21:20:58 -0500
Received: from web37906.mail.mud.yahoo.com ([209.191.91.168]:31331 "HELO
	web37906.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752193AbYKUCU6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Nov 2008 21:20:58 -0500
Received: (qmail 35460 invoked by uid 60001); 21 Nov 2008 02:20:57 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=kS6wJsBvi4qmexrZiYEdfoktDoB2zioiz0eUa6KXLCohVmSR7afnVG6oG7Wy+mN0iWLC7eKtQAK1QWG8QIuJF4AGX3GFTa+PTVXnRpg0+szKwETdfarWKImuxPGV1W/FC7DAHp4X5C9pzstgMlVrsbbTAe11kHwBVBg/+4vdyUw=;
X-YMail-OSG: hW_g2FQVM1k1ApgskECAXWiv4sAzrq6gJ4g5XRiUKYtqzh6_PvY8Jqd_YzU0wKBMMxNefDpvFgBaLDk0vsdYq1kA3KwrasdtJbzrSC8Tmqo5JxWytEdpN5T8a5UZ9vl4j5kFRJ74BiwP5bL3Lc_wDM_7_Y5I5mdtYuUyNnmNUswnSeghCdfvQASF79UA
Received: from [76.195.33.70] by web37906.mail.mud.yahoo.com via HTTP; Thu, 20 Nov 2008 18:20:57 PST
X-Mailer: YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101493>


At git public repository server, I started git-daemon

sudo git-daemon git-daemon -verbose --inetd --export-all --base-path=/pub/git &

grep 9418 /etc/services
git             9418/tcp                        # Git Version Control System

At my private machine:
git pull git://svdcgit01.amcc.com/pub/git/u-boot.git
fatal: The remote end hung up unexpectedly

At the git public repository server, I got:
'/pub/git/u-boot.git': not in whitelist

ls /pub/git/u-boot.git
branches/  config  description  HEAD  hooks/  info/  objects/  refs/

What I did wrong? Please help.




      
