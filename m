From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: Re: [PATCH] Deb Packaging fixes: Build against Mozilla libs for Debian, conflict with "git"
Date: Sun, 24 Jul 2005 07:28:40 +0400
Message-ID: <200507240728.40158.snake@penza-gsm.ru>
References: <20050723073707.GA3255@mythryan2.michonline.com> <20050723192335.GA24071@mythryan2.michonline.com> <20050723192632.GB24071@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 24 05:29:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwXAe-00049Q-EI
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 05:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVGXD2p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 23:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVGXD2p
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 23:28:45 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:35216
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S261849AbVGXD2o
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 23:28:44 -0400
Received: (qmail 21676 invoked from network); 24 Jul 2005 03:28:42 -0000
Received: from unknown (HELO snake-modem.penza-gsm.ru) (192.168.5.2)
  by fileserver.penza-gsm.ru with SMTP; 24 Jul 2005 03:28:41 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <20050723192632.GB24071@mythryan2.michonline.com>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-102.8 required=5.0 tests=ALL_TRUSTED,AWL,
	USER_IN_WHITELIST autolearn=unavailable version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Satturday, 23 July 2005 23:26 Ryan Anderson wrote:
> -Depends: ${misc:Depends}, shellutils, diff, rsync, rcs
> +Depends: ${misc:Depends}, patch, diff, rsync, rcs, ssh
Did I missed something or you forgot about libcurl3 dependency?

-- 
Respectfully
Alexey Nezhdanov
