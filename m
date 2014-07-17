From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 2/6] Disable t0110's high-bit test on Windows
Date: Thu, 17 Jul 2014 20:20:02 +0200
Message-ID: <53C813D2.8070701@gmail.com>
References: <20140716092959.GA378@ucw.cz> <1405611425-10009-1-git-send-email-kasal@ucw.cz> <1405611425-10009-3-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>, 
 GIT Mailing-list <git@vger.kernel.org>,
 msysGit <msysgit@googlegroups.com>, 
 Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCH3XYXLXQDBBUNHUCPAKGQELUXWDWY@googlegroups.com Thu Jul 17 20:20:05 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBUNHUCPAKGQELUXWDWY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f64.google.com ([209.85.215.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBUNHUCPAKGQELUXWDWY@googlegroups.com>)
	id 1X7qHi-0008Lh-I0
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 20:20:02 +0200
Received: by mail-la0-f64.google.com with SMTP id el20sf350596lab.9
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=H123AP3WhXRTNFRLavC2vYg0+q2YPxweGWwDVWYoHsM=;
        b=RYdM3d95xNbADmJnBYl6Its/syBFuJ72B0LC4nnwh2QDYTmvq6AyOs4K6sjLaaqqJN
         rmYzBZMSOYbp2q7Rp+YeIIFooh3UIRRKQeoiWSEmJG6kM1fTc7EikbAVWgMvztvgMWR+
         p9/7om8et9AsEuXh3ucrrMxYVii3lanbdQGBFveqtRn7kEk8PXGOz/dULCMIBDypl3Lk
         5yhvtFtqc5R/eaP6jBu9OLmpBs1KLQOy48gkqRXMBQxZXyxWR6QU0aMXaR4xyGJwGLXn
         uhZNV4NStO05g+3FN5byNmvxfMHhJ7zwPas5ZE60WIGLQMkZz9YtmpR3wrH2iQk88S/I
         FP0Q==
X-Received: by 10.152.183.196 with SMTP id eo4mr407lac.42.1405621202339;
        Thu, 17 Jul 2014 11:20:02 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.27.97 with SMTP id s1ls231264lag.60.gmail; Thu, 17 Jul
 2014 11:20:01 -0700 (PDT)
X-Received: by 10.152.6.200 with SMTP id d8mr3110737laa.4.1405621201412;
        Thu, 17 Jul 2014 11:20:01 -0700 (PDT)
Received: from mail-wi0-x230.google.com (mail-wi0-x230.google.com [2a00:1450:400c:c05::230])
        by gmr-mx.google.com with ESMTPS id mx7si1104605wic.1.2014.07.17.11.20.01
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 11:20:01 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::230 as permitted sender) client-ip=2a00:1450:400c:c05::230;
Received: by mail-wi0-x230.google.com with SMTP id bs8so8244747wib.9
        for <msysgit@googlegroups.com>; Thu, 17 Jul 2014 11:20:01 -0700 (PDT)
X-Received: by 10.180.207.48 with SMTP id lt16mr24854765wic.32.1405621201306;
        Thu, 17 Jul 2014 11:20:01 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id w6sm7906568wjr.4.2014.07.17.11.20.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 11:20:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1405611425-10009-3-git-send-email-kasal@ucw.cz>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::230
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253767>

Am 17.07.2014 17:37, schrieb Stepan Kasal:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The bash Git for Windows uses (i.e. the MSys bash) cannot pass
> command-line arguments with high bits set verbatim to non-MSys programs,
> but instead converts those characters with high bits set to their hex
> representation.
> 

The description is not entirely correct...the Unicode-enabled MSYS.dll
expects the command line to be UTF-8. Only *invalid* UTF-8 is converted
to hex code for convenience. So its not the high bits that cause trouble,
but specifying 0x80 without proper UTF-8 lead byte.

I believe the last line of the test may actually work:

test "$(test-urlmatch-normalization -p "$(cat "$tu-11")")" = "x://q/%C2%80%DF%BF%E0%A0%80%EF%BF%BD%F0%90%80%80%F0%AF%BF%BD"

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
For more options, visit https://groups.google.com/d/optout.
