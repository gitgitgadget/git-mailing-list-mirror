From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] git-bundle: assorted fixes
Date: Thu, 22 Feb 2007 21:12:21 -0500
Message-ID: <45DE4D85.3000906@verizon.net>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702221913250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45DE4507.7090206@verizon.net>
 <Pine.LNX.4.63.0702230249340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net, Nicolas Pitre <nico@cam.org>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 23 03:12:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKPvb-0002ny-Rw
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 03:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbXBWCMo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 21:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbXBWCMo
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 21:12:44 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:43299 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbXBWCMn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 21:12:43 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms048.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDW0034I8SHILLA@vms048.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 22 Feb 2007 20:12:20 -0600 (CST)
In-reply-to: <Pine.LNX.4.63.0702230249340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40408>

Johannes Schindelin wrote:
> Hi,
>   
>> 1) git bundle create --all  <whatever>
>>     
>
> Are you sure you did not provide a bundle filename?
>   
I did, you *have* to give a bundle filename..
> But indeed, my test shows that "--all" does not leave any refs. Bad.
>
> This fixes it:
>   
Confirmed - that works.
>  
>   
>> 2) git bundle verify  reports only a single sha1 if prerequisites are not
>> met.
>>     
>
> With the two follow-up patches I sent, this issue should be resolved, no?
>
> Ciao,
> Dscho
>
>   
I missed one of your patches, adding that, the problem is incompletely 
fixed: all missing commits are shown, but only as raw hashes (e.g., the 
1-line commit message is not there to describe what is missing).

Mark
