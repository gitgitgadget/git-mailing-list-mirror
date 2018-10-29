Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BC4D1F454
	for <e@80x24.org>; Mon, 29 Oct 2018 11:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbeJ2Ulb (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 16:41:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54673 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbeJ2Ul3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 16:41:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so7912218wma.4
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WCOKIWxKiFjxMROe++VJg3v7yb0pBSRZ6QS12pNtB3g=;
        b=r2clVJ8TnH4A4Bh9dxa9bsIT+SffXse4swWJ9tTQOn2OQHh9HKgBnCWT7XfdKP9WBP
         7YPUuAzAGaJquCx+5J2F9AZ0ufGe4CqNNkHQVsXIYgbrnaVlk1m15vjnNNYneriJQzs+
         HGBkTTnhmJARZeOLLqCav1un2ruHnO5lKmWJviU3jKaZIthju6Nyyl1hFuuu/13UjPrD
         YsFiA99jdi9r15gNp6d2IJtsjGlcMRwQLD33AguDH7wYXWb0kmR9yGjs7cboGHFaDeMv
         jxCDRg5kVcyD4BAqzdz5WA2DqopfY/tSu8VuBxNLYtOtBzAyV3z4brBo29qAAoK6Bqur
         XB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WCOKIWxKiFjxMROe++VJg3v7yb0pBSRZ6QS12pNtB3g=;
        b=S5DFWszIRCOCRcTCvK6qGskMaDjo+SxuEwBNQrhYkf67tlENmsYBJ0QSOX2QhhDXhD
         zrZJkZZU87mtK7hh/MSizGDMQvoy/VBZw42FLpcgpj2pQqCslYVdWnh7ZRiEBnPoRwaG
         v3SYdIXljYZcszrTpm6Ruixy66V9B4FAxhCnhkDgRGdG78nUavgO6ejGfybLIFzivxVF
         5KMnf+TDRNhutn3n5f2GX+EASOo00zXHI8u8ZJ7NyCWrzJnSQAXqXyV52FGfmxgTSEvS
         xsyxV8D8jdTDwgv1nDgw1jRY4yNdNapu293ymHQ1R66iWgIoFF6OTir7kpwzNW8FbAHO
         b1QA==
X-Gm-Message-State: AGRZ1gJ7WCWKsiGr0sJb+CAbTiLuFuZfEl39OLD5j+/oex6QY75Lrygr
        nyA8kgP65kTQaj0HCob2rWU=
X-Google-Smtp-Source: AJdET5dSQ+kTW9AjLJTiLmqgpCeqlqWiSXfcRhAmRJFWTmsYETjodoY94qC6CD+QgBWzgrL71taMug==
X-Received: by 2002:a1c:b143:: with SMTP id a64-v6mr13899825wmf.109.1540813987600;
        Mon, 29 Oct 2018 04:53:07 -0700 (PDT)
Received: from szeder.dev (x4d0c66d6.dyn.telefonica.de. [77.12.102.214])
        by smtp.gmail.com with ESMTPSA id q77-v6sm11426735wmd.33.2018.10.29.04.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 04:53:06 -0700 (PDT)
Date:   Mon, 29 Oct 2018 11:53:04 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 12/12] fsck: mark strings for translation
Message-ID: <20181029105304.GP30222@szeder.dev>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181028065157.26727-13-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181028065157.26727-13-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 28, 2018 at 07:51:57AM +0100, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/fsck.c             | 113 ++++++++++++++++++++-----------------
>  t/t1410-reflog.sh          |   6 +-
>  t/t1450-fsck.sh            |  50 ++++++++--------
>  t/t6050-replace.sh         |   4 +-
>  t/t7415-submodule-names.sh |   6 +-
>  5 files changed, 94 insertions(+), 85 deletions(-)
> 
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 06eb421720..13f8fe35c5 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -108,8 +108,9 @@ static int fsck_config(const char *var, const char *value, void *cb)
>  static void objreport(struct object *obj, const char *msg_type,
>  			const char *err)
>  {
> -	fprintf(stderr, "%s in %s %s: %s\n",
> -		msg_type, printable_type(obj), describe_object(obj), err);
> +	fprintf_ln(stderr, _("%s in %s %s: %s"),

Are the (f)printf() -> (f)printf_ln() changes all over
'builtin/fsck.c' really necessary to mark strings for translation?

> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 90c765df3a..500c21366e 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh

> @@ -594,7 +594,7 @@ test_expect_success 'fsck --name-objects' '
>  		remove_object $(git rev-parse julius:caesar.t) &&
>  		test_must_fail git fsck --name-objects >out &&
>  		tree=$(git rev-parse --verify julius:) &&
> -		egrep "$tree \((refs/heads/master|HEAD)@\{[0-9]*\}:" out
> +		test -n "$GETTEXT_POISON" || egrep "$tree \((refs/heads/master|HEAD)@\{[0-9]*\}:" out

'test_i18ngrep' accepts all 'grep' options, so this could be written
as:

  test_i18ngrep -E "..." out


There might be something else wrong with the patch, because now this
test tends to fail on current 'pu' on Travis CI:

  [... snipped output from 'test_commit' ...]
  +git rev-parse julius:caesar.t
  +remove_object be45bbd3809e0829297cefa576e699c134abacfd
  +sha1_file be45bbd3809e0829297cefa576e699c134abacfd
  +remainder=45bbd3809e0829297cefa576e699c134abacfd
  +firsttwo=be
  +echo .git/objects/be/45bbd3809e0829297cefa576e699c134abacfd
  +rm .git/objects/be/45bbd3809e0829297cefa576e699c134abacfd
  +test_must_fail git fsck --name-objects
  +_test_ok=
  +git fsck --name-objects
  +exit_code=2
  +test 2 -eq 0
  +test_match_signal 13 2
  +test 2 = 141
  +test 2 = 269
  +return 1
  +test 2 -gt 129
  +test 2 -eq 127
  +test 2 -eq 126
  +return 0
  +git rev-parse --verify julius:
  +tree=c2fab98f409a47394d992eca10a20e0b22377c0c
  +test -n 
  +egrep c2fab98f409a47394d992eca10a20e0b22377c0c \((refs/heads/master|HEAD)@\{[0-9]*\}: out
  error: last command exited with $?=1
  not ok 65 - fsck --name-objects

The contents of 'out':

  broken link from    tree be45bbd3809e0829297cefa576e699c134abacfd (refs/heads/master@{1112912113}:caesar.t)
                to    blob be45bbd3809e0829297cefa576e699c134abacfd (refs/heads/master@{1112912113}:caesar.t)
  missing blob be45bbd3809e0829297cefa576e699c134abacfd (refs/heads/master@{1112912113}:caesar.t)

On a related (side)note, I think it would be better if this 'grep'
pattern were more explicit about which of the three lines it is
supposed to match.


Anyway, I couldn't reproduce the failure locally yet, but, admittedly,
I didn't try that hard...  And my builds on Travis CI haven't yet come
that far to try this topic on its own.

