Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C0BF20248
	for <e@80x24.org>; Thu, 11 Apr 2019 15:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDKPGU (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 11:06:20 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:36281 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKPGT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 11:06:19 -0400
Received: by mail-ed1-f46.google.com with SMTP id u57so4884863edm.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 08:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Wm2Q/t9QL6FGsg63YD1Bk3oT66p5HQxm5J9JLQcOd4=;
        b=a6RWPaHt+NvPDDRvZHmgeXbbWqG7KpHGGIIG7S9p3kPXPrgOTv9rT1jryjJ7dHBMil
         g/Qx0BaRi6WN+DGqHkw8sovfcAeOo204Yx82qVnwzKKwa5pJm3wZTzP1K8HgekcIUreo
         kfwdHZuozh6mufGIF2UlWoRNJMiunkD6vbC3VXBvOwlrK8y70D6wBXPfJGP7/sEfYRCw
         bOL8J2u0L/XsgWGVKTnJSelpCRtePUJnaCSKvqy0FXigAGfqj1gTCa35duJEcGRFqR4t
         KbaFusLOm02a9/e58FqCSxEOAMUp+MgsvNziYWRluDdhkDTFMdrxf3A95QSwTfzwG/pL
         UMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Wm2Q/t9QL6FGsg63YD1Bk3oT66p5HQxm5J9JLQcOd4=;
        b=YnaDMufjuXMBovkbCQeQxDAmpi/jC3C0rF5sxp7JB0q+J5jgIAHWQ8B4JYOKNKfEdG
         dnM5CPeZU0ADusEZXBmASrTE7YA8aIBVqnCwBikrTJY12thU/bIbDukxJ/UFHvCJlwrw
         ooH+Qk3J9J2dYBCesTMeEIJ23WmE5Mvla0bGtHt9tO07B2LgktUxtCyhVRNNVWaM3MWi
         1zNgtzQs6vHFOkjkSUfitD82WGiQhsSf97bc5hwJeagWU+Rt7oHkBEwyN4qPXN5usLBG
         hu+X+/wy5j0LWZZDZMgqIFabHEkndpcqx+qBZwYAmVhTK48e36v5qEB8wa2lrJsCrrIo
         Yhgg==
X-Gm-Message-State: APjAAAUplg/jKOJ01A5hcBMLEDeS1y0aAhiA8r1fNbPLYs9xYYlkmI0m
        FHbcb+soSXDQ/XAJP7LOkk5vsLBvTCdUCIo96QTmMXDp
X-Google-Smtp-Source: APXvYqxCimU0JuHwVmGCKk5k4gp4E61s5CWnVzuBvks1oLy8v3/3jPQYZkQ6W0YvLcU8bmNgMon0LQaX+ll2Oi8TETQ=
X-Received: by 2002:a17:906:8604:: with SMTP id o4mr25471897ejx.178.1554995177944;
 Thu, 11 Apr 2019 08:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 11 Apr 2019 17:06:06 +0200
Message-ID: <CAP8UFD2KsjPo7G0BtzXfA3gyoUyR7y_WsNLm3mn39O8h4n+Kfw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2019, #02; Wed, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 9, 2019 at 8:08 PM Junio C Hamano <gitster@pobox.com> wrote:

> * cc/replace-graft-peel-tags (2019-04-01) 4 commits
>  - replace: fix --graft when passing a tag first
>  - replace: fix --graft when passing a tag as parent
>  - t6050: redirect expected error output to a file
>  - t6050: use test_line_count instead of wc -l
>
>  When given a tag that points at a commit-ish, "git replace --graft"
>  failed to peel the tag before writing a replace ref, which did not
>  make sense because the old graft mechanism the feature wants to
>  mimick only allowed to replace one commit object with another.
>  This has been fixed.
>
>  The title of the top two commits are fairly useless and does not
>  say how the issue was fixed, but the fix is to peel the given tag
>  ourselves down to the underlying commit object.

I can send a new version where the top two commits have the following titles:

  - replace: peel tag when passing a tag first to --graft
  - replace: peel tag when passing a tag as parent to --graft

I am also ok with you changing the titles, as you prefer.

Thanks!
