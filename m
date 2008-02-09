From: Andreas Ericsson <ae-n0Zl8IkGad4@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Sat, 09 Feb 2008 10:25:37 +0100
Message-ID: <47AD7191.3040209@op5.se>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LFD.1.00.0802070949460.2732@xanadu.home>
Reply-To: ae-n0Zl8IkGad4@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>,  Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>,  Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
To: Nicolas Pitre <nico-mo2vmkxb4K0@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sat Feb 09 10:26:18 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.248])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNlyS-0004Pk-PK
	for gcvm-msysgit@m.gmane.org; Sat, 09 Feb 2008 10:26:17 +0100
Received: by wa-out-0708.google.com with SMTP id n36so8369637wag.21
        for <gcvm-msysgit@m.gmane.org>; Sat, 09 Feb 2008 01:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:x-virus-scanned:x-spam-flag:x-spam-score:x-spam-level:x-spam-status:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=FHj0BMzWKWrUqjGyXAKah9lqrPgDOqA4CwmXEmycnf8=;
        b=qu/AyVAOXBJBRB/9MAqppdq/H51iRPfhRBlhAVg6323GLST9JQ1NO5N0BNqJz/aag3sxShQhW68ZqVGFDW7GWw0DasZ9gQcUdW2nUHmSo3klHGpIyo3pRsd+x3oWLXsBTaJXDcq7BJWqAFd1NBJ0tq0MUn5k3QZr9Y1LuzoA7YA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-virus-scanned:x-spam-flag:x-spam-score:x-spam-level:x-spam-status:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=OxQwmcN9NX4SgJrEGGHuIb0BRF81v0aHW+k3C2Of0G76CFh3B4D4tAKJ+x7r1VCDPLHSJ55ON6Mb/rmADeOl/GGrIsgl0ikYzssXBHMLFQq2sYvOx6qoDd+xhVwwEnXZuGTE6RhmWVG907AqhF2oSPchk8YYqNeB0P1xUmGJCJs=
Received: by 10.114.57.1 with SMTP id f1mr939047waa.5.1202549143918;
        Sat, 09 Feb 2008 01:25:43 -0800 (PST)
Received: by 10.106.159.22 with SMTP id h22gr1690pre;
	Sat, 09 Feb 2008 01:25:43 -0800 (PST)
X-Sender: ae-n0Zl8IkGad4@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.13.4 with SMTP id q4mr28436244pyi.7.1202549143224; Sat, 09 Feb 2008 01:25:43 -0800 (PST)
Received: from mail.op5.se (mail.op5.se [193.201.96.20]) by mx.google.com with ESMTP id x46si850179pyg.3.2008.02.09.01.25.41; Sat, 09 Feb 2008 01:25:43 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of ae-n0Zl8IkGad4@public.gmane.org designates 193.201.96.20 as permitted sender) client-ip=193.201.96.20;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of ae-n0Zl8IkGad4@public.gmane.org designates 193.201.96.20 as permitted sender) smtp.mail=ae-n0Zl8IkGad4@public.gmane.org
Received: from localhost (localhost.localdomain [127.0.0.1]) by mail.op5.se (Postfix) with ESMTP id 2C96A1F0801E; Sat,  9 Feb 2008 10:25:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6 tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1]) by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 5LHTec--CQaP; Sat,  9 Feb 2008 10:25:39 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.26]) by mail.op5.se (Postfix) with ESMTP id 04D521F0800A; Sat,  9 Feb 2008 10:25:38 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <alpine.LFD.1.00.0802070949460.2732-QuJgVwGFrdf/9pzu0YdTqQ@public.gmane.org>
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73202>


Nicolas Pitre wrote:
> On Thu, 7 Feb 2008, Luciano Rocha wrote:
> 
>> On Thu, Feb 07, 2008 at 12:55:58PM +0000, Johannes Schindelin wrote:
>>> Hi,
>>>
>>> On Thu, 7 Feb 2008, Luciano Rocha wrote:
>>>
>>>> Why do I have to accept the GPL to install msysgit?
>>> Because that's the only license you have to use git.
>> Again, GPL governs distribution, not use.
>>
>>> Get over it, or use another SCM,
>> I like and use GPL, but I won't force my users to accept the GPL in
>> order to use programs released under it.
> 
> What are they forced into if they indeed only want to _use_ Git?
> 
> They nevertheless must be made aware of the rules they have to follow in 
> case the idea of redistributing it crosses their mind.
> 

No, because redistributing software is always illegal unless explicitly
permitted. The GPL explicitly permits it, so they have to find that
piece of license, read it, determine "oh this is ok then" and then go
ahead and email it to their friends.

Seriously though, the only thing I expect nobody would want to is
that some company starts distributing git as their own scm, under a
different license and probably closed-source too. EFF can provide
lawyer help for such cases. Such a company would obviously read the
license and realise that it's impossible for them to do so.

-- 
Andreas Ericsson                   andreas.ericsson-n0Zl8IkGad4@public.gmane.org
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
