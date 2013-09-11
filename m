From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Regression in e02ca72: git svn rebase is broken on Windows
Date: Wed, 11 Sep 2013 07:43:07 +0200
Message-ID: <523002EB.3010706@kdbg.org>
References: <17231378818848@web5m.yandex.ru> <xmqq38pczjw6.fsf@gitster.dls.corp.google.com> <CANYiYbFaNP=UUKX-5N7qQppMRehuPgn8p1uN_UOJ6bDwTjzKEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
 Tvangeste <i.4m.l33t@yandex.ru>,
 msysgit@googlegroups.com
To: Jiang Xin <worldhello.net@gmail.com>
X-From: msysgit+bncBCJYV6HBKQIO3BOASECRUBHVZPNA4@googlegroups.com Wed Sep 11 07:43:10 2013
Return-path: <msysgit+bncBCJYV6HBKQIO3BOASECRUBHVZPNA4@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f55.google.com ([74.125.83.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIO3BOASECRUBHVZPNA4@googlegroups.com>)
	id 1VJdCo-0006cp-A8
	for gcvm-msysgit@m.gmane.org; Wed, 11 Sep 2013 07:43:10 +0200
Received: by mail-ee0-f55.google.com with SMTP id l10sf873034eei.0
        for <gcvm-msysgit@m.gmane.org>; Tue, 10 Sep 2013 22:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=DguV0CI0gptDkWLlb+XMzm6h6Y2Xj0kfnBkInphqf2o=;
        b=zSvFREMCx43JAwhWllysNEa3T4lwTgmcW14EqDI6dcIf0ZnfHe0XAyeKZKXcxmb7u3
         ObTdbt+8Q/ij5GbgkKmuXDfyjoGPhiIAgmh8FknYkKMa4AYppCpK7ftUzN50l1ER+FYS
         tkr6KMuDXeZHgRTcTq+OWUC7DIQgLIhWVMBtsrTkGX4nowfo4LeGpB/DNGy5pU1ZblZy
         0vAUaQnW76Q0p04dOsWONe1rfhNLJcqmFMMrDBYOm44a5p1RZMW/5KHMAlMf00xEEPd7
         WE+IC9aUEPKvj6pneUaLvjIFoP4bZwSzoqmbV94hPMTRla6I0IKBdoSp3FlkSEJ1Qh8X
         EDew==
X-Received: by 10.180.80.39 with SMTP id o7mr331516wix.11.1378878190041;
        Tue, 10 Sep 2013 22:43:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.181.13.176 with SMTP id ez16ls59522wid.23.gmail; Tue, 10 Sep
 2013 22:43:09 -0700 (PDT)
X-Received: by 10.15.64.6 with SMTP id n6mr5660107eex.5.1378878189321;
        Tue, 10 Sep 2013 22:43:09 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp5.bon.at. [195.3.86.187])
        by gmr-mx.google.com with ESMTPS id a1si3620317ees.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 22:43:09 -0700 (PDT)
Received-SPF: neutral (google.com: 195.3.86.187 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.187;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 62E0CA7EB5;
	Wed, 11 Sep 2013 07:43:08 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8B26319F626;
	Wed, 11 Sep 2013 07:43:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CANYiYbFaNP=UUKX-5N7qQppMRehuPgn8p1uN_UOJ6bDwTjzKEQ@mail.gmail.com>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 195.3.86.187 is neither permitted nor denied by best guess
 record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234522>

Am 11.09.2013 05:19, schrieb Jiang Xin:
> I tested 'relative_path' function using 'test-path-utils', and got the
> following result:
> 
>     $ ./test-path-utils relative_path 'C:/a/b' 'D:/x/y'
>     ../../../C:/a/b
> 
>     $ ./test-path-utils relative_path '/a/b' 'x/y'
>     ../..//a/b
> 
>     $ ./test-path-utils relative_path 'a/b' '/x/y'
>     ../../../a/b
> 
> For the first case, in and prefix are on different ROOT, and for the other
> two cases, one path is a relative path, and another is an absolute path.
> 
> I write a patch to test whether two paths (in and prefix) have the same
> root. The result after applied the patch:
> 
>     $ ./test-path-utils relative_path 'C:/a/b' 'C:/x/y'
>     ../../a/b
> 
>     $ ./test-path-utils relative_path 'C:/a/b' 'D:/x/y'
>     C:/a/b
> 
>     $ ./test-path-utils relative_path '/a/b' 'x/y'
>     /a/b
> 
>     $ ./test-path-utils relative_path 'a/b' '/x/y'
>     a/b
> 
> 
> diff --git a/path.c b/path.c
> index 7f3324a..51f5d28 100644
> --- a/path.c
> +++ b/path.c
> @@ -441,6 +441,25 @@ int adjust_shared_perm(const char *path)
>         return 0;
>  }
> 
> +static int have_same_root(const char *path1, const char *path2)
> +{
> +       /* for POSIX:
> +
> +          return ((path1 && is_dir_sep(*path1)) ^
> +                  (path2 && is_dir_sep(*path2))) == 0;
> +       */
> +       return path1 && path2 && *path1 && *path2 && (
> +               (is_dir_sep(*path1) &&
> +                is_dir_sep(*path2)) ||
> +               (*(path1+1) == ':' &&
> +                *(path2+1) == ':' &&
> +                !strncasecmp(path1, path2, 1)) ||
> +               (!is_dir_sep(*path1) &&
> +                !is_dir_sep(*path2) &&
> +                *(path1+1) != ':' &&
> +                *(path2+1) != ':'));

I think this can be simplified to

	return path1 && path2 &&
		is_absolute_path(path1) &&
		is_absolute_path(path2) &&
		!strncasecmp(path1, path2, 1);

which would not mistake a path D:/foo on Unix as an absolute path.

> +}

-- Hannes

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
