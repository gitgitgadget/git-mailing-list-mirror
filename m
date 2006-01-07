From: Andreas Ericsson <ae@op5.se>
Subject: Re: Does git belong in root's $PATH?
Date: Sat, 07 Jan 2006 19:03:06 +0100
Message-ID: <43C0025A.9080406@op5.se>
References: <Pine.LNX.4.64.0601070838470.6317@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 19:03:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvIPa-0006HV-6s
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 19:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030520AbWAGSDJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 13:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbWAGSDJ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 13:03:09 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:44929 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030520AbWAGSDH
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 13:03:07 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 713FC6BCBE; Sat,  7 Jan 2006 19:03:06 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <Pine.LNX.4.64.0601070838470.6317@x2.ybpnyarg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14264>

walt wrote:
> When updated my kernel this morning, the same way I've been doing
> it for many months, I noticed that the -gxxxxxxx localversion
> string was missing from the new kernel's name.
> 
> I finally figured out that this happened because /usr/local/bin
> is not in my root's $PATH, and the setlocalversion script depends
> on git.  (The only thing I do as root is 'make install').
> 
> I suppose I'm asking a philosophical question here:  do you
> guys install git where root can find it (as a system tool)?


I install it in /usr/bin. I don't *use* the git-tools as root though, so 
I don't feel there's anything to worry about (well, at least no more 
than for the other 2847 programs living in my $PATH).


> Does it really matter?


Theoretically, yes, but only if someone can trick you to, as root, doing 
something with git which triggers some yet undiscovered bug and makes it 
run code it was never meant to.


>  (The linux distribution I use is very
> picky about what it includes in root's path...)
> 

Not including /usr/local/{bin,sbin} in root's path is considered wise, 
since, historically, that's where users would install their own versions 
of programs that the system doesn't provide. This use has largely been 
obsoleted by $HOME/bin as the default for user-specific programs, mainly 
because of disks getting larger and cheaper.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
