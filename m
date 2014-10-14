From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 07/14] Fix BASIC_LDFLAGS and COMPAT_CFLAGS for
 64bit MinGW-w64
Date: Tue, 14 Oct 2014 11:08:22 +0400
Message-ID: <20141014070822.GA15460@seldon>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
 <1412791267-13356-8-git-send-email-marat@slonopotamus.org>
 <alpine.DEB.1.00.1410092115100.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com,
	msysGit <msysgit@googlegroups.com>,
	Ray Donnelly <mingw.android@gmail.com>, marat@slonopotamus.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCE7TAPITACRB34X6OQQKGQETM7ZXHA@googlegroups.com Tue Oct 14 09:08:32 2014
Return-path: <msysgit+bncBCE7TAPITACRB34X6OQQKGQETM7ZXHA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f56.google.com ([74.125.82.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRB34X6OQQKGQETM7ZXHA@googlegroups.com>)
	id 1XdwDg-0005HQ-L2
	for gcvm-msysgit@m.gmane.org; Tue, 14 Oct 2014 09:08:32 +0200
Received: by mail-wg0-f56.google.com with SMTP id y10sf851664wgg.11
        for <gcvm-msysgit@m.gmane.org>; Tue, 14 Oct 2014 00:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=AyLcQ/npa/U17vR/VKydAoQTyNQhYMx8C960uze+S9s=;
        b=rCA9gDmFYdSbshWseG+E5awMNaZI9HPu8bV8M8+5+I5bphLYA/8zpw/gmmDFGeybKm
         je7elVdJ6lKBkdAG6LAK2Z+zf0rNs4FgpsuB8C9WSgFS8DOyszHc6UEfbpVhCn5f3+87
         yRuBR7U4Vs1+Vokg8xhcV6wwOTamWl4m0sUzNrkZN2mNoCLKHHx3QfeIF7kkdyL5izZI
         lBhptnpFS9UM3vxd8hyDaCB5y/Qmiso+itQcaOUqdkt61yvryBw1RF2AQkfQwAzDmv++
         +fqnazy6/F3f+d72Vfi8JJ31I0eU8Vto1eNqg/RsAv7JnhXpbrGRo3MxuY/mVYXE5g8C
         Yxzg==
X-Received: by 10.180.99.10 with SMTP id em10mr26385wib.20.1413270512155;
        Tue, 14 Oct 2014 00:08:32 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.10.131 with SMTP id i3ls587151wib.5.gmail; Tue, 14 Oct
 2014 00:08:31 -0700 (PDT)
X-Received: by 10.180.105.74 with SMTP id gk10mr940808wib.0.1413270511314;
        Tue, 14 Oct 2014 00:08:31 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id rb5si993438lbb.0.2014.10.14.00.08.31
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Oct 2014 00:08:31 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XdwDX-00042b-1t; Tue, 14 Oct 2014 11:08:23 +0400
In-Reply-To: <alpine.DEB.1.00.1410092115100.990@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Content-Disposition: inline

On Thu, Oct 09, 2014 at 09:22:19PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 8 Oct 2014, Marat Radchenko wrote:
> 
> > +CC_MACH := $(shell sh -c '$(CC) -dumpmachine 2>/dev/null || echo not')
> 
> There is a rather huge problem with that. The latest mingw-w64 release,
> 4.9.1, does not do what you expect here: while '.../mingw32/bin/gcc -m32
> -o 32.exe test.c' and '.../mingw32/bin/gcc -m64 -o 64.exe test.c' work
> fine, producing i686 and x86_64 executables respectively,
> '.../mingw32/bin/gcc -dumpmachine' prints i686-w64-mingw32 *always*, even
> when specifying the -m64 option.
> 
> So unfortunately, the test introduced by this patch (intended to figure
> out whether the build targets i686, and skip a compiler and a linker
> option otherwise) is incorrect.

According to [1], it is by design. For now, I suggest using separate
gcc binaries for 32/64, without messing with -m32. Of course we can
fallback to `./configure` that will determine bitness by compiling something.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52096#c1

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
