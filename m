Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2D8F1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 17:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbeGZTLX (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 15:11:23 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:37042 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbeGZTLX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 15:11:23 -0400
Received: by mail-yw0-f194.google.com with SMTP id w76-v6so885651ywg.4
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tnf9H4L9ySr6Up/4b/QlZ/3hV9Hsxfbk4NiISH70svs=;
        b=LPXJDkxs6QeM0Hc9iIXVcJP0MMXvP93rhO8XHdTTZSro7st5xQhknQeZxhYid8n9cc
         729ijCy29VdslZh2eKqUYhjNWoN6kL+iCxq39kL0vCPHnlq6Wb+YtSRWNhl8R3tHHkiq
         Lg//gojUvKqkInf8EUuViBboeXNMG1snlM5OWvIESzRS6goN0zfRNq8tk29XyozElGUK
         BYpzwiUfcVz0m/TI2O28NunVEKV14ja2OAv3m9nxRdtcUtU32TU63w4yIK4Hm3vNPppl
         Ma8sCSNvs5/TbVk6Tsr2qs+MqIEnI2vP25Td4RTRNlz5IwPJ5tkdUrPumnghZZZyQy8v
         Xz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tnf9H4L9ySr6Up/4b/QlZ/3hV9Hsxfbk4NiISH70svs=;
        b=cVgBkOQOSufFp47Afz+bKwhV+JAi8uoktZL/BPJlPY7Vr+4tRDVBldCFfguJRMMuZh
         LAJgAIRPypEYKME11LfcyFn3A0zQfU/TC6g7GPuPfH1PD8Pq9RWVLlX22pYZWYjgq+ZO
         PQAdw7r0TkwkSTkd25brlkenePAAU8+CJepsJffZUOvr8+zhYpkOSyX/KZBkljiRZMo7
         Y3SgCqguR4jdl14BUWuhcziQGOyD/ZI/A97h8hrkO3K2OKL2UlozlwzJRvaEtdJ4Rl0l
         JeBFOItMTaDuTybunQWyDzC+fdLmTuJ919Ve6KBhGxSQ0WRRgP8chUO5E5zczK66au/h
         jMOw==
X-Gm-Message-State: AOUpUlGJgafyMuzundwjvsy0gxwJS1xDXqTu8rZ9WGTIieKyAwcb8Ry3
        IAkc/nAEctDCPVhPmuAxloBZQNOj+38r8TCHzs3yBQ==
X-Google-Smtp-Source: AAOMgpfymg16R0w2brKcxhfb2bOXU/CTcYS6QIQ/x8Fmm7lW7iHaCuziJcy/aw9IjonXAIuACzglszoO5ErzGt7uXpM=
X-Received: by 2002:a81:af67:: with SMTP id x39-v6mr1487621ywj.33.1532627608847;
 Thu, 26 Jul 2018 10:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180726171751.178616-1-hanwen@google.com>
In-Reply-To: <20180726171751.178616-1-hanwen@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 26 Jul 2018 10:53:17 -0700
Message-ID: <CAGZ79kaj3ptbSrWfrZhRjcz1fsCmO_sR5qCfL=F1ZYwwJRBaMA@mail.gmail.com>
Subject: Re: [PATCH] RFC Highlight keywords in remote sideband output.
To:     Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        ryandammrose@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 26, 2018 at 10:18 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
>
> Supported keywords are "error", "warning", "hint" and "success".

Thanks for taking this upstream. :-)

>
> TODO:
>  * make the coloring optional? What variable to use?

