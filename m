From: Sam Vilain <sam@vilain.net>
Subject: Re: Pulling one commit at a time.
Date: Mon, 24 Aug 2009 08:19:25 +1200
Message-ID: <1251058765.7438.2.camel@maia.lan>
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com>
	 <4A9172D0.6030507@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sanjiv Gupta <sanjiv.gupta@microchip.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 22:17:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfJUu-0005PA-Hx
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 22:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934098AbZHWUQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 16:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934093AbZHWUQf
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 16:16:35 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:36109 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934090AbZHWUQf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 16:16:35 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 27ADB21C453; Mon, 24 Aug 2009 08:16:36 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 0ED7721C14E;
	Mon, 24 Aug 2009 08:16:32 +1200 (NZST)
In-Reply-To: <4A9172D0.6030507@microchip.com>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126870>

On Sun, 2009-08-23 at 22:18 +0530, Sanjiv Gupta wrote:
> Hi,
> This is my first post here.
> I just wanted to know how can I pull one commit at a time from public 
> repository.
> e.g.
> when I first cloned from the public repo, it was at X. now it 
> has reached Y. I just want to pull x+1.
>  
> how to do that?
>  
> In SVN, we can just do $ svn update -r next_rev_num

git pull or git pull --rebase

Why not find a tutorial or go through the user manual.

Sam
