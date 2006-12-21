From: Jay Cliburn <jacliburn@bellsouth.net>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Wed, 20 Dec 2006 21:21:02 -0600
Message-ID: <4589FD9E.2010000@bellsouth.net>
References: <4589F9B1.2020405@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Thu Dec 21 08:00:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxHuh-0001HR-KO
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 08:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422773AbWLUHAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 02:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422776AbWLUHAU
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 02:00:20 -0500
Received: from imf24aec.mail.bellsouth.net ([205.152.59.72]:35132 "EHLO
	imf24aec.mail.bellsouth.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422773AbWLUHAU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Dec 2006 02:00:20 -0500
X-Greylist: delayed 13155 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 02:00:19 EST
Received: from ibm66aec.bellsouth.net ([74.227.55.135])
          by imf23aec.mail.bellsouth.net with ESMTP
          id <20061221032103.BOPJ13824.imf23aec.mail.bellsouth.net@ibm66aec.bellsouth.net>
          for <git@vger.kernel.org>; Wed, 20 Dec 2006 22:21:03 -0500
Received: from [192.168.1.3] (really [74.227.55.135])
          by ibm66aec.bellsouth.net with ESMTP
          id <20061221032103.MTM29829.ibm66aec.bellsouth.net@[192.168.1.3]>;
          Wed, 20 Dec 2006 22:21:03 -0500
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
To: git@vger.kernel.org
In-Reply-To: <4589F9B1.2020405@garzik.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35020>

Jeff Garzik wrote:
> I refreshed my git intro/cookbook for kernel hackers, at 
> http://linux.yyz.us/git-howto.html
> 
> This describes most of the commands I use in day-to-day kernel hacking. 
>  Let me know if there are glaring errors or missing key commands.

Thanks for doing this.  I've referred to your previous page rather often 
as I grope around trying to learn git and hack a vendor driver for 
submittal into the mainline kernel.

One thing that baffled me was how to use git to create a "kitchen sink" 
diff that would produce my entire driver suitable for submittal to lkml 
for review.  This probably isn't needed very often, but for new driver 
submittals it's important to know how to do it.  Francois Romieu showed 
me how (assume the new driver branch is named "driver"):

$ git diff $(git merge-base master driver)..driver

As a beginner, this command continues to be utterly non-intuitive to me, 
but it works.  There may be other ways to do it, too.

The point is, I think you should add instructions on your cookbook that 
address how to produce such a "kitchen sink" diff if you're submitting a 
brand new driver to lkml.  (Obviously I don't know what such a diff is 
actually called.)

Jay