This is the natural extension of the topic merged at a56fb3dcc09
(Merge branch 'js/colored-push-errors', 2018-05-08), which was merged
rather recently, so I'd think extending the color.transport option would be
useful here. (cc'd the authors of that series)

>  * doc for the coloring option.



>  * how to test?

I think the best way to get started with a test is to be inspired by
8301266afa4 (push: test to verify that push errors are colored,
2018-04-21) from that series.

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> Change-Id: I090412a1288bc2caef0916447e28c2d0199da47d

We do not do Change-Ids in git upstream. :/
As different workflows have different edges, everyone has their own
little script to deal with those. For example Brandon has
https://github.com/bmwill/dotfiles/blob/master/bin/check-patch
that contains a section to remove change ids

    # Remove Change-Id from patch
    sed -i "/Change-Id:/d" "$f"

> +void emit_sideband(struct strbuf *dest, const char *src, int n) {

Coding style: we start the brace in the next line for new functions
(but not after if/while/for)

Also I did not think hard enough in the internal review, as this function
is not emitting to the sideband. that is solely done by the xwrite
call in recv_sideband. So maybe prepare_sideband would be a better
name?


> +        // NOSUBMIT - maybe use transport.color property?

Yes, that would be my suggestion (note that we do not use // comments)

> +        int want_color = want_color_stderr(GIT_COLOR_AUTO);
> +
> +        if (!want_color) {
> +                strbuf_add(dest, src, n);
> +                return;
> +        }
> +
> +        struct kwtable {
> +                const char* keyword;
> +                const char* color;
> +        } keywords[] = {
> +                {"hint", GIT_COLOR_YELLOW},
> +                {"warning", GIT_COLOR_BOLD_YELLOW},
> +                {"success", GIT_COLOR_BOLD_GREEN},
> +                {"error", GIT_COLOR_BOLD_RED},
> +                {},
> +        };
> +
> +        while (isspace(*src)) {
> +                strbuf_addch(dest, *src);
> +                src++;
> +                n--;
> +        }
> +
> +        for (struct kwtable* p = keywords; p->keyword; p++) {
> +                int len = strlen(p->keyword);
> +                if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {
> +                        strbuf_addstr(dest, p->color);
> +                        strbuf_add(dest, src, len);
> +                        strbuf_addstr(dest, GIT_COLOR_RESET);
> +                        n -= len;
> +                        src += len;
> +                        break;
> +                }
> +        }
> +
> +        strbuf_add(dest, src, n);
> +}
> +
>
>  /*
>   * Receive multiplexed output stream over git native protocol.
> @@ -48,8 +95,10 @@ int recv_sideband(const char *me, int in_stream, int out)
>                 len--;
>                 switch (band) {
>                 case 3:
> -                       strbuf_addf(&outbuf, "%s%s%s", outbuf.len ? "\n" : "",
> -                                   DISPLAY_PREFIX, buf + 1);
> +                       strbuf_addf(&outbuf, "%s%s", outbuf.len ? "\n" : "",
> +                                   DISPLAY_PREFIX);
> +                        emit_sideband(&outbuf, buf+1, len);
> +
>                         retval = SIDEBAND_REMOTE_ERROR;
>                         break;
>                 case 2:
> @@ -69,20 +118,22 @@ int recv_sideband(const char *me, int in_stream, int out)
>                                 if (!outbuf.len)
>                                         strbuf_addstr(&outbuf, DISPLAY_PREFIX);
>                                 if (linelen > 0) {
> -                                       strbuf_addf(&outbuf, "%.*s%s%c",
> -                                                   linelen, b, suffix, *brk);
> -                               } else {
> -                                       strbuf_addch(&outbuf, *brk);
> +                                        emit_sideband(&outbuf, b, linelen);
> +                                        strbuf_addstr(&outbuf, suffix);
>                                 }
> +
> +                                strbuf_addch(&outbuf, *brk);
>                                 xwrite(2, outbuf.buf, outbuf.len);
>                                 strbuf_reset(&outbuf);
>
>                                 b = brk + 1;
>                         }
>
> -                       if (*b)
> -                               strbuf_addf(&outbuf, "%s%s", outbuf.len ?
> -                                           "" : DISPLAY_PREFIX, b);
> +                       if (*b) {
> +                               strbuf_addstr(&outbuf, outbuf.len ?
> +                                           "" : DISPLAY_PREFIX);
> +                                emit_sideband(&outbuf, b, strlen(b));
> +                        }
>                         break;
>                 case 1:
>                         write_or_die(out, buf + 1, len);
> --
> 2.18.0.233.g985f88cf7e-goog
>
