From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 6/6] Fix a "pointer type missmatch" warning.
Date: Sun, 04 Mar 2007 16:30:27 +0000
Message-ID: <45EAF423.8060609@ramsay1.demon.co.uk>
References: <45E9BE6F.9090400@ramsay1.demon.co.uk> <Pine.LNX.4.63.0703031941240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 04 19:54:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNvqo-0000es-E8
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 19:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbXCDSy1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 13:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbXCDSy1
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 13:54:27 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:2915 "EHLO
	anchor-post-32.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752382AbXCDSy0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Mar 2007 13:54:26 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-32.mail.demon.net with esmtp (Exim 4.42)
	id 1HNvqd-000PZw-8N; Sun, 04 Mar 2007 18:54:20 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <Pine.LNX.4.63.0703031941240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41364>

Hi Johannes,

Johannes Schindelin wrote:
> On Sat, 3 Mar 2007, Ramsay Jones wrote:
> 
>> Note: set OLD_ICONV in your config.mak file on Cygwin.
> 
> Shouldn't you set it in Makefile instead?
> 

Yes, well the first version of that patch did exactly that!
(which caused me to use "git commit --amend" for the first time.)

However, I changed my mind, in order to be consistent with
the NO_C99_FORMAT patch (2/6); I am assuming that at some point
newlib will update iconv() to the new prototype, and I would
have to remove OLD_ICONV from the Makefile again.

To be clear, the setting of both NO_C99_FORMAT and OLD_ICONV in
the config.mak file is determined by the capabilities (version)
of your compiler/library. (And is not just a Cygwin issue)

Having said that, I don't really mind if it is added to the Makefile.

All the best,

Ramsay Jones
