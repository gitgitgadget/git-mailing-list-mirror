From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Should we discuss Windows-related changes on
 git@vger.kernel.org?
Date: Sat, 12 Jul 2008 09:38:42 +0200
Message-ID: <B3761FA2-6313-421B-B47F-E03A258DEB6F@zib.de>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de> <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness> <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de> <alpine.DEB.1.00.0807111652170.8950@racer> <A065AF71-5685-423A-9F87-5349ADC6C9C9@zib.de> <alpine.DEB.1.00.0807111930160.8950@racer> <alpine.LFD.1.10.0807111159560.2936@woody.linux-foundation.org> <alpine.DEB.1.00.0807112037220.8950@racer> <7v4p6wjcgm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807120033490.8950@racer> <alpine.LFD.1.10.0807111638130.3459@woody.linux-foundation.org> <alpine.DEB.1.00.0807120043150.8950@racer> <alpine.LFD.1.10.0807111653500.2875@woody.linux-foundation.org>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, msysGit <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Jul 12 09:39:45 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.251])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHZhn-0007JS-2S
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2008 09:39:45 +0200
Received: by wa-out-0708.google.com with SMTP id n36so10461866wag.21
        for <gcvm-msysgit@m.gmane.org>; Sat, 12 Jul 2008 00:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:in-reply-to:subject:references:message-id
         :content-type:content-transfer-encoding:mime-version:date:cc
         :x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=wMjpHBvTJUZxcfG5Z+gviJzlxgkkCYd96dxSXOyHo/g=;
        b=XO8/NTQm2W7+gHbJHiLP2k2ojotm2jwcVe3j0IwvXRrxd3M/pmT+ry/0lpJZ9hzL2j
         wkl+qRHYDv1aGn7qSxng5hB0QIZzCAq3/Gst+UUluAdRJYe9DT5IUKxXn77YnP//iVRo
         lxCGPu+tLtl2iX3QCx42m9lGM/7kbrx21lU8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        b=vDbrRA9Q66W4sNbsVEx1qAKOPauZ0+kxmBU4PtzM2G3brqPeBHrWfX0vNXRxymo7Uf
         w9/Etzz6S2gsLiXX4EtXuqVmlb5qgAp2piogB97g5DKK+dUiOqa5TILc8XFqhxBesoi1
         EF3qsBKsN9xeq+w2A5Ccacw80SlAh/UQsuNAM=
Received: by 10.141.35.21 with SMTP id n21mr519547rvj.25.1215848321833;
        Sat, 12 Jul 2008 00:38:41 -0700 (PDT)
Received: by 10.107.13.30 with SMTP id q30gr2691pri.0;
	Sat, 12 Jul 2008 00:38:41 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.70.15 with SMTP id s15mr13564255aga.27.1215848316550; Sat, 12 Jul 2008 00:38:36 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 7si1791333yxg.1.2008.07.12.00.38.35; Sat, 12 Jul 2008 00:38:36 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6C7cONJ014218; Sat, 12 Jul 2008 09:38:30 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db95b87.pool.einsundeins.de [77.185.91.135]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6C7cFrb009507 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Sat, 12 Jul 2008 09:38:16 +0200 (MEST)
In-Reply-To: <alpine.LFD.1.10.0807111653500.2875@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88224>



On Jul 12, 2008, at 1:58 AM, Linus Torvalds wrote:

> On Sat, 12 Jul 2008, Johannes Schindelin wrote:
>>
>> But we are talking about 4msysgit.git, no?
>
> I'm not. I'm just talking about Windows-related changes in git in
> general, that are expected to be merged into regular git one way or
> another.

The discussion is not about 4msysgit, because 4msysgit will no longer
be needed after we cleaned up all differences between Junio's master
and 4msysgit's master.

I propose the following steps:

  - We review the differences and either prepare patches for official  
git
    or revert commits in 4msysgit.
    -> It will no longer matter if we build the msysgit release from
    Junio's master or from 4msysgit's master.

  - We change the /git submodule in msysgit to point to Junio's repo.
    -> Every developer on Windows will work with the official code base.

  - Windows-users can (and should) participate in the official release
    cycle.  They should test the next branch and the master branch after
    the merge window closed.  We can easily create installers for  
Junio's
    release candidates (I will do this).

We should provide a guideline how developers and users should send
comments and improvements related to Windows.  Such a guideline could be
included in Junio's "A note from the maintainer" mail.  The section on
Windows needs to be changed anyway.  Currently it says:

'''
- Johannes Schindelin and Johannes Sixt for their effort to
   move things forward on the Windows front.  Although my
   repository does not have much from the effort of MinGW team,
   I expect a merge into mainline will happen so that everybody
   can work from the same codebase.
'''

[ Note that the last sentence will become true if we do what I propose
   above. ]

We could send more detailed guidelines to the msysgit list and/or modify
the homepage of the msysgit project.  I think Junio's rule of thumb in

   http://article.gmane.org/gmane.comp.version-control.git/88191

is a good starting point.

It would be good to achieve all this during the 1.6 cycle, because
MinGW is officially part of 1.6.  I am however not sure if it is
practical.  We have some changes in 4msysgit that might need more
discussion and we did not even start discussing the tests.  So maybe
1.6.1 is more realistic.

	Steffen
