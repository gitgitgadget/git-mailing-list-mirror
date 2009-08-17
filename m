From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 02/11] Fix declare variable at mid of function
Date: Mon, 17 Aug 2009 21:36:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908172134150.8306@pacific.mpi-cbg.de>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>  <1250524872-5148-2-git-send-email-lznuaa@gmail.com>  <alpine.DEB.1.00.0908171827040.4991@intel-tinevez-2-302> <3f4fd2640908170934w4c48ada1o66745f845ecb7d49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1190261749-1250537771=:8306"
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org, msysgit@googlegroups.com
To: Reece Dunn <msclrhd@googlemail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Aug 17 21:35:40 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md7zY-0005ks-DD
	for gcvm-msysgit@m.gmane.org; Mon, 17 Aug 2009 21:35:40 +0200
Received: by mail-yw0-f140.google.com with SMTP id 4so5109518ywh.22
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Aug 2009 12:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:received:x-authenticated:x-provags-id:date:from:x-x-sender
         :to:cc:subject:in-reply-to:message-id:references:user-agent
         :mime-version:content-type:x-y-gmx-trusted:x-fuhafi:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=ZghY+NT09zctEY0KaZsobt5/jhBLbe6UcQUMZ3Z+ZfA=;
        b=0nRxw7aiYwZN1FpT3+ao5u9nWhOACTCFX8piKQuWgeYMynoh86xY6uJB7shSZJVX/O
         oChLZAT/qrK6va9/Y/xi5OHgWfx3D9xzOt0b5ZBw0MZ4/rmxU6sZs1qP+AeXGckoUu1q
         OQ2IkzD22cU+PMdpR2MrWVKM97r+RQqm7y5bs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=iwFCSvBZy0wFlO4be3A74XiUHB+eCQg87BmbdnVuapWaHI86ifn8wGe/6Y21mIcWEj
         lIlogUtget/4tuWIwkkwB1nsIUb1TuB6hLs+ETmYVZ8mJIMXZtro9XiAPtqOvKI4oueN
         rxEp+lMPb2XBjxpCJszcwSXZPuIDSgo1VcDuI=
Received: by 10.150.59.4 with SMTP id h4mr619417yba.21.1250537734473;
        Mon, 17 Aug 2009 12:35:34 -0700 (PDT)
Received: by 10.176.94.14 with SMTP id r14gr6377yqb.0;
	Mon, 17 Aug 2009 12:35:24 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.24.5 with SMTP id t5mr204903bkb.11.1250537723338; Mon, 17 Aug 2009 12:35:23 -0700 (PDT)
Received: by 10.204.24.5 with SMTP id t5mr204902bkb.11.1250537723303; Mon, 17 Aug 2009 12:35:23 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 16si695631fxm.2.2009.08.17.12.35.23; Mon, 17 Aug 2009 12:35:23 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 17 Aug 2009 19:35:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp071) with SMTP; 17 Aug 2009 21:35:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/liv5aVp3lYjJLt5a9Pew7kviJJkokIB14LHgvlT KXs/sgnmvNFr8H
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <3f4fd2640908170934w4c48ada1o66745f845ecb7d49@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126260>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1190261749-1250537771=:8306
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 17 Aug 2009, Reece Dunn wrote:

> 2009/8/17 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
> > On Tue, 18 Aug 2009, Frank Li wrote:
> >
> >> Some compiler such as MSVC can't support declear variable at mid of 
> >> funtion at c file.
> >
> > Please wrap your commit messages after 76 characters.
> >
> >>
> >> Signed-off-by: Frank Li <lznuaa@gmail.com>
> >> ---
> >
> > How about this instead?
> >
> >        Avoid declaration after instruction
> >
> >        Microsoft Visual C++ does not understand this C99 style.
> >
> > ?
> >
> > The patch itself is good.
> 
> Shouldn't GCC be changed to use -std=c89 as well to pick up errors for 
> compilers that don't support c99 (like the Microsoft Visual C++ C 
> compiler)?

Hmm.  I played with the thought of adding -Werror -Wno-pointer-to-int-cast 
-Wold-style-definition -Wdeclaration-after-statement like Junio described 
in one of his mails for MinGW (as we _know_ what compiler we have there).

Dunno.

Ciao,
Dscho

--8323328-1190261749-1250537771=:8306--
