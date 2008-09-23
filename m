From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Git-1.6.0.2-preview20080923
Date: Tue, 23 Sep 2008 11:36:51 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0809231135310.13830@pacific.mpi-cbg.de.mpi-cbg.de>
References: <82166911-C34F-439C-A2F3-CEBD7346A1D6@zib.de> <691F01A6-CA78-46DA-8388-C8339A3F0F04@zib.de> <B463062F-DD48-44A7-B2BB-8E5E0D177616@zib.de>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysGit <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Sep 23 11:32:04 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f59.google.com ([209.85.217.59])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki4FY-00082f-2U
	for gcvm-msysgit@m.gmane.org; Tue, 23 Sep 2008 11:32:04 +0200
Received: by gxk19 with SMTP id 19so2387564gxk.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 23 Sep 2008 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=gk3JlABoT9cm5rQp7Eo5TN7M5s/p9mQBkr1fg/CsWh4=;
        b=2KWmIgwYs35wD8Dz9b54ZFDvNGKPxvNVDZrWlHlUYsxIl9eNhDcNNKCApdxIALZRVe
         mZ8Tk1uWcnegDK8dN2Y88TOhExErpFkby+849Q00Z1xTbe88vHirYg3bTYmDhlpuZuPn
         qpkV60nkMJcjEhUCDfWbtDtjpLgDxn9vzOFkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=TuW3JVhBrWwvIa+EoYVz93BRnlJSlDg7bVRV/tG01F23YfYOuE0H7yZ8iLIC1D+ade
         SyvPgKErZk2G0ybdDIxbdI/GxI5QUgOm/DYXaUtTjnDJGkY3xfvo1WZlaFgjhCMWeopV
         NJo5Zpf2v3R9FG9ZIZQWV8EPtI7c0GD9pgLqM=
Received: by 10.90.94.2 with SMTP id r2mr266305agb.16.1222162253415;
        Tue, 23 Sep 2008 02:30:53 -0700 (PDT)
Received: by 10.44.74.68 with SMTP id w68gr2970hsa.0;
	Tue, 23 Sep 2008 02:30:53 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.150.181.7 with SMTP id d7mr2663442ybf.12.1222162252068; Tue, 23 Sep 2008 02:30:52 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id 7si10262690yxg.0.2008.09.23.02.30.51; Tue, 23 Sep 2008 02:30:52 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 23 Sep 2008 09:30:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp066) with SMTP; 23 Sep 2008 11:30:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/6Va8VMRf6zd7/iV/+yWSdNksS1HvmwfUKsklw1U cP+JM1V8tRKrez
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <B463062F-DD48-44A7-B2BB-8E5E0D177616@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96543>


Hi,

On Tue, 23 Sep 2008, Steffen Prohaska wrote:

> I apologize for the quality of Git-1.6.0.2-preview20080921.
> It was unacceptable.

No, that is too harsh.  There is some meaning in the infix "preview", and 
given that you gave everybody (me included, I have to admit) the chance to 
work on this installer earlier, there is nothing to apologize for.

Ciao,
Dscho
