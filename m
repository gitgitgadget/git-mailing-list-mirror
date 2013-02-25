From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Fix msvc build
Date: Mon, 25 Feb 2013 20:01:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1302252000440.32206@s15462909.onlinehome-server.info>
References: <510AB766.4030806@ramsay1.demon.co.uk> <7vehg4288w.fsf@alter.siamese.dyndns.org> <512B2003.804@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, GIT Mailing-list <git@vger.kernel.org>, 
    Ramsay Jones <ramsay@ramsay1.demon.co.uk>, 
    Erik Faye-Lund <kusmabite@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>, 
    msysgit@googlegroups.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: msysgit+bncBCZPH74Q5YNRBBHKV2EQKGQEMFAKA2A@googlegroups.com Mon Feb 25 20:01:49 2013
Return-path: <msysgit+bncBCZPH74Q5YNRBBHKV2EQKGQEMFAKA2A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f188.google.com ([209.85.217.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBBHKV2EQKGQEMFAKA2A@googlegroups.com>)
	id 1UA3J3-000745-RI
	for gcvm-msysgit@m.gmane.org; Mon, 25 Feb 2013 20:01:45 +0100
Received: by mail-lb0-f188.google.com with SMTP id go11sf1328307lbb.5
        for <gcvm-msysgit@m.gmane.org>; Mon, 25 Feb 2013 11:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :x-y-gmx-trusted:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=la6qYb3OfvtiFblDvyLli2j6hjbjuRwPiANfLU1gikg=;
        b=dCxvHeNLenf54qsbC3hY9eJ8qC84s2DEP5AB8p0Of2btmLzJTL9UAwvg9AfIzJd8Ft
         0c5R8eY5gq1V4MKwK4wm9WXoqsuhTLC8ua0xrPDaLJNFHlUMGzH7cpNPuPkN9UjYIAMf
         ZCULDRpkKbNdrprUwDWGTEiUWrWC3Wv1bfzZ9UYtamoUbzhqK1QG3e4gbKPYQdA2ewKQ
         gmWefSQaRN7xo93iYrrN1PMVPFS9nVzZGkTfFxV3p1lwyQOxnhEf/ 
X-Received: by 10.180.19.66 with SMTP id c2mr1069332wie.4.1361818885089;
        Mon, 25 Feb 2013 11:01:25 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.95.99 with SMTP id dj3ls3928wib.35.canary; Mon, 25 Feb
 2013 11:01:23 -0800 (PST)
X-Received: by 10.14.184.9 with SMTP id r9mr13426168eem.7.1361818883939;
        Mon, 25 Feb 2013 11:01:23 -0800 (PST)
X-Received: by 10.14.184.9 with SMTP id r9mr13426167eem.7.1361818883928;
        Mon, 25 Feb 2013 11:01:23 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.19])
        by gmr-mx.google.com with ESMTP id 47si3702032eeh.1.2013.02.25.11.01.23;
        Mon, 25 Feb 2013 11:01:23 -0800 (PST)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.19 as permitted sender) client-ip=212.227.15.19;
Received: from mailout-de.gmx.net ([10.1.76.27]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MTuiV-1UIbuE1O09-00QlJZ for
 <msysgit@googlegroups.com>; Mon, 25 Feb 2013 20:01:23 +0100
Received: (qmail invoked by alias); 25 Feb 2013 19:01:23 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp027) with SMTP; 25 Feb 2013 20:01:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19QTl5B/lZQBuliiBtTDsBtzJaTPrEK/5yoWD/mkw
	zL7Fyi9Xk30zHZ
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <512B2003.804@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.19 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217084>

Hi Hannes,

On Mon, 25 Feb 2013, Johannes Sixt wrote:

> Am 2/25/2013 7:54, schrieb Junio C Hamano:
> > Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> > 
> >> As I mentioned recently, while discussing a cygwin specific patch
> >> (see "Version 1.8.1 does not compile on Cygwin 1.7.14" thread), the
> >> MSVC build is broken for me.
> >>
> >> The first 4 patches fix the MSVC build for me. The final patch is
> >> not really related to fixing the build, but it removed some make
> >> warnings which were quite irritating ...
> >>
> >> Note that I used the Makefile, with the Visual C++ 2008 command
> >> line compiler on Windows XP (SP3), to build a vanilla git on MinGW.
> >> I'm not subscribed to the msysgit mailing list, nor do I follow the
> >> msysgit fork of git, so these patches may conflict with commits in
> >> their repository.
> > 
> > Did anything further happen to this topic in the Windows land?
> 
> I successfully built with MSVC with these patches (but I am not using the
> result anywhere nor did I attempt to run the test suite).
> 
> More importantly, I'm using git on Windows ("MinGW flavor") with these
> patches in production, so there are no obvious regressions.
> 
> Feel free to add my
> 
> Tested-by: Johannes Sixt <j6t@kdbg.org>
> 
> but if you don't have the patches around, I can resend them.

Can you please send a pull request on GitHub?

Thanks,
Johannes

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
