From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Should we discuss Windows-related changes on
 git@vger.kernel.org?
Date: Fri, 11 Jul 2008 16:40:45 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807111638130.3459@woody.linux-foundation.org>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de> <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness> <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de> <alpine.DEB.1.00.0807111652170.8950@racer> <A065AF71-5685-423A-9F87-5349ADC6C9C9@zib.de> <alpine.DEB.1.00.0807111930160.8950@racer> <alpine.LFD.1.10.0807111159560.2936@woody.linux-foundation.org> <alpine.DEB.1.00.0807112037220.8950@racer> <7v4p6wjcgm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807120033490.8950@racer>
Reply-To: torvalds@linux-foundation.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Steffen Prohaska <prohaska@zib.de>, Johannes Sixt <johannes.sixt@telecom.at>, msysGit <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Jul 12 01:42:22 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.247])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHSFo-0001sY-NC
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2008 01:42:20 +0200
Received: by wa-out-0708.google.com with SMTP id n36so10078826wag.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2008 16:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type:x-spam-status
         :x-spam-checker-version:x-mimedefang-filter:x-scanned-by:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        bh=QpRd7wTJWnczZlgc/w/W17g/UwVz+zws6JkjaKJFico=;
        b=gpVY2iHj+j9vJ41e6a7PFTK+qhE1mBSxoGGBfhIc1DP1rKWUJAxO1SLcPr2DSQK6ZD
         Yj88kOH3A7KKRH2nbVUZg3BkvQ9IbYG4AETrm+mCXHPuQZbFOZGKVa6FGiMO/51oEuy2
         FAXod143IYLyJBF4u5b6u1MIV4FUGTAwEOELg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date
         :from:to:cc:subject:in-reply-to:message-id:references:user-agent
         :mime-version:content-type:x-spam-status:x-spam-checker-version
         :x-mimedefang-filter:x-scanned-by:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=jhJWWnDX7MH/D0DZh7mGTBg9rarNY0s9EoyzNcqgOmjVC0js/SiVkLX4clYUZcQYDW
         G9P1TiPd5PQrJisUH5A85Op7vvyvx9U0Ih7E6zRVbdPfCuxc7tmCYFIBUJE5cgC8b6/P
         Kv4zcIW+cfWB/4caYK98z8V6X8LBjq8i/0soU=
Received: by 10.115.109.18 with SMTP id l18mr716322wam.29.1215819680541;
        Fri, 11 Jul 2008 16:41:20 -0700 (PDT)
Received: by 10.106.63.1 with SMTP id l1gr2686pra.0;
	Fri, 11 Jul 2008 16:41:20 -0700 (PDT)
X-Sender: torvalds@linux-foundation.org
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.37.1 with SMTP id k1mr6755902wak.7.1215819679380; Fri, 11 Jul 2008 16:41:19 -0700 (PDT)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org [140.211.169.13]) by mx.google.com with ESMTP id m36si461707wag.3.2008.07.11.16.41.19; Fri, 11 Jul 2008 16:41:19 -0700 (PDT)
Received-SPF: pass (google.com: domain of torvalds@linux-foundation.org designates 140.211.169.13 as permitted sender) client-ip=140.211.169.13;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of torvalds@linux-foundation.org designates 140.211.169.13 as permitted sender) smtp.mail=torvalds@linux-foundation.org
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55]) by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6BNekXW017720 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Fri, 11 Jul 2008 16:40:47 -0700
Received: from localhost (localhost [127.0.0.1]) by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6BNejSM010619; Fri, 11 Jul 2008 16:40:45 -0700
In-Reply-To: <alpine.DEB.1.00.0807120033490.8950@racer>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88204>




On Sat, 12 Jul 2008, Johannes Schindelin wrote:
> 
> I think that is a perfect example, since Hannes worked on it in mingw.git.  
> AFAIR a few comments came through msysGit, and were incorporated.  When 
> everything was good for a first go at git@vger, it was sent, and the 
> interface finalized.

Umm. Dscho - that was before the thing was merged.

Now that the basic mingw support is part of standard git, the situation 
has changed.

That's the main issue here - if mingw support is in standard git (and it 
is), then mingw issues that touch any non-mingw code should be discussed 
where all the git developers are.

Can't you see the difference between the pre-merge and the post-merge 
situation?

		Linus
