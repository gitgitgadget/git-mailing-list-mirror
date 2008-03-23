From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Store autocrlf during init-db (was [msysGit] autocrlf
 problems with Git-preview20080301.exe)
Date: Sun, 23 Mar 2008 16:50:27 +0100 (CET)
Message-ID: <alpine.OSX.1.00.0803231643040.16879@cougar>
References: <f5d99ae7-e4b3-4632-ad86-8ebe0e683d49@d62g2000hsf.googlegroups.com> <alpine.LSU.1.00.0803101327390.3975@racer.site> <bdca99240803100611s3c8b3b9djb1b993c9fbad712@mail.gmail.com> <alpine.LSU.1.00.0803101448430.3975@racer.site> <cb8f4255-2bf8-4489-aeb0-c18d6e932342@s13g2000prd.googlegroups.com> <ab311292-809f-4e45-a19d-a600c2333ab6@a23g2000hsc.googlegroups.com> <alpine.OSX.1.00.0803221036230.7618@cougar> <7vzlsqfe2h.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803230310500.4353@racer.site> <alpine.OSX.1.00.0803230943500.7541@cougar> <alpine.LSU.1.00.0803231200010.4353@racer.site> <alpine.OSX.1.00.0803231326290.11994@cougar> <alpine.LSU.1.00.0803231404390.4353@racer.site> <alpine.OSX.1.00.0803231428220.13789@cougar> <alpine.LSU.1.00.0803231506000.4353@racer.site>
Reply-To: prohaska@zib.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, Junio C Hamano <junio@pobox.com>, tormod.hystad@gmail.com, msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Mar 23 16:50:25 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.191])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdSSk-0001Y3-Dr
	for gcvm-msysgit@m.gmane.org; Sun, 23 Mar 2008 16:50:22 +0100
Received: by ag-out-0910.google.com with SMTP id 32so2563565agc.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 23 Mar 2008 08:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=gamma;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=6fWO+wb+gkII8g8JSXUJyO6Km9C5kWssPe9F/sZ6gN8=;
        b=imkI5m3s/Bxm/hHqr27CFb64GAjq3x0kKlXYOBcagqDEIRmDlqDXMJsicYTz4lj4gXsiBAnUV9ZJIuKSLy6pky3zYdGQ/9yxuh5fbXhOupJ7ldUzpzia1d+Dq7ttyQD6jHYWM3Cx59khaH6e+wM4bgbUWeqV4S05Fgd83AGGZvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=gamma;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=xZKOBwPx6FvY46rNgZAgLmcIC1MWY5t+1yMH61o3yLs4j75UWuzZvvNDtS/MWfG8cmVCsAXZoBeEmHym/OZ+g5T2UAruWZvZ06ZodoI5SmeG+hRjAwL9Ch53YQdGFimES74Fc5+u7/2Puq5Y4z/kDAau5ePOyl6DWQ11Vgs8sec=
Received: by 10.100.141.5 with SMTP id o5mr158091and.25.1206287382053;
        Sun, 23 Mar 2008 08:49:42 -0700 (PDT)
Received: by 10.44.74.68 with SMTP id w68gr2004hsa.0;
	Sun, 23 Mar 2008 08:49:42 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.35.37.18 with SMTP id p18mr6573383pyj.6.1206287381438; Sun, 23 Mar 2008 08:49:41 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id a28si7803009pye.0.2008.03.23.08.49.40; Sun, 23 Mar 2008 08:49:41 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m2NFncLL015161; Sun, 23 Mar 2008 16:49:38 +0100 (CET)
Received: from cougar (brln-4db97827.pool.einsundeins.de [77.185.120.39]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m2NFnYPv008334 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Sun, 23 Mar 2008 16:49:37 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0803231506000.4353@racer.site>
User-Agent: Alpine 1.00 (OSX 882 2007-12-20)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77920>


On Sun, 23 Mar 2008, Johannes Schindelin wrote:

> On Sun, 23 Mar 2008, Steffen Prohaska wrote:
> 
> > On Sun, 23 Mar 2008, Johannes Schindelin wrote:
> > 
> > > The point is: if we use /etc/gitconfig, we also touch _existing_ 
> > > setups (as Junio pointed out).  Which, in the case of autocrlf, is not 
> > > desirable.
> > 
> > I proposed a mechanism that would avoid such problems in the future.
> 
> Yes, but your solution feels a bit limited and "hot-needled" for just one 
> purpose.

What limits do you mean (except that it does still break existing
msysgit setups; but would avoid this problem in the future)?

            Steffen
