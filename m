From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH] t5000, t5003: do not use test_cmp to compare
 binary files
Date: Wed, 04 Jun 2014 14:13:44 +0200
Message-ID: <538F0D78.3020708@virtuell-zuhause.de>
References: <20140604114252.GA22250@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com
To: Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCL7JHHTPAIP7GV4TQCRUBFUGMGCK@googlegroups.com Wed Jun 04 14:13:59 2014
Return-path: <msysgit+bncBCL7JHHTPAIP7GV4TQCRUBFUGMGCK@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f188.google.com ([74.125.82.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAIP7GV4TQCRUBFUGMGCK@googlegroups.com>)
	id 1WsA4m-0001fC-Mx
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 14:13:52 +0200
Received: by mail-we0-f188.google.com with SMTP id p10sf705360wes.5
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 05:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=g6kfVqrqr9X3sEICTHU2JsAPZdKowjfa4kqLX/DjCd0=;
        b=Ivh/G82/xmJAVQ0xfcM9rqJRQSjx9U4BcuN8lR9pI5aq/QAoAMlkR5jeZ2Go338uKN
         6z+ozAqoWEie97wc0/Knw826Dw3SIlwHIariDlYUIOlHnXyNl/Iw9LqYYwDIBF2lSrWf
         4KfL+nsyXD8z535tYR8RMX3kHQA+pjJd1pLsZfbnNtVIz5qJKYpn40GcLlVro2KBvZ89
         ydNMN546LR8JVWCiT+hkxdvrA8UiudqulBNk6fz+KymsjvlwNw5T+0U2e8S1XrtmHzr/
         Evl1CM86LHSjp0FN+9Y6c1MNcIBGbvk/RP9MoABj1s3M5fpCwK1RF8vrlJWtWLBopD2Y
         ycyg==
X-Received: by 10.152.42.225 with SMTP id r1mr7679lal.13.1401884032429;
        Wed, 04 Jun 2014 05:13:52 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.116.48 with SMTP id jt16ls519097lab.50.gmail; Wed, 04 Jun
 2014 05:13:51 -0700 (PDT)
X-Received: by 10.112.49.229 with SMTP id x5mr1562946lbn.14.1401884031396;
        Wed, 04 Jun 2014 05:13:51 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [2a01:488:42::50ed:84a3])
        by gmr-mx.google.com with ESMTPS id gz10si874670wib.0.2014.06.04.05.13.48
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 05:13:48 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=2a01:488:42::50ed:84a3;
Received: from p5ddc323a.dip0.t-ipconnect.de ([93.220.50.58] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1WsA4f-0002sQ-VB; Wed, 04 Jun 2014 14:13:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140604114252.GA22250@camelia.ucw.cz>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1401884028;f56c8a75;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted
 sender hosts) smtp.mail=thomas.braun@virtuell-zuhause.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250724>

Am 04.06.2014 13:42, schrieb Stepan Kasal:
> test_cmp() is primarily meant to compare text files (and display the
> difference for debug purposes).
> 
> Raw "cmp" is better suited to compare binary files (tar, zip, etc.).
> 
> On MinGW, test_cmp is a shell function mingw_test_cmp that tries to
> read both files into environment, stripping CR characters (introduced
> in commit 4d715ac0).
> 
> This function usually speeds things up, as fork is extremly slow on
> Windows.  But no wonder that this function is extremely slow and
> sometimes even crashes when comparing large tar or zip files.
> 
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
>  t/t5000-tar-tree.sh             | 34 +++++++++++++++++-----------------
>  t/t5001-archive-attr.sh         |  2 +-
>  t/t5003-archive-zip.sh          |  6 +++---
>  t/t5004-archive-corner-cases.sh |  2 +-
>  4 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 1cf0a4e..31b1fd1 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -164,7 +164,7 @@ check_tar with_olde-prefix olde-
>  test_expect_success 'git archive on large files' '
>      test_config core.bigfilethreshold 1 &&
>      git archive HEAD >b3.tar &&
> -    test_cmp b.tar b3.tar
> +    cmp b.tar b3.tar
>  '

Wouldn't a function like test_cmp_bin() be better suited for all?
The windows folks can then use cmp inside test_cmp_bin() and all others
just use test_cmp.

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
