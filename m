Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjaXbzHK"
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC24A116
	for <git@vger.kernel.org>; Sun,  3 Dec 2023 00:22:12 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d0897e99e0so808105ad.3
        for <git@vger.kernel.org>; Sun, 03 Dec 2023 00:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701591732; x=1702196532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pYRTSlJfQlbdyROcC6VWnV9jXr8Wb1iTx+j93/0JHQs=;
        b=jjaXbzHKIIuf9k65+BbNfFUX7RverF0tRbPFWcTKm8J70r1kWUqT5aWk9aglerrFwa
         sQoikJB2eZRPbWo1gDiHezxkc2bvNo61wrfyUwFFytUmnXI29fC2gB+606X0Z3unRl90
         C4Ex1Opd4W2bpcMtTBOeQ6SKrFw9O12y9WQGR5FIEw4cCWmdGW1vBkIioedDzqLnWxBH
         39luIejAFc5s5HWjHsfeUYvl8FlNuq1S3WbWLFPSnqXeHjhLWtl4vfm3XJp0de4ACFCr
         geiH0tgovR9yB0hbYlVr+ZZUWSyaaLdpl9H93vl9MSmnCB5MHSa7/eAGj0ZYcRYGRaN9
         p/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701591732; x=1702196532;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYRTSlJfQlbdyROcC6VWnV9jXr8Wb1iTx+j93/0JHQs=;
        b=ZdQMobG9LocJRTz9qClHLo5PBDY7oalzmMMacPt6Vji4Y+gVAX50r3e4Y2cW/gW/Cs
         CuKexaAw1rG+UxD0JCNRS+ZhNEz84SE2cpBElT1WmJVANJ1R42eE6QLAprudZbCFS8/I
         gXy0zSTs7KMZGo/cKGDocjvR4k0/bYdgUDz0VC1n3Mnc9TE77UoeZEGQtA5v1Pyqq/6Z
         7+brBtT5WMg2sZdQ47ML5qVEd7DvkipDxHLDHPHwt+Q41HqVsJIKnQniBYFARiIaCdwM
         J7GmCt2X18A42CYIwCbyQqJ3P9Hz3BM2BGMt/lmHG11Gmpd85yb2BnMs9N2gED7DxfWr
         NRqQ==
X-Gm-Message-State: AOJu0Yxla+X2YltuqbiGZQQXYIri4sf3lVI3WqXTLQy3vH2p6+KnCSW7
	YDrrv/1zK/IKA1R9iD/NKm4=
X-Google-Smtp-Source: AGHT+IFJ0yKFzXtO4Gdu2mMqZh9UY99l29DAUfavQ31xZr+yHGzZ2x2w6U3K9o+SJrRFzgmPl13OkQ==
X-Received: by 2002:a05:6a20:914e:b0:187:d44:59f1 with SMTP id x14-20020a056a20914e00b001870d4459f1mr595845pzc.31.1701591731982;
        Sun, 03 Dec 2023 00:22:11 -0800 (PST)
Received: from five231003 ([202.65.154.98])
        by smtp.gmail.com with ESMTPSA id j20-20020a170902759400b001c74df14e6fsm6251232pll.284.2023.12.03.00.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 00:22:11 -0800 (PST)
Date: Sun, 3 Dec 2023 13:52:07 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [Patch] test-lib-functions.sh : change test_i18ngrep to test_grep
Message-ID: <ZWw6r2EDGkpgyYEM@five231003>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPYXD64yCuMta_iGE+ZwgxrJn0U5shcwcB9jaiNkFhvff=R7MQ@mail.gmail.com>

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> wrote:

> Subject: [Patch] test-lib-functions.sh : change test_i18ngrep to test_grep

For anyone reading the subject, I think reading

	change test_i18ngrep to test_grep

would be confusing, as from the looks of it, the patch does remove
test_i18ngrep() and replace it with test_grep (I mean the plan is to
remove test_i18ngrep only after we are sure that it doesn't exist in the
code anywhere, anymore) but only making a change in the wording of an
error message within test_grep().

Also I think we can drop the SP after "related topic" part of the patch
and the colon (but have the SP after the colon), that is

	"test-lib-functions.sh: ..."

Also, nit, but I think we should have [PATCH] instead of [Patch]. I'm not
really sure if Junio's setup treats [PATCH] and [Patch] to be same :)

> Recently the test_i18ngrep was deprecated from the source code and
> test_grep was implemented but in the test-lib-functions.sh file , in
> the test_grep() function definition,

This recent deprecation was made in the commit,
2e87fca189 (test framework: further deprecate test_i18ngrep, 2023-10-31)
and it makes sense to include it in the commit message as the following
change is essentially something that the previous commit seems to have
forgotten to do.

> it is written BUG "too few parameters to test_i18ngrep".

I think it is not necessary to mention what is the current code
in _this case_ as it can be read in the change itself :)

> So the following patch solves the minor problem.

What exactly is the problem? I think it should be mentioned in the commit
message that the wording of the error message causes confusion ;) as when
test_grep() is used in a test and this test fails. That the change is - it
would be clear to see

	"too few parameters to test_grep"

instead of

	"too few parameters to test_i18ngrep"

> Signed-off-by: Shreyansh Paliwal <Shreyanshpaliwalcmsmn@gmail.com>
> ---
>  t/test-lib-functions.sh | 2 +-
>  1 file changed, 1 insertions(+), 1 deletions(-)
> 
>  t/test-lib-functions.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)diff --git
> a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 9c3cf12b26..8737c95e0c 100644
> --- a/t/test-lib-functions.sh
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1277,7 +1277,7 @@ test_grep () {
>         if test $# -lt 2 ||
>            { test "x!" = "x$1" && test $# -lt 3 ; }
>         then
> -               BUG "too few parameters to test_i18ngrep"
> +               BUG "too few parameters to test_grep"
>         fi
> 
>         if test "x!" = "x$1"
> --
> 2.43

The diff format doesn't seem proper (some repeated lines and no newlines
at the required places).

If you have no go-to tool to send patches through email then git-send-email
is a really good tool to do it. It handles most of the work for you.
"MyFirstContribution" has a guide to do so

	https://git-send-email.io/ (also has setup with GMail)
	https://git-scm.com/docs/MyFirstContribution#howto-git-send-email

Another good resource which is not linked often is

	https://flusp.ime.usp.br/git/sending-patches-by-email-with-git/

by Matheus Tavares, also a Git Contributor. It also has other useful links
which are worth a read.

Thanks
