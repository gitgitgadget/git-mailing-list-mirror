From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH nd/dwim-wildcards-as-pathspecs] t2019: skip test
 requiring '*' in a file name non Windows
Date: Wed, 12 Aug 2015 13:25:54 +0200
Organization: gmx
Message-ID: <a9e3c007fb6b39e7339c8d2b1c50d56b@www.dscho.org>
References: <55CA5D56.6030800@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, msysGit
 <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBCZPH74Q5YNRBRG2VSXAKGQE3CMZPAI@googlegroups.com Wed Aug 12 13:26:01 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBRG2VSXAKGQE3CMZPAI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f191.google.com ([209.85.212.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBRG2VSXAKGQE3CMZPAI@googlegroups.com>)
	id 1ZPUAP-00054q-T2
	for gcvm-msysgit@m.gmane.org; Wed, 12 Aug 2015 13:25:57 +0200
Received: by wicxr16 with SMTP id xr16sf3671699wic.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 12 Aug 2015 04:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:cc:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=28ZIYU8dukKlRfCz4Y1ersUp2K/zwsmGNLw0ErT7BLo=;
        b=RGgrJz9u5RGbPS1Zi1Hr3wTQiDymKy1SpvkOfdzc6NKV+V1hcegE+ND3kLLtYK499m
         KMm7/ET3P6732/Xzjej4ih29aBSKXn80r9bXRdXSlIdCJFbyPnhDJzvEKITqRY+6ATCK
         6kAgOvsG5/nlFWr4ll/7IOEnOvx+nd1dodIOONFy/Q9cULqdZ8t4D8sIcPH2SonaFXCN
         SXGsQSRWMh0f5/6P8l47GupDlDLsVQeqh8rm5MyEIeQ4C6zAvxxyw2NaJommmZSy+E4C
         RFoQGZUngFIz3H6T+v9le5Cc0QXbKH2dwQrNsDH56QCMpVC9+rQl0Ph19WeTJ7QPSr35
         o4hw==
X-Received: by 10.180.100.196 with SMTP id fa4mr75988wib.3.1439378757606;
        Wed, 12 Aug 2015 04:25:57 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.102.194 with SMTP id fq2ls117566wib.27.gmail; Wed, 12 Aug
 2015 04:25:56 -0700 (PDT)
X-Received: by 10.180.83.226 with SMTP id t2mr6845023wiy.5.1439378756211;
        Wed, 12 Aug 2015 04:25:56 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id ec7si200022wib.3.2015.08.12.04.25.56
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2015 04:25:56 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LsfrR-1YfAz53SIr-012HAq; Wed, 12 Aug 2015 13:25:54
 +0200
In-Reply-To: <55CA5D56.6030800@kdbg.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:mPZPau40nuVsesjh9uNL8zDzf4VB7oEzkAHClZU0CLdVBTG1HrN
 t/xGcLf2KV0ICgOm+dG1x+Rngfs2RB9tb3An7N7zvS76ZAtfJ+xncCqrCEQSeU94CUCUD3M
 unv0ZuTXxAIEupPbbXxFr3SXXM5b3bAMdM00W5FAUHaIcQfeu2CjwGdtNqt7BDzd9dR08G1
 p9/OvHlxl/qtLEnn3TpUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J7GES2WpYeE=:qx0eb1f9qeqOGEPJx9b8iY
 tV/pm+Ak8fO89iKmor5cDx4hV4qe6VhiP3kaG7FrlF4KDyB0fD0ObH0kAARU1NmhDY0MQJiwb
 Cx3Ku/YrjXiZPimWqdQilPGwNQKELKiMiNMpwsKnjXNJnafVAUDfWC64lhRSzlV6c85txdkwP
 lzROFF3TQUjKYBkIM8r7vPXqYw839qMIkdGs7WAL6vEKKkrhtkNOywyYq7OkI0/auiqrq72He
 SwIr/H363MAsog9smdh98+ISM+UyO6+00G7S51xcGoJTib3+F7p97S+HijPnXyCkxETL/pT/r
 id9MoSMVO1bGbrQL3fbtsaqVchFuEwdBfpPMK4QcVW6AXaQ+fbrMRNAKBmBcHLb2fhxtndfB6
 CRAEisWXHpSb8+Kt9OpHigTQeZTXbIfF6Y4uqfswrTn+Euxnj9wgg9gHafmrp1xLYLOm4IQVv
 dPBLyW7JTdJPsa12yRT4EeQ5kr8M5R6pMh421FTKHMYVpvJ4ldk3zodViIBcw+V4Nou3qMzM1
 zKLkzFQZgTWSpsZdwVTSbmqZbBQRW6w5H6/Hjo05hFTS40dSZeogCLS6wYXZPHdVtpdajkI7O
 MY13q/+2DiQ392+5ZayFU2rGQkkIURiXUxM+Xl1uhIOegixq5wxNKHlGtgrPUB0e5i6FQo1NT
 YWO3K30YSuRWG3Yo9GOTDz/9biRORhux6MbNEj4hI8mx42jB1w1rFTddMHbhIWC9TEahd+kc2
 A7wDW5Ch3X9jtcituXhG7iuxjaPQl+wT09rbvQ==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as
 permitted sender) smtp.mailfrom=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275759>

Hi,

On 2015-08-11 22:38, Johannes Sixt wrote:

> diff --git a/t/t2019-checkout-ambiguous-ref.sh
> b/t/t2019-checkout-ambiguous-ref.sh
> index 8396320..199b22d 100755
> --- a/t/t2019-checkout-ambiguous-ref.sh
> +++ b/t/t2019-checkout-ambiguous-ref.sh
> @@ -69,7 +69,7 @@ test_expect_success 'wildcard ambiguation, paths win' '
>  	)
>  '
>  
> -test_expect_success 'wildcard ambiguation, refs lose' '
> +test_expect_success !MINGW 'wildcard ambiguation, refs lose' '
>  	git init ambi2 &&
>  	(
>  		cd ambi2 &&

FWIW I planned to submit a patch including this fix:

https://github.com/git-for-windows/git/commit/4694320330e1b4d9178e13e215ce60a1cc8e0b1c

(The idea of the `fixup! ` was to make this change part of a larger change during the next merging rebase of Git for Windows.)

Ciao,
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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
