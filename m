From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Announce: Git for Windows 1.6.3
Date: Thu, 7 May 2009 23:35:31 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905072332540.18521@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0905071554070.16585@intel-tinevez-2-302> <87ocu4vl8a.fsf@gollum.intra.norang.ca>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Bernt Hansen <bernt@norang.ca>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu May 07 23:36:22 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.25])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2BFF-0004Kt-HF
	for gcvm-msysgit@m.gmane.org; Thu, 07 May 2009 23:35:09 +0200
Received: by yw-out-2122.google.com with SMTP id 4so204524ywc.63
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 May 2009 14:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=Gl2MaBoe/pggIAQ6che4aAGQpFoT4KTc8aboZI6993c=;
        b=e0Ve/11WjYFoZ4NJAMFOBozlhD0pFwPkIqlk8GX2ZpwrcFc5ZOLRpByIIS7IAOSV+J
         y0EnbV0Gd2vMnU22bTfbMCl6ematoqTc4xNo+1JE4S1soCLngF3cdpo95IvQZtJSbX7N
         9bQt4A/cySux6t2QqZtbDfwtGSURYfDDxlHd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=VxjoupZdCucWWNVF+aqcBF5VI2yyZvd4Ou55YmOxX6CHJspoZgsopUvLIfI0IOaL1i
         MLvyqzm2hkMjLm9xYexvyVnRoC4nopgAfcr9TFdPOvV9HtQa2ZFO5WBjbYdKjY6DQWZM
         z8VxAzjjs1MsZsjHIe7JgjCHiLRuA7z7WZ1Z0=
Received: by 10.150.189.9 with SMTP id m9mr403200ybf.8.1241732098173;
        Thu, 07 May 2009 14:34:58 -0700 (PDT)
Received: by 10.106.156.36 with SMTP id d36gr5091pre.0;
	Thu, 07 May 2009 14:34:58 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.31.100 with SMTP id x36mr83568bkc.9.1241732097757; Thu, 07 May 2009 14:34:57 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 15si45240fxm.1.2009.05.07.14.34.57; Thu, 07 May 2009 14:34:57 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 07 May 2009 21:34:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp001) with SMTP; 07 May 2009 23:34:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+MkZkMlEiM8angWaYNJI/jivVuf3CV1BmDCV89v4 LNZivfc5mYvcUO
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87ocu4vl8a.fsf@gollum.intra.norang.ca>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118524>


Hi,

On Thu, 7 May 2009, Bernt Hansen wrote:

> Hi Johannes!
> 
> I just tried installing the new preview version and at the end of the
> install procedure I get a pop-up with:
> 
> ,----[ Git Setup ]
> | Line 620: Unable to read file "etc\fileList-builtins.txt"
> `----
> 
> Install System: Asus Eee PC HE1000 running Windows XP on NTFS
> 
> I removed the previous preview version before trying this installation.

Thank you very much!.  It was a bug in my build process.  Fixed, pushed 
and uploaded as Git-1.6.3-preview20090507-2.exe!  (The Portable Git is 
unaffected of this bug.)

Ciao,
Dscho
