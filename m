From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Re: [RFH] GSoC 2015 application
Date: Wed, 25 Feb 2015 10:39:01 +0100
Message-ID: <vpqlhjmnxe2.fsf@anie.imag.fr>
References: <20150218191417.GA7767@peff.net> <20150218193234.GA8298@peff.net>
	<5f6dbabdf4da3c3c757d92ba00a8b7d1@www.dscho.org>
	<20150224120607.GA1906@peff.net>
	<ed760450b06fd41c8bcaea7aaf526b94@www.dscho.org>
	<20150224122846.GA2631@peff.net>
	<1029c184eae22b9d27fae5de2c04238b@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
        msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: msysgit+bncBC3OZIEKVABBBQVQW2TQKGQELJTK3FY@googlegroups.com Wed Feb 25 10:39:18 2015
Return-path: <msysgit+bncBC3OZIEKVABBBQVQW2TQKGQELJTK3FY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f62.google.com ([209.85.215.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC3OZIEKVABBBQVQW2TQKGQELJTK3FY@googlegroups.com>)
	id 1YQYR1-0001vF-Vo
	for gcvm-msysgit@m.gmane.org; Wed, 25 Feb 2015 10:39:16 +0100
Received: by labhv19 with SMTP id hv19sf715304lab.6
        for <gcvm-msysgit@m.gmane.org>; Wed, 25 Feb 2015 01:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:mailscanner-null-check
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=D0/3/77VLyuW8kY787VX8YuyWnGrbY4AfQ3E1+zwzIU=;
        b=gSwGMOVTosyFXP0WKdh/U0cRP5fIyUDRsIib9DVogXNyv1U02jdiadU7wYUJl7feRf
         FNf4Q9Xb2NJtqmCGs6yzyHEBNvzwxMTsZNYYWImSZkcAmoharA7qFeWxpleG6Hy83dUJ
         h03nQc1MYeWWeCM5IoLpgU0JoeGFtxOtxJFfDFaP+AHfNcuzEmGwng+09QRKktWJQMkF
         mjfhqT2fgxzLcIwoyLgyAaDsFHgLOcHT8rPfsN3f0idLK279FI0Z2NKnqUIWit69/59p
         lpHWv/LzSrxs77Lw1klvlKvemTM8JvDUqS8J0sZmmFHksCip9B3xUAzNDka8iGpzI7LO
         4s/g==
X-Received: by 10.152.21.202 with SMTP id x10mr25712lae.36.1424857155711;
        Wed, 25 Feb 2015 01:39:15 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.8.169 with SMTP id s9ls268720laa.8.gmail; Wed, 25 Feb 2015
 01:39:13 -0800 (PST)
X-Received: by 10.112.25.7 with SMTP id y7mr311612lbf.21.1424857153413;
        Wed, 25 Feb 2015 01:39:13 -0800 (PST)
Received: from shiva.imag.fr (mx1.imag.fr. [2001:660:5301:6::5])
        by gmr-mx.google.com with ESMTPS id by11si1321289wib.1.2015.02.25.01.39.13
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Feb 2015 01:39:13 -0800 (PST)
Received-SPF: pass (google.com: domain of Matthieu.Moy@grenoble-inp.fr designates 2001:660:5301:6::5 as permitted sender) client-ip=2001:660:5301:6::5;
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t1P9d17W015014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Feb 2015 10:39:01 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1P9d1i2006141;
	Wed, 25 Feb 2015 10:39:01 +0100
In-Reply-To: <1029c184eae22b9d27fae5de2c04238b@www.dscho.org> (Johannes
	Schindelin's message of "Wed, 25 Feb 2015 10:25:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 25 Feb 2015 10:39:01 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1P9d17W015014
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1425461945.317@9fCzrOuyYwbgPPJEi5sSeQ
X-Original-Sender: matthieu.moy@grenoble-inp.fr
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Matthieu.Moy@grenoble-inp.fr designates
 2001:660:5301:6::5 as permitted sender) smtp.mail=Matthieu.Moy@grenoble-inp.fr
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264373>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>>> Done: https://github.com/git/git.github.io/pull/12
>> 
>> Thanks, merged.
>
> I opened another PR, based on Mathieu's advice.

Thanks, merged.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

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
