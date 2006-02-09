From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add git-annotate - a tool for annotating files with the
 revision and person that created each line in the file.
Date: Thu, 09 Feb 2006 13:47:00 +0100
Message-ID: <43EB39C4.3020309@op5.se>
References: <11394103753694-git-send-email-ryan@michonline.com>	 <cda58cb80602080835s38713193t@mail.gmail.com>	 <86ek2dsn5f.fsf@blue.stonehenge.com> <43EB093A.1060207@op5.se>	 <7vek2cetxh.fsf@assigned-by-dhcp.cox.net> <cda58cb80602090404o4e753839g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 13:47:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7BCy-0008EW-9a
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 13:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422907AbWBIMrE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 07:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422905AbWBIMrE
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 07:47:04 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:63398 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1422908AbWBIMrD
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 07:47:03 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id E7F276BD0E; Thu,  9 Feb 2006 13:47:00 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80602090404o4e753839g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15811>

Franck Bui-Huu wrote:
> 2006/2/9, Junio C Hamano <junkio@cox.net>:
> 
>>Andreas Ericsson <ae@op5.se> writes:
>>
>>
>>>So long as we never involve ruby, java or DCL, I'm a happy fellow.
>>
>>Wholeheartedly seconded ;-).
>>
> 
> 
> I agree to but my point was more why not only using python scripts ?
> Why sometimes some scripts is written in perl whereas python could be
> used and vice-versa ?
> 

Perl is better suited for some tasks, Python for others. Mostly it's 
because the contributor (one out of 137 to date) thought the language 
appropriate for the tool he/she set out to write and felt comfortable 
with it.

I personally abhor the syntax of Perl and the block indentation of 
Python but I happily embrace both if the alternative is to rewrite all 
the script tools in C.

That said, some tools have been rewritten in the past (mostly scripts 
have been replaced by C code versions), but I don't think Junio will 
accept replacement tools just because they're in one particular 
language. If anything, it would be to replace the two python scripts 
with Perl versions, since more tools are implemented in Perl than in 
Python (so we could drop one dependency), Perl exists on more platforms 
(so git becomes more portable), and Perl is used inline in four of the 
shell-scripts (which means we can't get rid of the Perl dependency 
without major hackery anyway).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
