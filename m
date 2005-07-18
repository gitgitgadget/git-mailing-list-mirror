From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: Re: Last mile to 1.0?
Date: Mon, 18 Jul 2005 08:53:41 +0400
Message-ID: <200507180853.41633.snake@penza-gsm.ru>
References: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 18 06:53:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuNdV-0007Yd-NX
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 06:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVGRExp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 00:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVGRExp
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 00:53:45 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:57547
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S261518AbVGRExo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2005 00:53:44 -0400
Received: (qmail 13411 invoked from network); 18 Jul 2005 04:53:43 -0000
Received: from unknown (HELO snake) (192.168.0.20)
  by fileserver.penza-gsm.ru with SMTP; 18 Jul 2005 04:53:42 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-102.8 required=5.0 tests=ALL_TRUSTED,AWL,
	USER_IN_WHITELIST autolearn=unavailable version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Satturday, 16 July 2005 21:46 Junio C Hamano wrote:
> I do not know what release plan Linus has in mind, and also
> expect things to be quieter next week during OLS and kernel
> summit, but I think we are getting really really close.
>
> Here are the things I think we would want to see before we hit
> 1.0:
>
>  - Remaining feature enhancements and fixes.
>
>    - Anonymous pull from packed archives on remote sites via
>      non-rsync, non-ssh transport.  Many people are behind
>      corporate firewalls that do not pass anything but outgoing
>      http(s) and some do not even pass outgoing ssh.  The recent
>      addition of git-daemon by Linus would greatly alleviate the
>      situation, but we may also end up wanting something HTTP
>      reachable.
I'd add the UTF-8 native support. Currently neither commit nor gitk doesn't 
support that. Probably this should be done at as low as possible level.


-- 
Respectfully
Alexey Nezhdanov
