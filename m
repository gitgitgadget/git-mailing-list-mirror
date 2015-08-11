From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH bc/connect-plink] t5601-clone: remove broken and
 pointless check for plink.exe
Date: Tue, 11 Aug 2015 18:50:23 -0400
Message-ID: <CAPig+cS2CPFPBK+4W56dRVUas8UDpV1FZfMmOqxm6mprW+O_mw@mail.gmail.com>
References: <55CA6066.5070500@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBD2JJCMYYEGBBMHYVGXAKGQE7GXSWGI@googlegroups.com Wed Aug 12 00:50:25 2015
Return-path: <msysgit+bncBD2JJCMYYEGBBMHYVGXAKGQE7GXSWGI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qk0-f190.google.com ([209.85.220.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD2JJCMYYEGBBMHYVGXAKGQE7GXSWGI@googlegroups.com>)
	id 1ZPINF-00026n-CX
	for gcvm-msysgit@m.gmane.org; Wed, 12 Aug 2015 00:50:25 +0200
Received: by qkfn3 with SMTP id n3sf14658qkf.0
        for <gcvm-msysgit@m.gmane.org>; Tue, 11 Aug 2015 15:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=rjQziCLQKAjIKVmZ0t9yj3raZ9i6CTIKuPw8Uit1wqM=;
        b=qK5iH41P164TQm6GKFgZF2LqXwJN9ZFBVS6hAShGGEy/nIBSc9cGPkVhVHvzQi92KB
         gUoRimRU2jOOELeTVlSsc5FwGPyyetxlhE95E/JCR2oIdemAawgSbG5C8Lc22x7xJdXQ
         NeBf7weaM9cCc1s2A2WFtozZ8InkJwELU7Jbv5ugeRPeBqhg9HSpFsNKIwm3IzRiIM1r
         it+DVptF/lnurtxkvtHD560fepnprDnPkuEJxZuBnjrlVZVFyEzOh/G4ws6QL1uD/Lin
         ieyCc7xVSI1i3bgbcShGQ9FTTDQIENbJ6E0j4e7xXkkMZUi+HdHNr4DBn3nsrTw3vaii
         qrzA==
X-Received: by 10.50.138.70 with SMTP id qo6mr285689igb.5.1439333424620;
        Tue, 11 Aug 2015 15:50:24 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.157.132 with SMTP id g126ls17953ioe.82.gmail; Tue, 11 Aug
 2015 15:50:24 -0700 (PDT)
X-Received: by 10.50.114.41 with SMTP id jd9mr19426477igb.2.1439333424204;
        Tue, 11 Aug 2015 15:50:24 -0700 (PDT)
Received: from mail-yk0-x22c.google.com (mail-yk0-x22c.google.com. [2607:f8b0:4002:c07::22c])
        by gmr-mx.google.com with ESMTPS id g189si338450ywc.7.2015.08.11.15.50.24
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2015 15:50:24 -0700 (PDT)
Received-SPF: pass (google.com: domain of ericsunshine@gmail.com designates 2607:f8b0:4002:c07::22c as permitted sender) client-ip=2607:f8b0:4002:c07::22c;
Received: by mail-yk0-x22c.google.com with SMTP id z80so1431ykd.2
        for <msysgit@googlegroups.com>; Tue, 11 Aug 2015 15:50:24 -0700 (PDT)
X-Received: by 10.13.192.132 with SMTP id b126mr30921469ywd.163.1439333423944;
 Tue, 11 Aug 2015 15:50:23 -0700 (PDT)
Sender: msysgit@googlegroups.com
Received: by 10.37.208.78 with HTTP; Tue, 11 Aug 2015 15:50:23 -0700 (PDT)
In-Reply-To: <55CA6066.5070500@kdbg.org>
X-Original-Sender: sunshine@sunshineco.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of ericsunshine@gmail.com designates 2607:f8b0:4002:c07::22c
 as permitted sender) smtp.mailfrom=ericsunshine@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275739>

On Tue, Aug 11, 2015 at 4:51 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Invoking plink requires special treatment, and we have support and even
> test cases for the commands 'plink' and 'tortoiseplink'. We also support
> .exe variants for these two and there is a test for 'plink.exe'.
>
> On Windows, however, where support for plink.exe would be relevant, the
> test case fails because it is not possible to execute a file with a .exe
> extension that is actually not a binary executable---it is a shell
> script in our test. We have to disable the test case on Windows.
>
> Considering, that 'plink.exe' is irrelevant on non-Windows, let's just
> remove the test and assume that the code "just works".

putty and plink are used on Unix as well. A quick check of Mac OS X,
Linux, and FreeBSD reveals that package managers on each platform have
putty and plink packages available.

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t5601-clone.sh | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 9b34f3c..df69bf6 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -353,12 +353,6 @@ test_expect_success 'plink is treated specially (as putty)' '
>         expect_ssh "-P 123" myhost src
>  '
>
> -test_expect_success 'plink.exe is treated specially (as putty)' '
> -       copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink.exe" &&
> -       git clone "[myhost:123]:src" ssh-bracket-clone-plink-1 &&
> -       expect_ssh "-P 123" myhost src
> -'
> -
>  test_expect_success 'tortoiseplink is like putty, with extra arguments' '
>         copy_ssh_wrapper_as "$TRASH_DIRECTORY/tortoiseplink" &&
>         git clone "[myhost:123]:src" ssh-bracket-clone-plink-2 &&
> --
> 2.3.2.245.gb5bf9d3

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
