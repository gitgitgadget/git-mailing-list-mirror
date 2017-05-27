Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CF901FD09
	for <e@80x24.org>; Sat, 27 May 2017 09:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754988AbdE0JAv (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 05:00:51 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:35630 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbdE0JAu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2017 05:00:50 -0400
Received: by mail-io0-f174.google.com with SMTP id f102so20885155ioi.2
        for <git@vger.kernel.org>; Sat, 27 May 2017 02:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Exp0BdCUtEpYVQXR4kAGDsIfd7IMglzg2i1VEsmt174=;
        b=XyMI6U3VVwZwXDDsI/NsB1yN1kLIxq9kjlWiLiPFgl1Ga5YHQuiEvVZbxfIR9jXgym
         gZOVsQd5nczuv9aBnF8yJHr6wU4LGA79PsehY5inp/gVsqLI6t2n4gDmQnmBzYoQ5dNz
         rkr+1saTSn+w7QCgs0oJd+KZgf7YF/mxl4TBpgd7GfLXFyyl3oq9jTUEHgfENB7dS5zu
         3oQW4D58/YcUG6nXiff+a9ZKRB/W77ckrFk90XP0K4p1CluH8Zu0nIWNrTCrO0dFO82h
         j8tibYSv9GEcpZISWutqsfxW9K6oNQR5YnikKT0sZiNXio9COsVyQUCk9MiBOupHYRIe
         g23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Exp0BdCUtEpYVQXR4kAGDsIfd7IMglzg2i1VEsmt174=;
        b=Z8MduGBQ+RV3WVpucF0litfruGVDHuKB7Spsv96erh8Bvg6rlsL4cKGOwMFt49lBVw
         eHiw1UYDC/XjESNjNeL1ZSqdz9ifSRhPXwVYRUFzlgPdgRJMTUurxIz6BjD/JpKWRUox
         gB18fYGMf55t6b8ov/Iu6qYnGf/xoQPqu9HUtMW5kPcTgTSJf5KWfN7MA8eufBwGQj5q
         RAQKWQGJpsi38lOlsYou3sLIUqeKlKESpgYwgZIGdADf80rBy97IWfnEgyngNsqTX1V8
         73UkoXCBWOtPTM4oEi6cXcCXfuhBXrzJKD32elSBtV/VfqBvqJDLCce494ZujL+MdvWg
         tBKQ==
X-Gm-Message-State: AODbwcDodMgSdcYKdQiw2sh+FBNuZP0lEO7BIrJWyh+HYTcgzUuF237s
        kpcaX84ke+/OSu/POvsTYWumD+Drhg==
X-Received: by 10.107.178.12 with SMTP id b12mr5187746iof.50.1495875649423;
 Sat, 27 May 2017 02:00:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 27 May 2017 02:00:28 -0700 (PDT)
In-Reply-To: <CA+9OxukkO8khvPtYdSMLL0pa5vmOCZaTJbx+CWYXze-TC2nrpQ@mail.gmail.com>
References: <CA+9OxukkO8khvPtYdSMLL0pa5vmOCZaTJbx+CWYXze-TC2nrpQ@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 27 May 2017 11:00:28 +0200
Message-ID: <CACBZZX7F6ght0+ncyLwNUKjiO+5ayyuff3CymL=fvj8uDnCCag@mail.gmail.com>
Subject: Re: Feature request: "git status" highlights files that are larger
 than 500kb.
To:     Zhomart Mukhamejanov <mzhomart@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2017 at 2:24 AM, Zhomart Mukhamejanov
<mzhomart@gmail.com> wrote:
> So it will be easy to track that we don't accidentally commit huge files.

Isn't doing this via a pre-commit or pre-receive hook both more
reliable & actually a 1=1 mapping to what you really care about?
