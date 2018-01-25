Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25221F576
	for <e@80x24.org>; Thu, 25 Jan 2018 10:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeAYKJW (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 05:09:22 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:40402 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbeAYKJT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 05:09:19 -0500
Received: by mail-oi0-f49.google.com with SMTP id a184so4875595oif.7
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 02:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PggpYYTRuHN7Sv5oT0OpaWah5LnCzgfEcsQVvtawvYw=;
        b=EZWs5hEdr9V9zIULqLDupe6N1JpZjc1Vu63sTACwMpy+JJcKLC/BBVRAp81NaNdB5y
         tOnD7chEWVPByhMNfTQtnzK7E0hSYVGz/KHvvCLZGP0txgsjFV/x8KwE6ddWElD/kNO1
         StnuUo8fJexaJYZuWYvjHis15qwFbQub27uRZyqK2GpapBQVSBtHWYLgOq98XnPcVuOE
         lo7VRolWIjLo6PgNl8z+rszaAJ7iXBvvCOcS6KDPQnhLocEfIIsp6OkknxuXf95v9UGf
         DO8ZyyCcfQrwXQp8CIgqWAgVBw5Kvk4CXF498jLL+aBdaoHM/YMZebUbO3EGB1e8AAXs
         Lz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PggpYYTRuHN7Sv5oT0OpaWah5LnCzgfEcsQVvtawvYw=;
        b=tABsULDnWZoSO2LCQKOQESE6+aNx+c+bzTCLORZhIWfkTur5AeuzQOGC5sPTDWh3dq
         /wWl7xCFlEz3Ik5k5+YAqqg8svdOK+2V0en4z3sX/G1eRFnS6vCbgGo9oTMIgZfriRtF
         u1nC1fz7hTqi/aotEboo7ZYjYqCYmlht6ZjTvSW+JuSGA8s9O4YRc8nOVbnMlJQpAOHw
         RH5qbBayYUttUPOxZMW/kTNibIHcQxBXHjCvtewcyKSovNhY1ZGMepaU/LVFpa19YT3A
         cBJ1tk+fo9fP7VdGT7yb8n+H+26OSDSzQmpRjRl+wVWki/ZxLrMxBZ1hK2jJTGXVo2R+
         qSQQ==
X-Gm-Message-State: AKwxytd9JC3SARX006VzZzJ7nlzGnqPHlOupn1Ci84F0bOkUDPiSsoIw
        ctHHzvvDDF8c1jnv9hm5F7UAdO/mx+95j0KGvDk=
X-Google-Smtp-Source: AH8x225gN8BGT/bkkh9tXPPss7wa576RqtRDJCFpEkxGmsRWfWxf5Avm2wecaObxqi1J0DjL1A4N7sEpMaIykGds/EA=
X-Received: by 10.202.196.208 with SMTP id u199mr9810267oif.117.1516874958720;
 Thu, 25 Jan 2018 02:09:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.144.218 with HTTP; Thu, 25 Jan 2018 02:08:48 -0800 (PST)
In-Reply-To: <66fb698096ed14ee58b2611f41f2e3e5dfa49059.1516798941.git.patryk.obara@gmail.com>
References: <66fb698096ed14ee58b2611f41f2e3e5dfa49059.1516798941.git.patryk.obara@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 25 Jan 2018 17:08:48 +0700
Message-ID: <CACsJy8BFsXAMAGYjKp8EBrepqZwgKrAtqRKyiKLOydWbpzZWWA@mail.gmail.com>
Subject: Re: [PATCH] setup: recognise extensions.objectFormat
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 8:09 PM, Patryk Obara <patryk.obara@gmail.com> wrote:
> This extension selects which hashing algorithm from vtable should be
> used for reading and writing objects in the object store.  At the moment
> supports only single value (sha-1).
>
> In case value of objectFormat is an unknown hashing algorithm, Git
> command will fail with following message:
>
>   fatal: unknown repository extensions found:
>           objectformat = <value>
>
> To indicate, that this specific objectFormat value is not recognised.
>
> The objectFormat extension is not allowed in repository marked as
> version 0 to prevent any possibility of accidentally writing a NewHash
> object in the sha-1 object store. This extension behaviour is different
> than preciousObjects extension (which is allowed in repo version 0).

This config is so sensitive I wonder if we should forbid changing it
via git-config. You can't simply change this and expect anything to
work anyway.

"git init" can have an option to specify object format. "git clone"
naturally inherits the format from the remote repository. Maybe a
future command allows to convert hash algorithm on an existing repo
(*). But other than that nobody is allowed to change this.

(*) it's probably git-clone that does this job, cloning and converting
at the same time.

> +`objectFormat`
> +~~~~~~~~~~~~~~
> +
> +This extension instructs Git to use a specific algorithm for addressing
> +and interpreting objects in the object store. Currently, the only
> +supported object format is `sha-1`.  See `hash-function-transition.txt`
> +document for more detailed explanation.

Maybe the word "experimental" should be mentioned somewhere.

> +static int find_object_format(const char *value)
> +{
> +       int i;
> +       for (i = GIT_HASH_SHA1; i < GIT_HASH_NALGOS; ++i) {
> +               if (strcmp(value, hash_algos[i].name) == 0)
> +                       return i;
> +       }
> +       return GIT_HASH_UNKNOWN;
> +}
> +
> +static void detect_object_format(struct repository_format *data,
> +                                const char *value)
> +{
> +       if (data->version == 0)
> +               die("invalid repository format version");

die(_("invalid repository format version '%d'"), data->version);

> +
> +       data->hash_algo = find_object_format(value);
> +       if (data->hash_algo == GIT_HASH_UNKNOWN) {
> +               char object_format[25];
> +               xsnprintf(object_format, sizeof(object_format),
> +                         "objectformat = %s", value);

We have strbuf so that we don't have to deal with fixed size buffers like this.
-- 
Duy
