From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-fetch per-repository speed issues
Date: Tue, 04 Jul 2006 14:05:27 +0200
Message-ID: <44AA5987.5060206@op5.se>
References: <1151949764.4723.51.camel@neko.keithp.com> <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org> <1151973438.4723.70.camel@neko.keithp.com> <Pine.LNX.4.64.0607032008590.12404@g5.osdl.org> <7vsllinj1m.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0607032039010.12404@g5.osdl.org> <1151987441.4723.110.camel@neko.keithp.com> <44AA4CB0.7020604@op5.se> <20060704111838.GA4285@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 14:06:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxjem-0001tk-JY
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 14:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWGDMF3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 08:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWGDMF3
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 08:05:29 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:42656 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932235AbWGDMF2
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 08:05:28 -0400
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 84D5C6BCC6; Tue,  4 Jul 2006 14:05:27 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
To: Matthias Kestenholz <lists@spinlock.ch>
In-Reply-To: <20060704111838.GA4285@spinlock.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23294>

Matthias Kestenholz wrote:
> * Andreas Ericsson (ae@op5.se) wrote:
> 
>>Keith Packard wrote:
>>
>>>On Mon, 2006-07-03 at 20:40 -0700, Linus Torvalds wrote:
>>>
>>>
>>>
>>>>  "And, it's painfully slow, even when the repository is up to date"
>>>>
>>>>and gave a 17-second time.
>>>
>>>
>>>It's faster this evening, down to 8 seconds using ssh and 4 seconds
>>>using git. I clearly need to force use of the git protocol. Anyone else
>>>like the attached patch?
>>
>>Since it changes the current meaning of ssh+git, I'm not exactly 
>>thrilled. However, "git/ssh" or "ssh/git" would work fine for me. The 
>>slash-separator could be used to say "fetch over this, push over that", 
>>so we can end up with any valid protocol to use for fetches and another 
>>one to push over.
>>
> 
> 
> If we would do such a thing, we would be probably better off
> allowing different URLs for pushing and pulling, because the git and
> ssh URLs will only be the same, if the git repositories are located
> in the root folder and I suspect that's almost never the case.
> 

True. We use relative paths where I work, so for us either way would 
work. Your way is better though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
