From: martin <martin@siamect.com>
Subject: Re: is gitosis secure?
Date: Sun, 14 Dec 2008 18:02:57 +0700
Message-ID: <4944E7E1.2030907@siamect.com>
References: <200812090956.48613.thomas@koch.ro> <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com> <87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org> <alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm> <4944D4F7.7050501@siamect.com> <alpine.DEB.1.10.0812140304320.17688@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Dec 14 12:04:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBolu-0000ce-JB
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 12:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbYLNLDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 06:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbYLNLDB
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 06:03:01 -0500
Received: from smtp4.ksc.net.th ([203.107.129.14]:6595 "EHLO smtp4.ksc.net.th"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591AbYLNLDB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 06:03:01 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApcBAMB2REl8eO3f/2dsb2JhbAAIjB6GB7wHgn4
X-IronPort-AV: E=Sophos;i="4.36,218,1228064400"; 
   d="scan'208";a="94549248"
Received: from ppp-124-120-237-223.revip2.asianet.co.th (HELO [192.168.0.200]) ([124.120.237.223])
  by smtp4.ksc.net.th with ESMTP; 14 Dec 2008 18:02:58 +0700
User-Agent: Thunderbird 2.0.0.17 (X11/20081017)
In-Reply-To: <alpine.DEB.1.10.0812140304320.17688@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103064>



david@lang.hm wrote:
> On Sun, 14 Dec 2008, martin wrote:
>
>> Dear David.
>> Why do you trust VPN more than the SSH?
>> I ask because I have just removed the "first VPN then SSH" solution 
>> in favor for a SSH only solution using Gitosis just to get rid of the 
>> VPN which I believe is less secure than SSH (well until I read you 
>> comments below).
>> I thought I was doing something right for once but maybe I'm not?
>> Thanks and best regards
>> Martin
>
> in part it's that a VPN is a single point of control for all remote 
> access.
>
> If you use ssh you end up exposing all the individual machines
>
> 1. data leakage of just what machines exist to possibly hostile users.
>
> 2. the many machines are configured seperatly, frequently by different 
> people. this makes it far more likely that sometime some machine will 
> get misconfigured.
>
> 3. people who are focused on providing features have a strong 
> temptation to cut corners and just test that the feature works and not 
> test that everything that isn't supposed to work actually doesn't 
> work. as a result, in many companies there is a deliberate seperation 
> (and tension) between a group focused on controlling and auditing 
> access and one that is focused on creating fucntionality and features.
>
> also from a polical/social point of view everyone recognises that if 
> you grant someone VPN access you are trusting them, but people don't 
> seem to think the same way with ssh.
>
> David Lang
>

I opened port 22 in the firewall to just those hosts that I need to 
reach, which is one in this case...the rest of the machines I cannot reach.
I did a brief port scan and the thing is silent... so I don't think I 
reveal any of the other hosts... but I should not say is it's secure 
with your measures...

Your point two I don't understand...   If you are in charge of the 
firewall you also know what machines you let people reach. If these 
machines are numerous then I think there is a management problem 
somewhere else...


Point 3 is correct but I fail to see how this is less of a problem with 
VPN than SSH.

Thanks and Best regards
Martin
