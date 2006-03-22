From: Andreas Ericsson <ae@op5.se>
Subject: Re: Question about possible git races
Date: Thu, 23 Mar 2006 00:55:50 +0100
Message-ID: <4421E406.5030700@op5.se>
References: <200603201724.12442.astralstorm@o2.pl> <200603222146.25395.astralstorm@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 00:56:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMDBG-0000B4-MN
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 00:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbWCVXzx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 18:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWCVXzx
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 18:55:53 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:35782 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932421AbWCVXzv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 18:55:51 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 772F76BCFE; Thu, 23 Mar 2006 00:55:50 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Radoslaw Szkodzinski <astralstorm@o2.pl>
In-Reply-To: <200603222146.25395.astralstorm@o2.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17834>

Radoslaw Szkodzinski wrote:
> On Monday 20 March 2006 17:24, Radoslaw Szkodzinski wrote yet:
> 
> Could anyone try to answer the question? 
> I'd really like to know, because it's crucial to my application.
> 

I believe the reasons no-one answered your first mail are, in the 
following order:

1. Since I'm sure you're truly capable of writing such an application 
and finishing it before the git API has changed completely you should 
have gotten your answers from trial-and-error, reading the source, or by 
just trying the app and seeing where it fails.

2. You didn't say *why* you want to write a multi-threaded layer on top 
of git. Is it to implement a redundant file-server with revision 
control? If so you don't need multi-threading. You need clever update 
hooks, a master repo and plenty of bandwidth with fast disks on the 
file-servers.

3. You didn't mention what you've tried to find the answers yourself, 
which makes me think you want me and the rest of us gitizens (yay! I 
coined a phrase) do your homework for you. I personally find it very 
rude that you send another email again so shortly after the first one 
claiming that "you need this info for your app", when the 500-odd people 
you're asking clearly need their time for their families, hobbies, 
daytime jobs, beer, etc. etc...

4. Noone felt like answering since they saw no use for a multi-threaded 
layer on top of git, especially without knowing what it was for. 
Friendliness only goes so far when met by such lack of respect for other 
peoples time, but if someone had seen the uses for the app you're 
writing they probably would have taken time to at least ask you for some 
of the answers you left out in your original mail. If nothing else for 
the sake of curiosity.


Some more pointers on how to get answers to questions posted in online 
forums can be found on the links below.

http://catb.org/~esr/faqs/smart-questions.html
http://www.catb.org/~esr/faqs/hacker-howto.html


Btw. I'm assuming you're aware you'll have to GPL this app of yours, 
since git is GPL and you'll be using the git produce in a way that makes 
it vital to your app.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
