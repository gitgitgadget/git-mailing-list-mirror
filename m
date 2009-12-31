From: Kirill <kirillathome@gmail.com>
Subject: Re: [PATCH] Provide a window icon on Windows platforms
Date: Thu, 31 Dec 2009 15:13:43 -0500
Message-ID: <f579dd580912311213u2515334fxb811354f59fe05a5@mail.gmail.com>
References: <1262289470-4208-1-git-send-email-kirillathome@gmail.com>
	 <20091231200240.GC13700@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Jeff Epler <jepler@unpythonic.net>
X-From: 3-gU9SwwJB4gwu3uxxm5t0yqsymux.o0yy4A4su5s00sxqs30614.o0y@listserv.bounces.google.com Thu Dec 31 21:14:05 2009
Return-path: <3-gU9SwwJB4gwu3uxxm5t0yqsymux.o0yy4A4su5s00sxqs30614.o0y@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f161.google.com ([209.85.211.161])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQRPI-0005p9-Gn
	for gcvm-msysgit@m.gmane.org; Thu, 31 Dec 2009 21:14:04 +0100
Received: by ywh33 with SMTP id 33sf34737107ywh.24
        for <gcvm-msysgit@m.gmane.org>; Thu, 31 Dec 2009 12:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:received:in-reply-to
         :references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding;
        bh=NnJOFCfQ5Hq8+m7A0xRRXOU27xuPWcBKhKo0QH9g7hI=;
        b=DLTxHhvhGbmTW7qew1gBdXn58/vglEOW3JbbCxaoFUmNDrNlMmV0Qib3SIcaAMqK7J
         WUac3Eugs5KP2EP0Y7ZnmLGd2COne8pQewhaYOU/En71/mdYDonlRrj7LIi7N2Lx1dwV
         l0T56g8E9BLSPAR4APisDCdJahhJmkClqVj6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:x-thread-url:x-message-url:sender
         :list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding;
        b=JQc58x5lFRRfSZ2M9B34hgHc+MMTXmziRSNLUOywa63aVL0QPau2BxyYwP8WdMwr7Y
         4GXRRmUVAGW8zcvRszfg+e0cf+d2w3SsKfC72CK9YBsoFZNe2XV2W6y1rnfsy1sMYlRw
         fhXajKZmIjK2v0YNnB5Je1MP3CVhyhHs7yWes=
Received: by 10.101.180.36 with SMTP id h36mr1448670anp.24.1262290426662;
        Thu, 31 Dec 2009 12:13:46 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.57.18 with SMTP id a18ls809784ebh.3.p; Thu, 31 Dec 2009 
	12:13:44 -0800 (PST)
Received: by 10.213.96.14 with SMTP id f14mr2559745ebn.23.1262290424782;
        Thu, 31 Dec 2009 12:13:44 -0800 (PST)
Received: by 10.213.96.14 with SMTP id f14mr2559744ebn.23.1262290424758;
        Thu, 31 Dec 2009 12:13:44 -0800 (PST)
Received: from mail-ew0-f222.google.com (mail-ew0-f222.google.com [209.85.219.222])
        by gmr-mx.google.com with ESMTP id 18si2050588ewy.4.2009.12.31.12.13.43;
        Thu, 31 Dec 2009 12:13:43 -0800 (PST)
Received-SPF: pass (google.com: domain of kirillathome@gmail.com designates 209.85.219.222 as permitted sender) client-ip=209.85.219.222;
Received: by mail-ew0-f222.google.com with SMTP id 22so14354693ewy.39
        for <msysgit@googlegroups.com>; Thu, 31 Dec 2009 12:13:43 -0800 (PST)
Received: by 10.216.89.76 with SMTP id b54mr3202694wef.105.1262290423569; Thu, 
	31 Dec 2009 12:13:43 -0800 (PST)
In-Reply-To: <20091231200240.GC13700@unpythonic.net>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kirillathome@gmail.com designates 209.85.219.222 as permitted 
	sender) smtp.mail=kirillathome@gmail.com; dkim=pass (test mode) 
	header.i=@gmail.com
X-Original-Sender: kirillathome@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/80f1c5d3df016c97
X-Message-Url: http://groups.google.com/group/msysgit/msg/1d574db8822fd9fe
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135971>

On Thu, Dec 31, 2009 at 3:02 PM, Jeff Epler wrote:
> On Thu, Dec 31, 2009 at 02:57:50PM -0500, Kirill wrote:
>> + =A0 =A0 set ::tk::AlwaysShowSelection 1
>> +
>> + =A0 =A0 # Spoof an X11 display for SSH
>> + =A0 =A0 if {![info exists env(DISPLAY)]} {
>> + =A0 =A0 =A0 =A0 =A0 =A0 set env(DISPLAY) :9999
>> + =A0 =A0 }
>
> these bits look unrelated and should probably be in a separate
> submission.
The only reason this code is here: Git Gui has it in the same section.
Given my total lack of Tcl/Tk skills and deep understanding, I hoped
to fix some other Windows-specific annoyances "by accident".

If Tcl/Tk gurus, for example, Paul Mackerras, say they're wrong, I'll
gladly remove them. If the only objection is the inclusion into the
same patch, I can do that too.

Thanks for your time!

--
Kirill.
