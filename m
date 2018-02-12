Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C6181F404
	for <e@80x24.org>; Mon, 12 Feb 2018 22:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932641AbeBLWOP (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 17:14:15 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:40136 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932563AbeBLWOO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 17:14:14 -0500
Received: by mail-qk0-f182.google.com with SMTP id e20so20273958qkm.7
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 14:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=A1tTnXIQ90bx9HPxPb9SfzWw7HGpgsuV96U85SI7lwI=;
        b=fiXpzB9ZjCvd/cS11jxTx8KAd8nR614XGxMYiossCCHRqSNFMiSxoQB16p5HfOqI+z
         Q1a4r81L07wBofasjqPOj2NldTo/DIeQMngghFp8El91VXyNac4tlolClpV3jcotUwtF
         F0OHU8RWdwBMTyPXa79MJ0TL1HliYpRBf2AIeyjug5P4eeufCZcTOGCE1qkbhZERaaaf
         zdBEkpLDSfOV1IP+LWvI3UIQrlKWBhNO9oGghwySR2U22RuSIDHXe13p8t9sISj4aVVB
         UPEQIp/ZrWOHzet1BLC/P47WbaDnxbJIp0qMYaKGrxie6/apYgL5o7inMk8Zs4cMPQIc
         DGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=A1tTnXIQ90bx9HPxPb9SfzWw7HGpgsuV96U85SI7lwI=;
        b=McZZAc5LQbrwbfcCS/DF4sizkaLu6F5sopPyQdjvO4tpCPSyVkAfetsvK+ywW6x3/6
         P01AgcTx5CReeew8rIJSwkye+f0uf9uIGOHS9wK0jfPyrWBlXnGYmuGdgbM7Vj0B3Dzb
         g2GlEd/20DavdIqgx4g9MCkMdyzmX4HBSn7ZU8nHWzVfbBXbJBQkMhDf5HunI3ZenQVR
         WgcdNHmaplPLEAFmoYOU28aAV90TQWykpoUe+zCCj5ia4TqmFXviCADv4+dp9z4sNlvA
         XS9hnGmmKbzDOLyDrwfL9TNXHq6wRNrT4TmshEbVnWTApyfYxj3oIf0zAqQ8SXDTjL5G
         Tnuw==
X-Gm-Message-State: APf1xPCYU3YmzACHiMkfku/7ibG65fvhs26RqdVdsFOETIokMOLW6LjF
        vx2pl1KPaO3LffkeF6p6Cr3xEtZW/8LL53u8m2I=
X-Google-Smtp-Source: AH8x224jvByGBx2wAQNeHN4ArrvOuuFGuo6QpBtDRiCTEo3yyS2+HmUxS9tuUD391/IDwWCqgfu49m74McIfKmrJrs4=
X-Received: by 10.55.36.68 with SMTP id w65mr18736761qkg.132.1518473653379;
 Mon, 12 Feb 2018 14:14:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.128.40 with HTTP; Mon, 12 Feb 2018 14:14:12 -0800 (PST)
In-Reply-To: <20180212201922.74051-1-sbeller@google.com>
References: <20180208222851.GA8850@sigill.intra.peff.net> <20180212201922.74051-1-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Feb 2018 17:14:12 -0500
X-Google-Sender-Auth: ooERhJ82Pvnw62OhV5j9YFUJ1Ug
Message-ID: <CAPig+cRUr=dJgaG2-aRArswQXXZEExQah4k17+HkiB+sZHORYQ@mail.gmail.com>
Subject: Re: [PATCH] color.h: document and modernize header
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 3:19 PM, Stefan Beller <sbeller@google.com> wrote:
> Add documentation explaining the functions in color.h.
> While at it, mark them extern and migrate the function `color_set`
> into grep.c, where the only callers are.

This re-roll no longer marks functions as 'extern', so the commit
message saying that it does seems rather odd.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/color.h b/color.h
> @@ -76,22 +76,47 @@ int git_color_config(const char *var, const char *value, void *cb);
> +/*
> + * Return a boolean whether to use color,
> + * resolving ambigious settings such as GIT_COLOR_AUTO, which is returned
> + * by git_config_colorbool().
> + */
>  int want_color(int var);

I'm probably being dense, but (if I hadn't had Peff's explanation[1]
to fall back on), based upon the comment block alone, I'd still have
no idea what I'm supposed to pass in as 'var'. Partly this is due to
the comment block not mentioning 'var' explicitly; it talks about
GIT_COLOR_AUTO and git_config_colorbool() abstractly, and, as a
reader, I can't tell if those are supposed to be passed in as 'var' or
if the function somehow grabs them out of the environment. Partly it's
due to the name "var" not conveying any useful meaning. Perhaps take
Peff's hint and state explicitly that the passed-in value is one of
GIT_COLOR_UNKNOWN, GIT_COLOR_NEVER, GIT_COLOR_ALWAYS, GIT_COLOR_AUTO,
then further explain that that value comes from
git_config_colorbool(), possibly modified by local option processing,
such as --color.

[1]: https://public-inbox.org/git/20180208222851.GA8850@sigill.intra.peff.net/

> +/*
> + * Output the formatted string in the specified color (and then reset to normal
> + * color so subsequent output is uncolored). Omits the color encapsulation if
> + * `color` is NULL. The `color_fprintf_ln` prints a new line after resetting
> + * the color. The `color_print_strbuf` prints the given pre-formatted strbuf
> + * instead, up to its first NUL character.
> + */

Perhaps prefix the last sentence with "BUG:" since we don't want
people relying on this NUL bug/misfeature.
