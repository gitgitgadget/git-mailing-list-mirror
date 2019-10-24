Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270861F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 21:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfJXVdg (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 17:33:36 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42939 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfJXVdf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 17:33:35 -0400
Received: by mail-ot1-f42.google.com with SMTP id b16so302330otk.9
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 14:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qq43u+/kvY9lDvLd/KuBon2nFKWVQMn922j1AxDHCtA=;
        b=HHT5d1KkOk9o0cFFV0qhlWSIVagPRv4rQcxiREKbWkjjaOOUt0CG3+o0B+6jPjOIw9
         xwMgn4DD2HN8Uj2ychajlTHCbS0EDZxd2k5ZreZMuIjQWF/5QJlmK8eNyh9AaRb44D/v
         hzpPO4MfXg75xr9/4jyxgRGkK8Bri4HHSQacahjaJUo+wUAHqedt1uO1mGqaeRj+Yl4v
         WwqU3f4EZcj71DZ0BlUP4QmpkukHCWdMxySa1Xu5mCBrcLvEXEQj0S5Qo3vBZjx1oyvv
         U8W9hxRIrKvOnpa5HrlHqbwyP8cOCYk7z4b8dqapcUl31uXn35mEaK3ZFT4JsOBLMBrY
         DgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qq43u+/kvY9lDvLd/KuBon2nFKWVQMn922j1AxDHCtA=;
        b=OkRtr9VmdNK+GtTHrHxjlO+EtrPpzpk4CkahzzpxJFj+Jb6LGEZzS9iZZbnypB5r9a
         FTKNCnvpNeLSDw280PrQjcrODnGPbl+qjF+Umeyseq5rL/yXXrl5Ktgdg2bBr6lH0Qxz
         f1po+rooVXGY2x2/wzG5iD9HiQ6mJ4H32+B84cMLaG4GbhPn8TunvMq0292IExIJH1Dw
         ACSNxenup0BS8nmB9uYtC2yx7E1zjHsdNeDCkOimemEX5VAvW/Q7cGE90rqBgytoovr+
         NqK2lGjiXl55g14tUu42qGTcjFUAeWT30XtUh5S1x4vW0HqGhdlsd5CdggcApp4o0cfS
         /JQA==
X-Gm-Message-State: APjAAAXG2JWTPGC7GysY1rvLuUEs7RhhhTLxLsw/h/gjhzpKGJdUYdKX
        ljympXNSlyaqgC7rF49SK6ji90lECMkq+Pd723qeOSs7
X-Google-Smtp-Source: APXvYqxNNUqBL0futBpwS/P6qzmw1aEZWKn4YGi0s4Judb/H2Hfcl/hT/yvlPP9tWveGhawZCNbigu9l1EOiUlXimO4=
X-Received: by 2002:a05:6830:13c7:: with SMTP id e7mr38073otq.162.1571952814096;
 Thu, 24 Oct 2019 14:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd0emfzrv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0emfzrv.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 24 Oct 2019 14:33:22 -0700
Message-ID: <CABPp-BHedMizrWT9gDEt20HH5Wn70yARj0Hm74vStKhXToynQA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2019, #06; Thu, 24)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Oct 24, 2019 at 1:35 PM Junio C Hamano <gitster@pobox.com> wrote:
> --------------------------------------------------
> [New Topics]
>
[...]

It appears that the spelling/typo fixes of various Documentation/*.txt
files at https://public-inbox.org/git/086a6bb7be8c06c64f1175c4de66a1437ffb3c48.1571790575.git.gitgitgadget@gmail.com/
may have slipped through the cracks.  Could you take a look?

Thanks,
Elijah
