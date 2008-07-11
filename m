From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Should we discuss Windows-related changes on
 git@vger.kernel.org?
Date: Fri, 11 Jul 2008 18:24:16 +0200
Message-ID: <A065AF71-5685-423A-9F87-5349ADC6C9C9@zib.de>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de> <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness> <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de> <alpine.DEB.1.00.0807111652170.8950@racer>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, Junio C Hamano <gitster@pobox.com>, msysGit <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Jul 11 18:25:12 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.27])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHLQc-0000Sm-TA
	for gcvm-msysgit@m.gmane.org; Fri, 11 Jul 2008 18:25:03 +0200
Received: by yw-out-2122.google.com with SMTP id 8so3666764yws.63
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2008 09:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:in-reply-to:subject:references:message-id
         :content-type:content-transfer-encoding:mime-version:date:cc
         :x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=B7F7ijrtbjK5qRapvu80PIS5MCHYvJfKndmHvqCtAvM=;
        b=Y0S/cQ/S7/WLxIdQFlMIzWkol6VHHzxeDCVnz3uZnhfpJSH/63RG8oLsuEVY+hRJXG
         YH6949iqsFMjdo10acBMQ8LVMrkct1HaMYNAjIvDVGM+vteCd1SZqJGPTTqb4N2hP/kZ
         bK2qc8dJX1LZ0w2ARYSeAm2Ny/H7BO6MzfFNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        b=Uc5cCMAD1M9SYn6I8ZNpv4IW/9NOJ75KJJl9JGwwGqXAv+OUamr9qmtXJ48y4gHJl/
         JIVyG4+rMPwKtAD0Kbxcl8bM4zW8CFVQW3PVHQRncOGlokNZ7GwTRV6rQlHR6wwcTZCn
         cs7st6P0mvI9Aa8vBdwLAjl+8rktCocuhNvHY=
Received: by 10.150.49.11 with SMTP id w11mr313835ybw.20.1215793442897;
        Fri, 11 Jul 2008 09:24:02 -0700 (PDT)
Received: by 10.107.13.30 with SMTP id q30gr2675pri.0;
	Fri, 11 Jul 2008 09:24:02 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.185.8 with SMTP id i8mr6405225waf.11.1215793442049; Fri, 11 Jul 2008 09:24:02 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 39si884522yxd.0.2008.07.11.09.24.01; Fri, 11 Jul 2008 09:24:01 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6BGNo7x024373; Fri, 11 Jul 2008 18:23:55 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db9309a.pool.einsundeins.de [77.185.48.154]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6BGNnto003095 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Fri, 11 Jul 2008 18:23:49 +0200 (MEST)
In-Reply-To: <alpine.DEB.1.00.0807111652170.8950@racer>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88141>



On Jul 11, 2008, at 5:57 PM, Johannes Schindelin wrote:

> On Fri, 11 Jul 2008, Steffen Prohaska wrote:
>
>> On Jul 11, 2008, at 1:56 PM, Johannes Schindelin wrote:
>>
>>> On Fri, 11 Jul 2008, Steffen Prohaska wrote:
>>>
>>>> I decided to stop queuing changes in 4msysgit.  Instead I'd like to
>>>> bring the diff between Junio's and 4msysgit's master to zero.  This
>>>> seems to be achievable after Junio merged Hannes' MinGW changes.
>>>>
>>>> I think all Windows-related changes to the git code base could be
>>>> discussed directly on the main git list and the msysgit list  
>>>> would be
>>>> reserved for the MinGW/MSYS runtime environment and the installer.
>>>
>>> I disagree.  Judging from the mails I read on the git list, Junio  
>>> gets
>>> really swamped by patches these days (what with our very  
>>> productive GSoC
>>> students).
>>
>> Sending the patches to the git list does not necessarily mean that
>> they are directly addressed to Junio.  We discuss JGIT, EGIT, gitk,
>> and git gui patches on the list too.  AFAIK, none of them are applied
>> by Junio directly but by the respective maintainers.  We could handle
>> Windows-related patches similarly.
>
> Then what is the msysGit list about?

I think the msysGit list could be useful for:

  - Everything that is in the msysgit repo, i.e. the MinGW/MSYS
    runtime environment and the installers.

  - User questions, including the issue tracker.


> No, I really disagree.  Windows support is too large a thing, and  
> partly a
> too disgusting one to bother the git list.

My understanding is that the mainline of git starts supporting the MinGW
port with version 1.6.0.  The MinGW port is merged to Junio's master, so
the remaining differences between Junio's master and 4msysgit's master
should be removed and afterwards new changes should be discussed,  
improved,
and applied to Junio's master anyway.  This would also allow to directly
test Junio's next on Windows.


>>> I really think that we should discuss the patches on the msysGit  
>>> list
>>> first, whip them into shape, and then send them off.
>>>
>>> Just think of those patches that were sent off, only to realize that
>>> they were no longer needed.  That should not have happened.
>>
>> I intentionally sent the patches to show and discuss the differences
>> between the state of the MinGW port in Junio's master and in  
>> 4msysgit.
>> Some of the patches could be reverted in 4msysgit.  But, at least one
>> patch was unrelated to MinGW and is now in master.  Some other  
>> patches
>> need more work and are currently improved.  I think this was not a  
>> waste
>> of time.
>
> IMO we could have discussed first what is the current state on the  
> msysGit
> list, and I would have commented there already on the patches that I  
> think
> would no longer be needed.
>
> Then the patch would have been sent off, and be in master, too.
>
> The difference: it would have been more efficient.  Those people who  
> can
> test if something is still needed on Windows are on the msysGit list.
>
> We do not really need to clutter git@vger more than necessary.

But git 1.6 will contain the MinGW port.  Shouldn't related patches
then be discussed on git@vger?

	Steffen
