Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8980420C31
	for <e@80x24.org>; Fri,  8 Dec 2017 15:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbdLHPgR (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 10:36:17 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:39340 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753786AbdLHPgO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 10:36:14 -0500
Received: by mail-it0-f54.google.com with SMTP id 68so5514749ite.4
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 07:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PpOLDbtk5XyDYFn4zhqzbiaeyK5xbdqeN+WGpIx0ois=;
        b=NSgBAZhGNuobyP6zT+DxNSmkSko/NpUDVyh6CZvZNor1BtfJZioGaLW2/XPE583hTF
         702lbAg6v+am2SDL3JBIJOn12a7E0WXp5PXOF/8kMyyBEVRIP04LLj2OVPOCD3EKXgYp
         7PKM53gOoobsbjHRTZZ5Z8IcIdL91l40kn0MYEbgKA7ez69Dcck0wd0XfnrXZViC8nze
         EatjqqOXwlgQ+q8rEQOnTRrHi35Gvj6jKAsbaCRFDkBtxeTrVB5j/YXg7fDzPULII3at
         X1ZQTOkC1mnlqRj7OawuOjSNfBLK2kwnlgh9P3Q2Zdlrxq8Abo+RcTXX5HRtjZRV7Euh
         kAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PpOLDbtk5XyDYFn4zhqzbiaeyK5xbdqeN+WGpIx0ois=;
        b=idTNOnBuuXlK2TQKooPLDhHc/4q84THdio3M0UAjIkE3YfGTUTQBljTHVMx9aqhMUO
         tThJOqCA6pDiXZkUqVe0WoOoosevvbQc1aqhGXBd6ZGEtPcwYPEwB7QLTwOcpuvdkxtF
         /aqhwtmaOgWPdRinsWpYOuJJawp25uPUodTYO/oqZOGDV6o7wLhat4lKw3cpePOXXViy
         KSAMrTE8b3+vRmDU/u7Jhbh8cV4E0TXKXtmvNbVjSxvAhz+/9vR2ExyuWqQqDJVq0UmY
         55crbJulUeHChdVnT6ot14RfSCI7B0Vzikx30/treDezdDjC8Szo1X5tJJGXFMKbycqu
         RwcQ==
X-Gm-Message-State: AKGB3mKv/UVvlqElZ6VMbSnkMJGhVku/R9R3Skwx3Mkd/ZQgGnJgy3+Z
        C9UhZ4WPeFumR75aG9fgfx2mIKJwAPiyAzv99rA=
X-Google-Smtp-Source: AGs4zMbD7J0+dvoo/3/1xBYJjGgAVfG9It0U1hkLaBLH/55F30uUul0hPtxqmZeTWGpEMTXUlvU8JpSX3hbb/mfPxX8=
X-Received: by 10.107.81.2 with SMTP id f2mr14240095iob.282.1512747374063;
 Fri, 08 Dec 2017 07:36:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Fri, 8 Dec 2017 07:36:13 -0800 (PST)
In-Reply-To: <xmqqfu8me7ot.fsf@gitster.mtv.corp.google.com>
References: <xmqqfu8me7ot.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 8 Dec 2017 16:36:13 +0100
Message-ID: <CAP8UFD1zDcwfMBWy5F0KAru9wWS8k6qmKtCRLTZBsN-jLXeysw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2017, #02; Thu, 7)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 7, 2017 at 7:04 PM, Junio C Hamano <gitster@pobox.com> wrote:


> * cc/skip-to-optional-val (2017-12-07) 7 commits
>  - t4045: test 'diff --relative' for real
>  - t4045: reindent to make helpers readable
>  - diff: use skip-to-optional-val in parsing --relative
>  - diff: use skip_to_optional_val_default()
>  - diff: use skip_to_optional_val()
>  - index-pack: use skip_to_optional_val()
>  - git-compat-util: introduce skip_to_optional_val()
>
>  Introduce a helper to simplify code to parse a common pattern that
>  expects either "--key" or "--key=<something>".
>
>  Even though I queued fixes for "diff --relative" on top, it may
>  still want a final reroll to make it harder to misuse by allowing
>  NULL at the valp part of the argument.

Yeah, I already implemented that and it will be in the next v3 version.

> Also s/_val/_arg/.

I am not sure that is a good idea, because it could suggest that the
functions are designed to parse only command option arguments, while
they can be used to parse any "key=val" string where "key" is also
allowed.

>  cf. <xmqqh8t6o9me.fsf@gitster.mtv.corp.google.com>
>  cf. <xmqqd13uo9d1.fsf@gitster.mtv.corp.google.com>

It doesn't look like s/_val/_arg/ was discussed in the above messages.
