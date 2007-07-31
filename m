From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Add a --user option to git-config
Date: Tue, 31 Jul 2007 22:54:05 +0100
Message-ID: <46AFAF7D.7010306@ramsay1.demon.co.uk>
References: <46AB7041.8070605@ramsay1.demon.co.uk> <Pine.LNX.4.64.0707282103150.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 01 20:11:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGIfn-00050A-IS
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 20:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbXHASLr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 14:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbXHASLr
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 14:11:47 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:3922 "EHLO
	anchor-post-34.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751147AbXHASLq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 14:11:46 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-34.mail.demon.net with esmtp (Exim 4.42)
	id 1IGIfg-00042m-FT; Wed, 01 Aug 2007 18:11:45 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <Pine.LNX.4.64.0707282103150.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54459>

Johannes Schindelin wrote:
> On Sat, 28 Jul 2007, Ramsay Jones wrote:
> 
>> At present, the --global option is something of a misnomer, so
>> we introduce the --user option as a synonym, with the intention
>> of removing the old option in the future.
> 
> Ack for the intention, except for "removing the old option in the future".  
> We do not need to advertise it, but breaking existing functionality, which 
> might be used by scripts and aliases is bad.
> 

Yep, which is why I made it a synonym; git-gui uses the --global option, for
example, and I'm confident that other (user) scripts use it too. The "future"
I had in mind was something like 1 year down the road, but it could be longer
(or forever) if necessary.

Ramsay Jones
