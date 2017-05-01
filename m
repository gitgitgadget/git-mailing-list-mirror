Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11351F790
	for <e@80x24.org>; Mon,  1 May 2017 09:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426713AbdEAJPo (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 05:15:44 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34413 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425972AbdEAJPm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 05:15:42 -0400
Received: by mail-io0-f194.google.com with SMTP id h41so20797549ioi.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 02:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GcSzd+88uhIoMV2EQ2fbhmb6e/zDVf0tMNdtBqTe5bY=;
        b=K7GUFIWtFZn6yivyVD0fOLlmoVfg5zFxD6sWzh5Xt+RHLgt5n3p7hxUywA3OmOjwUF
         tLLfwGWq9bhTq85TVRBCBOyeXtDQR3m1IokYW/R0eiKZjO54RKDMeew5tcjzhkLBCL5R
         aS17qvy9MQeD5sPQXaj60exi2avNrma1V2C1bEiyHGhbIhgItEBXMX46q7M/72rVGcXO
         LfsT+jORRq07+tAeNMWyIW9qfm7OaOhFnxEDel3jejzQPSSJb0sY3gBlAnns1IBIJ7VH
         s4Zj3x2xr3XxJCTDQEycRdV73+237hamzFqJkf7MyzAR0esZ7WeTG+ePs5bj4bw34Ib+
         33Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GcSzd+88uhIoMV2EQ2fbhmb6e/zDVf0tMNdtBqTe5bY=;
        b=aBnJO1/Bh38R9LU1OIK/4l7nXeTdITsxTjPOREPmKiUWoak/aA1BFJG9z9fTSCIBty
         2lTinzzzETU3552XdGs4MvfUVuj+GDDt2V7yvIGRbT+vpA2Yc/8mJW5nVeJHYdUpcHde
         5YONL5DrlLH1LrzxpoPmy6VpR/LhrkbNuuAyrQJeghFdr5qcH+43cfgUogMmT9wVx+Jn
         CmAxWig9SMCiGWT3/37WvIs9p4iEdcfP0txwugWqR3qztjmIQrbAuThhapx27sl1GcaK
         XJN09IxJ6SY4NYsECMabh2SBN3jrtI5dBCA9knE0U4nP+yxTwC5TMrgmKp5/kC6eJ5L6
         4AXQ==
X-Gm-Message-State: AN3rC/5e3QSl1NhAsHWohnkXSp8+rDdz1eHIP4EUQg1uL/FU+RgEdyn/
        eDuM4eU/dR2HXeV1cwZALouF/MDrsg==
X-Received: by 10.107.146.139 with SMTP id u133mr20209888iod.160.1493630141729;
 Mon, 01 May 2017 02:15:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Mon, 1 May 2017 02:15:20 -0700 (PDT)
In-Reply-To: <20170429100253.4710-1-jn.avila@free.fr>
References: <20170429100253.4710-1-jn.avila@free.fr>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 1 May 2017 11:15:20 +0200
Message-ID: <CACBZZX6kVihx43o7AKkb+DZtPUoHOw027VpLcMD-09fN=XnxbA@mail.gmail.com>
Subject: Re: [PATCH] i18n: remove i18n from tag reflog message
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Cornelius Weig <cornelius.weig@tngtech.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 29, 2017 at 12:02 PM, Jean-Noel Avila <jn.avila@free.fr> wrote:
> The building of the reflog message is using strbuf, which is not
> friendly with internationalization frameworks. No other reflog
> messages are translated right now and switching all the messages to
> i18n would require a major rework of the way the messages are built.

[CC'd Cornelius Weig who added the code you're modifying]

If I'm reading this correctly this is a good patch but quite a bad
explanation of what we're changing.

The problem here is not that it's cumbersome to translate this using
strbuf, but that we're injecting i18n'd messages into the reflog, so
e.g. someone with a Chinese locale creating a tag in a shared repo
will cause the Chinese i18n message to be inserted into the reflog,
and then someone with e.g. a German or English locale will see the
Chinese messages when they run "git reflog".

That's a very bad thing, and in some ways worse than translating
plumbing messages, because here we're injecting i18n'd messages into
the on-disk format.

Luckily this hasn't made it into 2.13 yet. Junio, if the above
description is accurate then this is something we definitely want in
the final 2.13.


> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> ---
>  builtin/tag.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 222404522..bdf1e88e9 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -309,7 +309,7 @@ static void create_reflog_msg(const unsigned char *sha1, struct strbuf *sb)
>         if (rla) {
>                 strbuf_addstr(sb, rla);
>         } else {
> -               strbuf_addstr(sb, _("tag: tagging "));
> +               strbuf_addstr(sb, "tag: tagging ");
>                 strbuf_add_unique_abbrev(sb, sha1, DEFAULT_ABBREV);
>         }
>
> @@ -317,14 +317,14 @@ static void create_reflog_msg(const unsigned char *sha1, struct strbuf *sb)
>         type = sha1_object_info(sha1, NULL);
>         switch (type) {
>         default:
> -               strbuf_addstr(sb, _("object of unknown type"));
> +               strbuf_addstr(sb, "object of unknown type");
>                 break;
>         case OBJ_COMMIT:
>                 if ((buf = read_sha1_file(sha1, &type, &size)) != NULL) {
>                         subject_len = find_commit_subject(buf, &subject_start);
>                         strbuf_insert(sb, sb->len, subject_start, subject_len);
>                 } else {
> -                       strbuf_addstr(sb, _("commit object"));
> +                       strbuf_addstr(sb, "commit object");
>                 }
>                 free(buf);
>
> @@ -332,13 +332,13 @@ static void create_reflog_msg(const unsigned char *sha1, struct strbuf *sb)
>                         strbuf_addf(sb, ", %s", show_date(c->date, 0, DATE_MODE(SHORT)));
>                 break;
>         case OBJ_TREE:
> -               strbuf_addstr(sb, _("tree object"));
> +               strbuf_addstr(sb, "tree object");
>                 break;
>         case OBJ_BLOB:
> -               strbuf_addstr(sb, _("blob object"));
> +               strbuf_addstr(sb, "blob object");
>                 break;
>         case OBJ_TAG:
> -               strbuf_addstr(sb, _("other tag object"));
> +               strbuf_addstr(sb, "other tag object");
>                 break;
>         }
>         strbuf_addch(sb, ')');
> --
> 2.12.0
>
