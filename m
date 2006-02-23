From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 23 Feb 2006 14:29:48 +0100
Message-ID: <43FDB8CC.5000503@op5.se>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>	 <20060221215742.GA5948@steel.home> <43FB9656.8050308@vilain.net>	 <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>	 <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>	 <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>	 <7vwtfmihts.fsf@assigned-by-dhcp.cox.net>	 <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com>	 <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com>	 <43FD84EB.3040704@op5.se> <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 14:30:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCGXZ-000441-9D
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 14:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWBWN3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 08:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWBWN3u
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 08:29:50 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:41857 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751373AbWBWN3t
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 08:29:49 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 4FB2C6BCBE; Thu, 23 Feb 2006 14:29:48 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16645>

Alex Riesen wrote:
> On 2/23/06, Andreas Ericsson <ae@op5.se> wrote:
> 
>>Not to be unhelpful or anything, but activestate perl seems to be quite
>>a lot of bother. Is it worth supporting it?
> 
> 
> It's not activestate perl actually. It's only one platform it also
> _has_ to support.
> Is it worth supporting Windows?


With or without cygwin? With cygwin, I'd say "yes, unless it makes 
things terribly difficult to maintain and so long as we don't take 
performance hits on unices". Without cygwin, I'd say "What? It runs on 
windows?".

If we claim to support windows but do a poor job of it, no-one else will 
start working on a windows-port. If we don't claim to support windows 
but say that "it's known to work with cygwin, although be aware of these 
performance penalties...", eventually someone will come along with their 
shiny Visual Express and hack up support for it, even if some tools will 
be missing and others unnecessarily complicated.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
