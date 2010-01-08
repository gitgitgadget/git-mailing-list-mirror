From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mingw: disable Python
Date: Fri, 8 Jan 2010 11:35:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001081135180.4272@intel-tinevez-2-302>
References: <40aa078e1001071400j21900ed1n415394491d469b8c@mail.gmail.com> <1262902037-4420-1-git-send-email-kusmabite@gmail.com> <4B46E7D6.3080702@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@googlemail.com>, msysgit@googlegroups.com, 
    git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: 3fwpHSxMGBxwBG92FF6K.K49AF56DAF8EP.56EKQK8AL8GG8D68JGMHK.4GE@listserv.bounces.google.com Fri Jan 08 11:37:20 2010
Return-path: <3fwpHSxMGBxwBG92FF6K.K49AF56DAF8EP.56EKQK8AL8GG8D68JGMHK.4GE@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f161.google.com ([209.85.211.161])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTCCH-0005t8-L2
	for gcvm-msysgit@m.gmane.org; Fri, 08 Jan 2010 11:36:01 +0100
Received: by ywh33 with SMTP id 33sf49699297ywh.24
        for <gcvm-msysgit@m.gmane.org>; Fri, 08 Jan 2010 02:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:x-authenticated
         :x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:x-y-gmx-trusted
         :x-fuhafi:x-original-authentication-results:x-original-sender
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :x-thread-url:x-message-url:sender:list-unsubscribe:list-subscribe
         :content-type;
        bh=QqPaqg3jltWafqwea4cU131ytu2M2HJVvbh4tvWWImU=;
        b=g+r3343a+gwm4hYViP6uA3yn93Lecnhw+qAvTKfrtyu1n7bcJZ28OMQmPmboTk58cK
         my8IpsNwObxkhV0jhrkhwmGWenrxB1ZIAPm+Qa7Kl86UWZdJ3N2Q43qWmiEMiy+nmt1D
         NJ88FXZkJ9OkN+8RI6lilgwozEB74zXcAD/uk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-fuhafi
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type;
        b=Bb89lh8UfJfRBsff3igBfSeREg9b8f0mguOwu18A877au7zk1Q88ZPZwMF4yMI/VtZ
         XTCDNHDX9sRXpcdTLh93YKBxMs6rsc2aGldn+K5zuY0k1KKLfV1HX4+OPbKUFhmEF62l
         lk7bEj1YSfpMO7dFdkO8gIe6c4VaJMwkSO77g=
Received: by 10.101.165.34 with SMTP id s34mr2646631ano.21.1262946943990;
        Fri, 08 Jan 2010 02:35:43 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.223.55.204 with SMTP id v12ls241118fag.1.p; Fri, 08 Jan 2010 
	02:35:43 -0800 (PST)
Received: by 10.223.5.146 with SMTP id 18mr1166162fav.17.1262946942849;
        Fri, 08 Jan 2010 02:35:42 -0800 (PST)
Received: by 10.223.5.146 with SMTP id 18mr1166161fav.17.1262946942832;
        Fri, 08 Jan 2010 02:35:42 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
        by gmr-mx.google.com with SMTP id 17si2201950fxm.3.2010.01.08.02.35.42;
        Fri, 08 Jan 2010 02:35:42 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Received: (qmail invoked by alias); 08 Jan 2010 10:35:42 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 08 Jan 2010 11:35:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195L2Be9Rp5K9KW9dkNITA5Kd1oWewpCbrRFKgk7Y
	rC2gZ33ciOa+f4
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4B46E7D6.3080702@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted 
	sender) smtp.mail=Johannes.Schindelin@gmx.de
X-Original-Sender: johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/c47e2d2a7bf1b2d5
X-Message-Url: http://groups.google.com/group/msysgit/msg/f698a0f9d611b30a
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136422>

Hi,

On Fri, 8 Jan 2010, Johannes Sixt wrote:

> Erik Faye-Lund schrieb:
> > Python is not commonly installed on Windows machines, so
> > we should disable it there by default.
> > 
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1027,6 +1027,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
> > +	NO_PYTHON = YesPlease
> 
> I'm worried that with this solution it is impossible to re-enable Python
> in config.mak (how do you undefine a Makefile variable?);

How about

	NO_PYTHON=

in config.mak?

Ciao,
Dscho
