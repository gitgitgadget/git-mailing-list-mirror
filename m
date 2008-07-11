From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Should we discuss Windows-related changes on
 git@vger.kernel.org?
Date: Sat, 12 Jul 2008 00:35:20 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807120033490.8950@racer>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de> <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness> <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de> <alpine.DEB.1.00.0807111652170.8950@racer> <A065AF71-5685-423A-9F87-5349ADC6C9C9@zib.de> <alpine.DEB.1.00.0807111930160.8950@racer> <alpine.LFD.1.10.0807111159560.2936@woody.linux-foundation.org> <alpine.DEB.1.00.0807112037220.8950@racer> <7v4p6wjcgm.fsf@gitster.siamese.dyndns.org>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,  Steffen Prohaska <prohaska@zib.de>,  Johannes Sixt <johannes.sixt@telecom.at>,  msysGit <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Jul 12 01:36:34 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.169])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHSA2-0000q0-V7
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2008 01:36:23 +0200
Received: by py-out-1314.google.com with SMTP id u10so11059154pyb.2
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2008 16:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=x2xZ3pH5EOb7oukAOlBNJMILwpDVSh52jitupZnCug4=;
        b=i0thkAnbnCgJ0nz9esVX8wW11jAd1rAUeaUiPwoVeqhZ7uXMbXrCxvgXOXoyWddT31
         FM4mdWV1zPNfYKKEg4AO95wmOn13Gobc/lf6W5ghscCRHKRin/04UE1o/R79txUwBCTm
         VPN1wsZJ3jDPu5PjMtclSrsoDseMaP2C9KtSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=bvwhJaywo3QV9ATurxOHyJJmoSKGACcuePxAlDaNtfnwmjecIWD5JxnaPuI96tPzfb
         JjvM/eP8XtbATJIo+FjpdRwtuo+qQJsSiFZ4myx3vGWAvwtsSFWr+LtruYKSWYDp61yW
         yfc7wAstPFBQZ8uj+P8aTP+v9RMRkwXI3LnBw=
Received: by 10.142.221.19 with SMTP id t19mr330476wfg.13.1215819322651;
        Fri, 11 Jul 2008 16:35:22 -0700 (PDT)
Received: by 10.106.239.31 with SMTP id m31gr2684prh.0;
	Fri, 11 Jul 2008 16:35:22 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.67.2 with SMTP id p2mr6748149waa.24.1215819321795; Fri, 11 Jul 2008 16:35:21 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id 39si1428107yxd.0.2008.07.11.16.35.21; Fri, 11 Jul 2008 16:35:21 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 11 Jul 2008 23:35:20 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28] by mail.gmx.net (mp010) with SMTP; 12 Jul 2008 01:35:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18YKFdPd7UYSOZM9UW7xqYCPwuv71goIeVvVv54HC W+08TzleVEBx0b
X-X-Sender: gene099@racer
In-Reply-To: <7v4p6wjcgm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88201>


Hi,

On Fri, 11 Jul 2008, Junio C Hamano wrote:

> Another example that has already happened was our move away from direct 
> use of fork/exec but abstracting it out to run_command() layer.  This 
> would not have settled in a shape usable by both Windows and POSIX if 
> people from both camps did not participate in the design and review.

I think that is a perfect example, since Hannes worked on it in mingw.git.  
AFAIR a few comments came through msysGit, and were incorporated.  When 
everything was good for a first go at git@vger, it was sent, and the 
interface finalized.

And I agree that it is a pretty beautiful interface.

Ciao,
Dscho
