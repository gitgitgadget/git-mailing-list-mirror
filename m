Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EA421F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 21:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754508AbeGFV72 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 17:59:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36567 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754498AbeGFV70 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 17:59:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id s14-v6so15647685wmc.1
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 14:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QLuFuJGPywtZai2k5l/q3k6fucUp+qjfffDaVxmHdWM=;
        b=TKO4j+IrmpLceLhps+WBwTFdqeRWUS4NzhpiEyhXARhpqkX79GGOCCoXpCnN56py2s
         gNO5f55aIyv8IyC6w4yeFflAm5f7p8MpObopPsDeATYdI9l+7DGnchOAWXqVDeiLUNpx
         WzKIhS/4C+h3UqYdu4VLDTZTbY7bV38flH2hOZZlmavs9G4QtsOS8ZEKbZZdm4xQSDK+
         aMA50g8OYP40zZ18g/AvPWL4/VoaS7PbhiXuhI0g/eyZ/49/Rd4y1Z5n9YGlUXMArMzA
         C+Ik/wlY55mRF/sbye7tOXfI4XfqF4TM5KGPFhmMch1QyvdjNc3MPmtgEtVrsyLkJmlk
         Bv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QLuFuJGPywtZai2k5l/q3k6fucUp+qjfffDaVxmHdWM=;
        b=YU5YUcWzYJe551Q+ppQEZ8n3BkWegbdSA9BDO/So/niY34mLey5E6cmJR9hM+J4FME
         iwbr8vMNEqp3SK9FrOgeHEtbkQ9+pBmoaQsokXZvUNzZlELKCfSB9C9uKntEKTVQ6bzK
         jiI70/815Z7qlFpcZQs1pbtAeZBrqXpwFdnBUz93aJ3ThyHhYWbU9849KWilzpqovaVL
         xfOvYZNkS0/EBJC0YKMUc3yW+jju/X1KcOVWWPqr0ay42aUsLrr9OTWuWmnWEbEhSgiF
         5PhbjYnqyu1uFS6ZpPgR83RKLb40sw4gfxehnpDaOP+QHe54MoI9wqJFXxl7Oz0cfd/a
         uMIQ==
X-Gm-Message-State: APt69E33B+CEgfgiop7vbHi5pjtq6FkjI7R73MHsKmZtDPolqKhohOaM
        Cr3/ioSlqEvZleqOt7Ufs6qs/3XG
X-Google-Smtp-Source: AAOMgpeSD/Aq84ITYLbMQIbqBoQRyWi/UA/0OE3lRfqNV1ZBVx7SKl+Wd/Q7P68+1XKv0BTnyv9XcQ==
X-Received: by 2002:a1c:1314:: with SMTP id 20-v6mr7142573wmt.55.1530914365006;
        Fri, 06 Jul 2018 14:59:25 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x6-v6sm12175337wrd.57.2018.07.06.14.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:59:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kana Natsuno <dev@whileimautomaton.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] t4018: add missing test cases for PHP
References: <20180703131540.60789-1-dev@whileimautomaton.net>
        <20180703131540.60789-2-dev@whileimautomaton.net>
Date:   Fri, 06 Jul 2018 14:59:23 -0700
In-Reply-To: <20180703131540.60789-2-dev@whileimautomaton.net> (Kana Natsuno's
        message of "Tue, 3 Jul 2018 22:15:39 +0900")
Message-ID: <xmqq36wwhvpg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kana Natsuno <dev@whileimautomaton.net> writes:

> A later patch changes the built-in PHP pattern. These test cases
> demonstrate aspects of the pattern that we do not want to change.
>
> Signed-off-by: Kana Natsuno <dev@whileimautomaton.net>
> ---
>  t/t4018/php-class    | 4 ++++
>  t/t4018/php-function | 4 ++++
>  t/t4018/php-method   | 7 +++++++
>  3 files changed, 15 insertions(+)
>  create mode 100644 t/t4018/php-class
>  create mode 100644 t/t4018/php-function
>  create mode 100644 t/t4018/php-method
>
> diff --git a/t/t4018/php-class b/t/t4018/php-class
> new file mode 100644
> index 0000000..7785b63
> --- /dev/null
> +++ b/t/t4018/php-class
> @@ -0,0 +1,4 @@
> +class RIGHT
> +{
> +    const FOO = 'ChangeMe';
> +}
> diff --git a/t/t4018/php-function b/t/t4018/php-function
> new file mode 100644
> index 0000000..35717c5
> --- /dev/null
> +++ b/t/t4018/php-function
> @@ -0,0 +1,4 @@
> +function RIGHT()
> +{
> +    return 'ChangeMe';
> +}
> diff --git a/t/t4018/php-method b/t/t4018/php-method
> new file mode 100644
> index 0000000..03af1a6
> --- /dev/null
> +++ b/t/t4018/php-method
> @@ -0,0 +1,7 @@
> +class Klass
> +{
> +    public static function RIGHT()
> +    {
> +        return 'ChangeMe';
> +    }
> +}

I no longer speak PHP, and certainly not the modern variant, but
these examples all look good to me.  

Whoever invented the convetion to use RIGHT/ChangeMe in t4018 should
get praised---its brilliance shines in new tests like these ;-)


