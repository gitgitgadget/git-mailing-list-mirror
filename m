From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Should we discuss Windows-related changes on
 git@vger.kernel.org?
Date: Fri, 11 Jul 2008 16:58:28 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807111653500.2875@woody.linux-foundation.org>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de> <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness> <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de> <alpine.DEB.1.00.0807111652170.8950@racer> <A065AF71-5685-423A-9F87-5349ADC6C9C9@zib.de> <alpine.DEB.1.00.0807111930160.8950@racer> <alpine.LFD.1.10.0807111159560.2936@woody.linux-foundation.org> <alpine.DEB.1.00.0807112037220.8950@racer> <7v4p6wjcgm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807120033490.8950@racer> <alpine.LFD.1.10.0807111638130.3459@woody.linux-foundation.org> <alpine.DEB.1.00.0807120043150.8950@racer>
Reply-To: torvalds@linux-foundation.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Steffen Prohaska <prohaska@zib.de>, Johannes Sixt <johannes.sixt@telecom.at>, msysGit <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Jul 12 01:59:37 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.27])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHSWV-0005dl-Ji
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2008 01:59:35 +0200
Received: by yw-out-2122.google.com with SMTP id 8so3829205yws.63
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2008 16:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type:x-spam-status
         :x-spam-checker-version:x-mimedefang-filter:x-scanned-by:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        bh=BfQY+MUUvulkBrPdj2jAFJ7edOeWp1ynLhE+snvR8dw=;
        b=5xJv6LaP+oFEPA5uUacwqG4IF6DtUoGKfhY4p7HXsHLDM0P8QBO4VSlMkJD5uwZ7bI
         r187lQ/PiL8epE4Tqe/5din7+5zQMrA5aUbikHpcAxchVI6yFAi4cBlGzVDGWC4cakmw
         yo4KNyzzILYX1rHFTODFAW5eGvQYjoBBtfbLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date
         :from:to:cc:subject:in-reply-to:message-id:references:user-agent
         :mime-version:content-type:x-spam-status:x-spam-checker-version
         :x-mimedefang-filter:x-scanned-by:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=zzF8qvw8y0OdxGimBYizQDqMlSVeiiQlIm+tdoDxxiT39c89dcr9LjBXDTCF6atYZc
         AjoKhYVTNu14F+NKxWRU4UYb59jQ70i8GoZ53rj5QwemNynl5nXxuBdap76+8ZqsXTC7
         Pss6pno65Kh6gXX4ISrYMCRbApN1TNqNsuV7U=
Received: by 10.142.199.10 with SMTP id w10mr331952wff.24.1215820715329;
        Fri, 11 Jul 2008 16:58:35 -0700 (PDT)
Received: by 10.106.234.8 with SMTP id g8gr2688prh.0;
	Fri, 11 Jul 2008 16:58:35 -0700 (PDT)
X-Sender: torvalds@linux-foundation.org
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.196.13 with SMTP id t13mr6763639waf.13.1215820713072; Fri, 11 Jul 2008 16:58:33 -0700 (PDT)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org [140.211.169.13]) by mx.google.com with ESMTP id v36si466412wah.1.2008.07.11.16.58.33; Fri, 11 Jul 2008 16:58:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of torvalds@linux-foundation.org designates 140.211.169.13 as permitted sender) client-ip=140.211.169.13;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of torvalds@linux-foundation.org designates 140.211.169.13 as permitted sender) smtp.mail=torvalds@linux-foundation.org
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55]) by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6BNwTeY018812 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Fri, 11 Jul 2008 16:58:30 -0700
Received: from localhost (localhost [127.0.0.1]) by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6BNwS1B011316; Fri, 11 Jul 2008 16:58:28 -0700
In-Reply-To: <alpine.DEB.1.00.0807120043150.8950@racer>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.388 required=5 tests=AWL,BAYES_00
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88208>




On Sat, 12 Jul 2008, Johannes Schindelin wrote:
> 
> But we are talking about 4msysgit.git, no?

I'm not. I'm just talking about Windows-related changes in git in 
general, that are expected to be merged into regular git one way or 
another.

If it's something that should be merged, and if it concerns code that I'm 
interested in, I want to know about it. It's that simple.

The fact that _all_ windows discussion used to be in a different area and 
not on the -git list is past. It was definitely the case that it didn't 
affect any normal git code, since it was all maintained in a separate tree 
and the normal git tree was simply not even _relevant_, and didn't even 
try to be.

But that's changed. I think the windows support merge was really quite 
well done, and was a rather clean series, and no, I don't think the unix 
people cared about it when there was so much fundamental stuff needed to 
be done - we didn't have any relevant input.

But I'd certainly _hope_ that future windows work is incremental, and at 
that point it's no longer a "drop the end result on people" situation.

		Linus
