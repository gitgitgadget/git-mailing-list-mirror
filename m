Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37C2F207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 19:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755634AbdD1TLo (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 15:11:44 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:34416 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755444AbdD1TLm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 15:11:42 -0400
Received: by mail-io0-f178.google.com with SMTP id a103so72758754ioj.1
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 12:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uM7A9M9VKFdOvHUuUId1xIYl5ugJjP0QmTDO4hDo8Qc=;
        b=sIhk5cyk5/+Pgvg+vvgNfZzn3pwZh12qFxPxs/PvhFF91zVN3HqFrTtO3ncFxKMygU
         q1smYos0xdjxAByrQ1Yk8Yb0wUGTfihOwH2A2rf4hg9ZDSCXi2qjl6To2e3qHSeWdvgV
         mhvOL/CgbNmZrXUlr1vzUEc80Q4O2+5i2MDTqDAcDnjwxb+S66E+Jv3eBUtcg4d1EsFz
         aV0Fmhhm7htYBEOYoP7tNyJyFm8/cA1RXIGgOIc9ZT+VVDuQwAm5JCwz1rps0KA4VoPk
         qRY5mlenocmmbXmLx78mfrBMA0f7Hv9WBZKGx1g9ihlcO5v2Sn+k608CAR7rvg+RFRjC
         HFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uM7A9M9VKFdOvHUuUId1xIYl5ugJjP0QmTDO4hDo8Qc=;
        b=h0SVkjbZzYvN4YX/1qONkm2BgzUMpIBlH2g0KkcqxgWOIcSMMjHOyPlvO8ZHSJPcTE
         2r4ucTmZzmspuBLO5p2sHt8fCb2WyQXjPsCjWIBffc5yWRCA+cxK30Z1lj+UFAbKpGTr
         2HV1CSqHctba6XgNH3gV/wrwKYT6l7M8PEF0U/Ts1/tgknxveEDy8reIA2MrxKvE+4/h
         mobaQSYH++RvC8GE2IP4ZTPBpb/QF3Jm4kfq6zs3/wWRY1eS2QYLSCzw6KjBHJgunK0k
         sqpXJlKVgQ6g06iCqhT+bro0fgfcllk89M3pwF8osZWpOzUBNT8MkHcf1ovcHwW0iA75
         9q/A==
X-Gm-Message-State: AN3rC/60LoQo6pyfdd16F+Q2Kr/lCU3lRPWR8Akenn0QELCroD2Qkl4Z
        vgKZe977flvzzkTWqRLLNe8XV8N+CA==
X-Received: by 10.107.138.9 with SMTP id m9mr12194179iod.80.1493406701173;
 Fri, 28 Apr 2017 12:11:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Fri, 28 Apr 2017 12:11:20 -0700 (PDT)
In-Reply-To: <20170426231236.27219-1-avarab@gmail.com>
References: <20170426231236.27219-1-avarab@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 28 Apr 2017 21:11:20 +0200
Message-ID: <CACBZZX7bHai-CTiO1G1vOP41Uit3zeMAn64NKvA73aouoBWMng@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] clone: --no-tags option
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2017 at 1:12 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> This is an expansion of the previously solo 02/05 "clone: add a
> --no-tags option to clone without tags" patch (see
> <20170418191553.15464-1-avarab@gmail.com>).
>
> This addresses the comments by Junio & Jonathan Nieder on v2 (thanks a
> lot), and in addition implements a --no-tags-submodules option. That
> code was implemented by Brandon & sent to me privately after I'd
> failed to come up with it, but I added tests, a commit message & bash
> completion to it.
>
> The WIP 5/5 patch implements a submodule.NAME.tags config facility for
> the option, but is broken currently & floats along in this submission
> as an RFC patch. AFAICT it *should* work and it goes through all the
> motions the similar existing *.shallow config does, but for some
> reason the tags=3Dfalse option isn't picked up & propagated in a freshly
> cloned submodule.
>
> I'm probably missing something trivial, but I can't see what it is,
> I'm hoping thath either Stefan or Brandon will see what that is.

Junio, can you please just take patch 1-3 in this series, i.e.:

DROP:

> Brandon Williams (1):
>   clone: add a --no-tags-submodules to pass --no-tags to submodules
> [...]
>   WIP clone: add a --[no-]recommend-tags & submodule.NAME.tags config

KEEP:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
>   tests: change "cd ... && git fetch" to "cd &&\n\tgit fetch"
>   clone: add a --no-tags option to clone without tags
>   tests: rename a test having to do with shallow submodules

I think a fair summary of the discussion so far is that the submodule
interaction I copy/pasted from --shallow-submodules isn't how we want
to do things at all, I defer to Stefan & Brandon on that.

The only other objection to the patches marked as KEEP is from Stefan
saying it should be --tags on by default not --no-tags off by default.
As noted in <CACBZZX5dxaJDN18J5fAhjKcaP8cZSTtRw5-eScr2oq8OYyhKuQ@mail.gmail=
.com>
I don't disagree, but a lot of flags in git now use that pattern, and
this change is consistent with those. Makes sense to discuss changing
that as another series.
