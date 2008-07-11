From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Should we discuss Windows-related changes on
 git@vger.kernel.org?
Date: Fri, 11 Jul 2008 12:04:24 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807111159560.2936@woody.linux-foundation.org>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de> <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness> <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de> <alpine.DEB.1.00.0807111652170.8950@racer> <A065AF71-5685-423A-9F87-5349ADC6C9C9@zib.de> <alpine.DEB.1.00.0807111930160.8950@racer>
Reply-To: torvalds@linux-foundation.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, Johannes Sixt <johannes.sixt@telecom.at>, Junio C Hamano <gitster@pobox.com>, msysGit <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Jul 11 21:05:51 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.27])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHNw4-0003nB-4k
	for gcvm-msysgit@m.gmane.org; Fri, 11 Jul 2008 21:05:49 +0200
Received: by yw-out-2122.google.com with SMTP id 8so3750030yws.63
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2008 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type:x-spam-status
         :x-spam-checker-version:x-mimedefang-filter:x-scanned-by:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        bh=ezfjqg1x3LO395tuu3fuaKwpra6YeANU7SFWsbG3tlU=;
        b=xf8EdaM4QhB1d0jUWJO3jE5jCdHoOQrusuUcv4UMC6UuSHtQAhrsvUIu0s5Bi0eVHV
         MZJb4RMObnC5upxglK+wQrEr8pXd/Ro9QUp4JirD5pVh4sBc741nQxQkR/RH8LIvoW0Z
         OzeZrdKFp9869YQKaY1NTtYs8/7GSA3pCg7fU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date
         :from:to:cc:subject:in-reply-to:message-id:references:user-agent
         :mime-version:content-type:x-spam-status:x-spam-checker-version
         :x-mimedefang-filter:x-scanned-by:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=TZjqSFG9Zqk7A4wXr2liBix3w89Dqj74Uiuu4uFHnXedbbGSBcB09whG2eEOjDBznV
         p19Vv2KKJncXOD4tOcS0anjqD0r2tqrvAyiMVHYqGo8rjOIvqp7I+7pWFBfRi5caYfL/
         GJl4XZCdWCkZZWS8nWtzDm6JD6SpgjRdGyTb4=
Received: by 10.142.199.10 with SMTP id w10mr313487wff.24.1215803071124;
        Fri, 11 Jul 2008 12:04:31 -0700 (PDT)
Received: by 10.107.13.30 with SMTP id q30gr2678pri.0;
	Fri, 11 Jul 2008 12:04:31 -0700 (PDT)
X-Sender: torvalds@linux-foundation.org
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.191.1 with SMTP id o1mr6355385waf.23.1215803070484; Fri, 11 Jul 2008 12:04:30 -0700 (PDT)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org [140.211.169.13]) by mx.google.com with ESMTP id k36si374379waf.0.2008.07.11.12.04.30; Fri, 11 Jul 2008 12:04:30 -0700 (PDT)
Received-SPF: pass (google.com: domain of torvalds@linux-foundation.org designates 140.211.169.13 as permitted sender) client-ip=140.211.169.13;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of torvalds@linux-foundation.org designates 140.211.169.13 as permitted sender) smtp.mail=torvalds@linux-foundation.org
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55]) by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6BJ4Qq1032201 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Fri, 11 Jul 2008 12:04:27 -0700
Received: from localhost (localhost [127.0.0.1]) by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6BJ4O6n031884; Fri, 11 Jul 2008 12:04:24 -0700
In-Reply-To: <alpine.DEB.1.00.0807111930160.8950@racer>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.386 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88160>




On Fri, 11 Jul 2008, Johannes Schindelin wrote:
> 
> Which very much includes brushing up the patches in 4msysgit, which are 
> invariably of lower quality than git.git's, because we lack a brilliant 
> maintainer like Junio.

Umm. The other side of the coin is:

 - a lot of people with good taste won't _be_ on the windows lists, 
   because there is likely a high correlation with "good taste in 
   development" and "try to avoid using windows"

 - a lot of Junio's maintenance is likely helped by the fact that (a) he 
   sees the features being discussed and the reason for them and (b) the 
   patches have in general seen comments from other people.

 - It may well be good to explain to the _real_ git people (eg me) what 
   the problems in Windows land are, so that we get a first-hand view into 
   hell, and can maybe take it into account when we make changes for other 
   things.

IOW, I think that since 1.6.0 is supposed to have native support for 
windows, we should have patches discussed on the regular git list. The 
ghetto that is windows can be useful for _user_ discussions, where a lot 
of the core git people simply cannot help. But having development 
discussions there is bad, I think.

		Linus
