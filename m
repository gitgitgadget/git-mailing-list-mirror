Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37324C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 04:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244716AbiBBE7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 23:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244693AbiBBE7N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 23:59:13 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1480C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 20:59:12 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id u13so21472587oie.5
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 20:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6Z5VIKuPCHa2MEdIq+wtOvkbG5LoIKkNmJmwSOaCD4=;
        b=g29v2r63R+Oc+YR/GQZifSpLg2BYVUskmdy8B2jGZzOZVIa7U8F2dHspUuNrbZa9pK
         Stv/LcE+TCvaFeXfNgcR6q9JgScg9TVebPFNTpyaqw23RZZSvbhUgWWjAOayZvCnUqQ5
         7O3GaWAIzSzL0nT3/hVa9kYPPzLzhQMArX/kh5E4NuE4wgjHH8MLDs1TrM0C457jt9Wd
         jjuBIroQyKtELuE17MZKlY7DbPXUgU4RALLVWcM55hacAmRupqrWSKvgmf1sd5i4AkoF
         zHQbUs+dEXK5wlKjY8zqERc5yphBBPv7vhP8Vi7V25fxGTGZDsrToblo7xXK/RXLBCyJ
         0O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6Z5VIKuPCHa2MEdIq+wtOvkbG5LoIKkNmJmwSOaCD4=;
        b=ZutQFWz8AdZkLfXAOSc/zUXDir89rl/H2F5IRAjdMW6ynDBww4swsRrB+NR46Zd+LF
         hhHONbHIHZjO1ybPbjCQ0kukWhOBVO6+2yFQRXSQy+19AyKtbjIITY0zvpYpIJXR/2z/
         Qt72s+pTkJMBjUJGO7qVffSXbXZdgDxp1++zy+rJ/0DIljnIN5tIyyJ26y/iPDviqNyB
         fEhT7KqLqJLVsoaOfI0g7KMzdmHZEBczwB3uSh/ACiWDUwj184YzhaAmx/CY/emhg2vp
         xF7cccNRknKkbLbvMqoUPdJHRa4NnCUzDCL8tul2mGIKIrRy4/6IYuWrVAB78xpVT6A+
         6ggA==
X-Gm-Message-State: AOAM533dgFHTCB2XHTEAwNjbv6coUz/jgA6xRiqeg94WCjO46t0o9g6u
        Npgf4xd72NdV4iC//cLW82stFuEpWF0zcD27IHlc21cpmbi5JQ==
X-Google-Smtp-Source: ABdhPJxm0CLSnAi4xz9FMll0noFGkMRXM/2W1KkaEst7GD1maNUXvXDzIf8MCkOgOL8bTlUuthVa4TFl1dbEtcuwGcU=
X-Received: by 2002:aca:5e55:: with SMTP id s82mr3360522oib.109.1643777952208;
 Tue, 01 Feb 2022 20:59:12 -0800 (PST)
MIME-Version: 1.0
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
 <20220130094357.515335-1-shaoxuan.yuan02@gmail.com> <20220130094357.515335-3-shaoxuan.yuan02@gmail.com>
 <xmqqv8xy87io.fsf@gitster.g>
In-Reply-To: <xmqqv8xy87io.fsf@gitster.g>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Wed, 2 Feb 2022 12:59:00 +0800
Message-ID: <CAJyCBORJ=_EO43qfcBkbTdzY74RBeP67zfUqAcJz_WkcfqBmYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] t/lib-read-tree-m-3way: replace spaces with tabs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 2, 2022 at 7:57 AM Junio C Hamano <gitster@pobox.com> wrote:
> I'd view "replace spaces with" as a way to achieve "indent with
> tabs".

Oh my. It looks so noob to say "replace spaces with".
And for sure this is a much better way to phrase it. Guess I was having some
turbulence writing this patch, I should phrase it like that ;-)

>     t/lib-read-tree-m-3way: indent with tabs
>
>     As Documentation/CodingGuidelines says, our shell scripts
>     (including tests) are to use HT for indentation, but this script
>     uses 4-column indent with SP.  Fix this.
>
> or something like that, perhaps?

Learned the present tense and imperative mood :)

--
Thanks,
Shaoxuan
