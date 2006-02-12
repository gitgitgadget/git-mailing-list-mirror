From: Andreas Ericsson <ae@op5.se>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Sun, 12 Feb 2006 04:43:47 +0100
Message-ID: <43EEAEF3.7040202@op5.se>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>	 <7vwtg2o37c.fsf@assigned-by-dhcp.cox.net>	 <Pine.LNX.4.64.0602110943170.3691@g5.osdl.org> <1139685031.4183.31.camel@evo.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Feb 12 04:43:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F889Q-0002es-46
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 04:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWBLDnt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 22:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWBLDnt
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 22:43:49 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:13252 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750875AbWBLDns
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 22:43:48 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id AFA5B6BD01; Sun, 12 Feb 2006 04:43:47 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1139685031.4183.31.camel@evo.keithp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15977>

Keith Packard wrote:
> On Sat, 2006-02-11 at 09:45 -0800, Linus Torvalds wrote:
> 
> 
>>More importantly, it really wouldn't have helped that much in this 
>>situation. At least for me, the network is 90% of the problem, the 
>>pack-file generation is at most 10%. So cached packfiles really only 
>>matter for server-side problems (high CPU load, or lack of memory, or 
>>heavy disk activity).
> 
> 
> I'd like to see git use less CPU than CVS does on my distribution host;
> some mechanism for re-using either existing or cached packs would help a
> whole lot with that. The alternative is to see people switch to rsync
> instead, which seems like a far worse idea.   
> 

A weird oddity; Cloning is faster over rsync, day-to-day pulling is not.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
