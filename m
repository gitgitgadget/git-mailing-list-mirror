From: Andreas Ericsson <ae@op5.se>
Subject: Re: what is "rebase"?
Date: Sun, 20 Nov 2005 03:12:27 +0100
Message-ID: <437FDB8B.8030707@op5.se>
References: <86fyps8bl1.fsf@blue.stonehenge.com>	<Pine.LNX.4.63.0511200214280.11653@wbgn013.biozentrum.uni-wuerzburg.de> <86psow6pxl.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 03:12:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edegy-0007Ys-7o
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 03:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVKTCM3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 21:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVKTCM3
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 21:12:29 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:62184 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751156AbVKTCM3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 21:12:29 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 32C516BD19; Sun, 20 Nov 2005 03:12:28 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86psow6pxl.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12366>

Randal L. Schwartz wrote:
> Is this what I would use if I want to discard history except for
> major milestones?
> 

No.

> Still not sure what "cherry-pick" is either. And that's *not*
> in the glossary. :)
> 

man git-cherry-pick

> I'm just worried about my archive getting bigger and bigger and
> having lots of junk in it that I can't get rid of.
> 

If you do experimental development on a branch and want to throw stuff 
away (commits, tags, whatnot), you should run "git-reset". It can bring 
any combination of index and working tree back to any commit in the 
history of that branch.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
