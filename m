From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Should we discuss Windows-related changes on
 git@vger.kernel.org?
Date: Fri, 11 Jul 2008 23:10:12 +0200
Message-ID: <0E93411E-745C-4858-999E-F0B7487B48B1@zib.de>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de> <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness> <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de> <alpine.DEB.1.00.0807111652170.8950@racer> <A065AF71-5685-423A-9F87-5349ADC6C9C9@zib.de> <alpine.DEB.1.00.0807111930160.8950@racer> <alpine.LFD.1.10.0807111159560.2936@woody.linux-foundation.org> <alpine.DEB.1.00.0807112037220.8950@racer>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Sixt <johannes.sixt@telecom.at>, Junio C Hamano <gitster@pobox.com>, msysGit <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Jul 11 23:11:27 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHPtU-0004Rd-04
	for gcvm-msysgit@m.gmane.org; Fri, 11 Jul 2008 23:11:08 +0200
Received: by yw-out-2122.google.com with SMTP id 8so3799351yws.63
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2008 14:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:in-reply-to:subject:references:message-id
         :content-type:content-transfer-encoding:mime-version:date:cc
         :x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=BIFCITJgEqrV06k6VA6Qvyr4udO2/W7hNqgiBHpK2ug=;
        b=SSmqbV3I9wdZv40DdFHwZ/6BB5KKFw7aURXTIv3j9eqe/HtFUmr7HsWdgmcOpmydAy
         U9k59hnu+Gb+iTNTf6fz1BLjtUcP/ZzjJr9UfDVOZrHqaLZ6hYnlSSg8Xqeyj9CcjSud
         XIucSEwZZIXHj769ETFRS/kS8ANBqsTTIYpjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        b=w0LpyOjKOV7Chdi11xLf3kXJ2TjDp3kH4U8hycr5KRMSkBs5mc4wIuEzSA/eUzuJhj
         bdiiuQj8eHLI0pdWsqnl8Vr7XMojvHvabYzVGomk9qJkCtwjUKKOE0kzHYbAtUY1059D
         SrpJ5dIpgXyduqMJ+CcJF6PTPXRNGV58wlFZg=
Received: by 10.150.11.6 with SMTP id 6mr334941ybk.1.1215810607891;
        Fri, 11 Jul 2008 14:10:07 -0700 (PDT)
Received: by 10.107.13.30 with SMTP id q30gr2680pri.0;
	Fri, 11 Jul 2008 14:10:07 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.202.15 with SMTP id z15mr6638165waf.22.1215810606288; Fri, 11 Jul 2008 14:10:06 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 22si1254228yxr.2.2008.07.11.14.10.05; Fri, 11 Jul 2008 14:10:06 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6BL9qW7023817; Fri, 11 Jul 2008 23:09:59 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db9309a.pool.einsundeins.de [77.185.48.154]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6BL9jJx005105 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Fri, 11 Jul 2008 23:09:46 +0200 (MEST)
In-Reply-To: <alpine.DEB.1.00.0807112037220.8950@racer>
X-Mailer: Apple Mail (2.926)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88175>



On Jul 11, 2008, at 9:40 PM, Johannes Schindelin wrote:

> On Fri, 11 Jul 2008, Linus Torvalds wrote:
>
>> - It may well be good to explain to the _real_ git people (eg me)  
>> what
>>   the problems in Windows land are, so that we get a first-hand view
>>   into hell, and can maybe take it into account when we make changes
>>   for other things.
>
> Wow.  I did not think that you were a masochist.
>
>> IOW, I think that since 1.6.0 is supposed to have native support for
>> windows, we should have patches discussed on the regular git list.  
>> The
>> ghetto that is windows can be useful for _user_ discussions, where  
>> a lot
>> of the core git people simply cannot help. But having development
>> discussions there is bad, I think.
>
> We do have development discussions there that do not belong to  
> git@vger.
> For example, when Hannes reimplemented the utterly broken spawn()
> implementation of Microsoft's "Run" time library.
>
> That is not something you need to see, want to see, or can help with.

The separation is not always that clear.  For example, the discussion
of issue 130 might benefit from "a first-hand view into hell", see

http://thread.gmane.org/gmane.comp.version-control.msysgit/2653/focus=2682


Another example is the discussion about GIT_EXEC_PATH, see

http://thread.gmane.org/gmane.comp.version-control.msysgit/2633

It might be triggered by msysGit's need to freely move a git  
installation
in the filesystem.  The resulting feature might however be interesting  
on
other platforms, too.


A last example is the crash of gitk that was observed on Windows and is
now buried in the msysGit issue tracker, although I am pretty sure that
is it not windows-specific, see

http://code.google.com/p/msysgit/issues/detail?id=125



> Likewise, I think it has nothing to do with the git@vger list when  
> we add
> work-arounds until some better solution is found, and then discuss  
> whether
> the workaround is still needed.
>
> I cannot help to see the benefit, at least.
>
> Once things are sorted out, I agree, it has to be sent to the git  
> list.
>
> Before that, however, allow us to work on another list.

Personally, I'd find it easier to work on a single list.  MinGW support
is mature enough and workarounds should now be avoid.  If we tested git
during the official release cycle, we would have sufficient time to find
and solve problems on Windows and prepare patches that have sufficient
quality to be discuss on git@vger.

	Steffen
