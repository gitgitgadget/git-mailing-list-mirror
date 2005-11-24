From: Andreas Ericsson <ae@op5.se>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Thu, 24 Nov 2005 09:05:04 +0100
Message-ID: <43857430.7060103@op5.se>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org> <200511210026.30280.Josef.Weidendorfer@gmx.de> <200511221831.03954.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de> <438371E8.2030701@op5.se> <Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de> <7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se> <Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 09:06:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfC6l-0003Sx-LS
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 09:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbVKXIFH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 03:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbVKXIFH
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 03:05:07 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:42644 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1161051AbVKXIFF
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 03:05:05 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id A2F046BCBE; Thu, 24 Nov 2005 09:05:04 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12691>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 24 Nov 2005, Andreas Ericsson wrote:
> 
> 
>>git-repo-config is way friendlier for us poor lazy folks. That last 'y' in
>>"repository" really breaks the flow.
> 
> 
> How about "git-local-config"?
> 

Nah. It would really mess things up if there's ever such a thing as a 
real local config (ie, ~/.gitrc).

git-config-set handles configuration for a particular repo, so 
git-repo-config is better, IMO.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
