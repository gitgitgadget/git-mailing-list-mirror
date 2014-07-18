From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 4/6] t4210: skip command-line encoding tests on mingw
Date: Fri, 18 Jul 2014 11:52:39 +0200
Message-ID: <CABPQNSaiogqGryK8YOzQXs_z_syvXMBqvOpvGfMNdbLkNzRq_w@mail.gmail.com>
References: <20140716092959.GA378@ucw.cz> <1405611425-10009-1-git-send-email-kasal@ucw.cz>
 <1405611425-10009-5-git-send-email-kasal@ucw.cz>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Johannes Sixt <j6t@kdbg.org>, GIT Mailing-list <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBDR53PPJ7YHRBD65UOPAKGQE7IRK2JI@googlegroups.com Fri Jul 18 11:53:24 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBD65UOPAKGQE7IRK2JI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qg0-f57.google.com ([209.85.192.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBD65UOPAKGQE7IRK2JI@googlegroups.com>)
	id 1X84qv-0002zf-9t
	for gcvm-msysgit@m.gmane.org; Fri, 18 Jul 2014 11:53:21 +0200
Received: by mail-qg0-f57.google.com with SMTP id a108sf338196qge.22
        for <gcvm-msysgit@m.gmane.org>; Fri, 18 Jul 2014 02:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=2nkTwhbWLkGsHrJVFloJ6MDfyBpJpPannWg5KCh0ddU=;
        b=l3lk5vzPIPmwX8CmdrTn/oi3fpwJY1kEqP1PCmJXsvmVpNZpXikD1XQrHjCdWrfQ9w
         B9+udyqNII4IHpm8rSrHxTqQnxpr43yBdUd09uwEA8jcSgGYL/NcIBckLgez7Suck/Km
         1PFDXATsFdYjgQ2MYvW/V0Nly/288f/qCnk7iNqbKEAtUKkBuJCfajlYglClS++v3uFX
         uMHsZXHsoIrwLrjNLZJxq+GcyUv/7oQHKI5s961vaQEE5S42cGJ4+YHu5smfgtF8VPAb
         TGXEjIwpQscS66vbnROgxFIu120Ey8O9sWx9TK/2Ifb189Paf+SXm4SRR6aGZwDF8C6L
         XaNw==
X-Received: by 10.182.110.167 with SMTP id ib7mr30410obb.8.1405677200178;
        Fri, 18 Jul 2014 02:53:20 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.245.200 with SMTP id xq8ls861813obc.81.gmail; Fri, 18 Jul
 2014 02:53:19 -0700 (PDT)
X-Received: by 10.182.28.136 with SMTP id b8mr1841378obh.19.1405677199277;
        Fri, 18 Jul 2014 02:53:19 -0700 (PDT)
Received: from mail-ig0-x230.google.com (mail-ig0-x230.google.com [2607:f8b0:4001:c05::230])
        by gmr-mx.google.com with ESMTPS id q9si92250igp.2.2014.07.18.02.53.19
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 02:53:19 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::230 as permitted sender) client-ip=2607:f8b0:4001:c05::230;
Received: by mail-ig0-f176.google.com with SMTP id hn18so405767igb.3
        for <msysgit@googlegroups.com>; Fri, 18 Jul 2014 02:53:19 -0700 (PDT)
X-Received: by 10.50.4.9 with SMTP id g9mr5370167igg.42.1405677199139; Fri, 18
 Jul 2014 02:53:19 -0700 (PDT)
Received: by 10.64.246.129 with HTTP; Fri, 18 Jul 2014 02:52:39 -0700 (PDT)
In-Reply-To: <1405611425-10009-5-git-send-email-kasal@ucw.cz>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::230
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253807>

On Thu, Jul 17, 2014 at 5:37 PM, Stepan Kasal <kasal@ucw.cz> wrote:
> From: Pat Thoyts <patthoyts@users.sourceforge.net>
>
> On Windows the application command line is provided as unicode and in
> mingw-git we convert that to utf-8. So these tests that require a iso-8859-1
> input are being subverted by the encoding transformations we perform and
> should be skipped.
>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
>  t/t4210-log-i18n.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
> index 52a7472..9110404 100755
> --- a/t/t4210-log-i18n.sh
> +++ b/t/t4210-log-i18n.sh
> @@ -34,7 +34,7 @@ test_expect_success 'log --grep searches in log output encoding (utf8)' '
>         test_cmp expect actual
>  '
>
> -test_expect_success 'log --grep searches in log output encoding (latin1)' '
> +test_expect_success NOT_MINGW 'log --grep searches in log output encoding (latin1)' '
>         cat >expect <<-\EOF &&
>         latin1
>         utf8
> @@ -43,7 +43,7 @@ test_expect_success 'log --grep searches in log output encoding (latin1)' '
>         test_cmp expect actual
>  '
>
> -test_expect_success 'log --grep does not find non-reencoded values (utf8)' '
> +test_expect_success NOT_MINGW 'log --grep does not find non-reencoded values (utf8)' '

Perhaps these checks would be more readable a few years in the future,
if we make a separate capability along the lines of
NON_UNICODE_LOCALE?

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
