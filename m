Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 144F81F404
	for <e@80x24.org>; Thu,  8 Mar 2018 19:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932125AbeCHT3i (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 14:29:38 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36935 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbeCHT3h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 14:29:37 -0500
Received: by mail-wr0-f194.google.com with SMTP id z12so6812227wrg.4
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 11:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=isnu6ZQ0JJ3iY4QL+sO8ymRGDbMQ0z0eunQSwCQE3vk=;
        b=iScWMMnJSE4k7JO7BBSkFrDMIM2sIe6sSpOq77Gh5LrANoXf5G8fACzXUg0XDBL4h4
         vye3IGi1wBTTr2gTkXT3hEURmr7M7b9apuiSvU1b/rxhQwWL+YITjzdfgFbzlGPfOoMV
         lcnnGhG7SimjWhW0vdf7uKLR5mcQrqJoMU6fdQx/sOXUFByANpfn5idR1hSoH62PC7i6
         Nxm3KJ3gO0a14AdBxb9zXqqZ8LDpY19L1cZGequ7xfvTs2+mykrtKoLlYTES491rdAyB
         F5oeiwNRJXOrm8eydP9HQGYo9lW3KG6l4cXJJNDPlB8wXZqggI1ZaPqDYKysetOOjj1N
         fMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=isnu6ZQ0JJ3iY4QL+sO8ymRGDbMQ0z0eunQSwCQE3vk=;
        b=PbqhYj46m8K7W4AdR/i9sAYmg5NnUizYechL/MIGMB6dX/dPP3xxFuE29oFkPayHY8
         bUZSgASegnOMNpcsYSqy8qUe6xq3bLsOlGUw58BxteEIuaDij0QHQsuRf3DqZZOe3ocn
         rCshWNsw1mhZl6PmSsqdu8F09Sx4Kb1elPyJnnjNAFMHDtFuzRiuwyHG4/TI5RYcH0/y
         uvTvRR9VqjAVwMAH4c8EVPPZMmwgn7+36/Y5PwvQeCbX40VDc/jJObFnIjO2Y6rU2unk
         zbdu4zuMfuLkFNbzuj3eUSCDNqiGOTRmt+G20YSWzLciLpfMMEXVd5pXFiTQZwRlmltD
         oMWg==
X-Gm-Message-State: APf1xPBJBuTmYQWwQYewM6zIPkgXL7dlsW2bpzkhLvZKGY0MFDAhByok
        emAZlTdTi/MzrEWPHTMHhY/Ff74x
X-Google-Smtp-Source: AG47ELsQDLc+dBHdnZOdSy59pHWjhjUwnstm1iyWGHYLZSyI/xfb18pcEovmQyM+p9LQARsQfbl5Gw==
X-Received: by 10.223.175.230 with SMTP id y38mr23495522wrd.26.1520537375694;
        Thu, 08 Mar 2018 11:29:35 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 4sm12705131wmz.31.2018.03.08.11.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Mar 2018 11:29:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] git manpage: note git-security@googlegroups.com
References: <20180308150820.22588-1-avarab@gmail.com>
Date:   Thu, 08 Mar 2018 11:29:34 -0800
In-Reply-To: <20180308150820.22588-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 8 Mar 2018 15:08:20 +0000")
Message-ID: <xmqqmuziweld.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Add a mention of the security mailing list to the "Reporting Bugs"
> section. There's a mention of this list at
> https://git-scm.com/community but none in git.git itself.

This is quite a sensible thing to do.

>
> The copy is pasted from the git-scm.com website. Let's use the same
> wording in both places.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> Someone at Git Merge mentioned that our own docs have no mention of
> how to report security issues. Perhaps this should be in
> SubmittingPatches too, but I couldn't figure out how that magical
> footnote format works.

The "Notes from the maintainer" posted periodically here for
developers does mention it, and I do agree with you that
SubmittingPatches is a good place to add it, as it is a document
that is targetted more towards developers.  But this is a good first
step.

Will queue.

>
>  Documentation/git.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 8163b5796b..4767860e72 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -849,6 +849,9 @@ Report bugs to the Git mailing list <git@vger.kernel.org> where the
>  development and maintenance is primarily done.  You do not have to be
>  subscribed to the list to send a message there.
>  
> +Issues which are security relevant should be disclosed privately to
> +the Git Security mailing list <git-security@googlegroups.com>.
> +
>  SEE ALSO
>  --------
>  linkgit:gittutorial[7], linkgit:gittutorial-2[7],
