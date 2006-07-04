From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-fetch per-repository speed issues
Date: Tue, 04 Jul 2006 13:10:40 +0200
Message-ID: <44AA4CB0.7020604@op5.se>
References: <1151949764.4723.51.camel@neko.keithp.com>	 <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org>	 <1151973438.4723.70.camel@neko.keithp.com>	 <Pine.LNX.4.64.0607032008590.12404@g5.osdl.org>	 <7vsllinj1m.fsf@assigned-by-dhcp.cox.net>	 <Pine.LNX.4.64.0607032039010.12404@g5.osdl.org> <1151987441.4723.110.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 13:11:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxinx-0001u9-Rx
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 13:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWGDLKm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 07:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWGDLKm
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 07:10:42 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:53663 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751266AbWGDLKm
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 07:10:42 -0400
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 932EF6BCC6; Tue,  4 Jul 2006 13:10:40 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1151987441.4723.110.camel@neko.keithp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23282>

Keith Packard wrote:
> On Mon, 2006-07-03 at 20:40 -0700, Linus Torvalds wrote:
> 
> 
>>    "And, it's painfully slow, even when the repository is up to date"
>>
>>and gave a 17-second time.
> 
> 
> It's faster this evening, down to 8 seconds using ssh and 4 seconds
> using git. I clearly need to force use of the git protocol. Anyone else
> like the attached patch?

Since it changes the current meaning of ssh+git, I'm not exactly 
thrilled. However, "git/ssh" or "ssh/git" would work fine for me. The 
slash-separator could be used to say "fetch over this, push over that", 
so we can end up with any valid protocol to use for fetches and another 
one to push over.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
