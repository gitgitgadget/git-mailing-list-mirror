From: Andreas Ericsson <ae@op5.se>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
 repositories?
Date: Mon, 12 Nov 2007 20:17:17 +0100
Message-ID: <4738A6BD.50704@op5.se>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br> <Pine.LNX.4.64.0711121355380.4362@racer.site> <200711121719.54146.wielemak@science.uva.nl> <Pine.LNX.4.64.0711121624330.4362@racer.site> <vpq3avbv2ju.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121715090.4362@racer.site> <alpine.LFD.0.9999.0711121231150.21255@xanadu.home> <Pine.LNX.4.64.0711121751100.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 20:17:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iremw-0006Wr-JI
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 20:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbXKLTRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 14:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753039AbXKLTRX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 14:17:23 -0500
Received: from mail.op5.se ([193.201.96.20]:45878 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbXKLTRW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 14:17:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id BA7A11F08763;
	Mon, 12 Nov 2007 20:17:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4SO7bKGbKp9v; Mon, 12 Nov 2007 20:17:19 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id E8A6D1F08760;
	Mon, 12 Nov 2007 20:17:18 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0711121751100.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64689>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 12 Nov 2007, Nicolas Pitre wrote:
> 
>> On Mon, 12 Nov 2007, Johannes Schindelin wrote:
>>
>>> On Mon, 12 Nov 2007, Matthieu Moy wrote:
>>>
>>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>>
>>>>> On Mon, 12 Nov 2007, Jan Wielemaker wrote:
>>>>>
>>>>>> I found out that cloning a empty bare repository produces nothing 
>>>>>> at all, [...]
>>>>> If they are empty, what exactly do you mean to clone?
>>>> I'd expect an empty repository, with the git remote configured 
>>>> correctly.
>>> Yeah, right.
>>>
>>> Last time I checked, those geneticists did not clone thin air.  They 
>>> always waited until they had something to clone.
>> But we're not geneticists, and I think the above usage should "just work 
>> (tm)".
> 
> I am still convinced that it is not very intelligent to start your 
> development from a non-existing branch.
> 

That's what happens with every new project though. The question is if
something starts with making space for things to be in, or if it starts
with things appearing in that space.

> But since you're one of the people knowing git _internals_ pretty well, 
> here's another reason just for you why this cannot be done: There is no 
> way to find out where the HEAD points to.
> 

$ mkdir foo; cd foo; git init; git symbolic-ref -q HEAD
refs/heads/master

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
