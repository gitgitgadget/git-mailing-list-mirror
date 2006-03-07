From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-status too verbose?
Date: Tue, 07 Mar 2006 10:19:58 +0100
Message-ID: <440D503E.8090007@op5.se>
References: <38b80e980603040952j15152a21h2c903bd011d7e905@mail.gmail.com> <7vacc36r4v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Jaffe <jaffe.eric@gmail.com>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 10:20:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGYMR-0006Pf-Cq
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 10:20:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbWCGJUB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 04:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752109AbWCGJUB
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 04:20:01 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:17590 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1752078AbWCGJUA
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 04:20:00 -0500
Received: from [192.168.1.20] (unknown [192.168.1.20])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 09B7C6BD14; Tue,  7 Mar 2006 10:19:59 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacc36r4v.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17326>

Junio C Hamano wrote:
> 
> Why do people think mysterious single letter abbreviation is
> better than spelled out words in an output meant for human
> consumption?
> 

Familiarity, I suspect.

> 
> I agree that it would be useful if we had a tool that showed the
> two status that matter for each file, grouped together on one
> line, e.g.
> 
> 			HEAD->index	index->files
> 	------------------------------------------------
> 	hello.c		unmodified      modified
>         world.c		modified	unmodified
> 	frotz.c		new		unmodified
>         ...
> 	garbage.c~	???		n/a
> 
> for the current index file and the current HEAD commit.
> 

Could we have 'same' or some such instead of 'unmodified'? It's a bit 
close to 'modified' for the eye to find it quickly.


> You obviously need to learn how to read it though.  The first
> column means what you _would_ commit if you just said "git
> commit" without doing anything else now; the second column is
> what you _could_ commit if you did some update-index and then
> said "git commit" (or ran "git commit" with paths arguments).
> 

Pretty-printing will be easier if the filename is last, and it will look 
a lot neater if all columns are aligned.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
