Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FC0F1F42D
	for <e@80x24.org>; Sat, 26 May 2018 12:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031672AbeEZMu0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 08:50:26 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37573 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031591AbeEZMuY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 08:50:24 -0400
Received: by mail-oi0-f68.google.com with SMTP id w123-v6so6838442oia.4
        for <git@vger.kernel.org>; Sat, 26 May 2018 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dgj0ON7MzmTjr6htbx11hnZPCGtcuYA09gQrklXBoBw=;
        b=epSWjb3ih+j8pv4y2N8YY0Z3VyRtJ4cQ3gKqTw0WEN/1Ei6fjSRbe0P6QdOcf8OTPF
         fWChQW948tuLLgZTLIobrWVoAH79rFA36sFdh2wDcFeNc2nn7KTtWMNZ8GyWV+wYx+sJ
         B8vbhrx56v93klK9TU/igSUfO2n8WIVEk0nrnqS57hCIXCSPjA7dSNSiNbFaxZ8M/OuL
         ErSTQ/5conQWg1ZeTVv2+8e3gElCS57zNNhfn1fzeP5EQfwfcjy/3bYR0rxJs6AvxaJB
         MNsMExnuTUoAad3iNjl64/87GpHU2ezjE1cKTwmrUm48gMX00qLfGKeZNy4LJke4UcvH
         86bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dgj0ON7MzmTjr6htbx11hnZPCGtcuYA09gQrklXBoBw=;
        b=LR9rvhN8qnfTGaq2DtxP8tv/hO4lWZsvhVOPD9l71eDGI4ECHepzzwVGO5ksX6huc3
         yd6qUKNWXEJ8G7mN49oKao4bE6h8haBFI82lg73Yf2kHgc3z04iYFn9ga/pRIrZfKXJs
         9EGC9IgSGqISzWFs0VRvbIqld8UjEPBiBFulvrtRiWIcaeNXmW7UfC9Z1EeGJHqnWLIs
         khonPRLJlNbU7EQnl0UTF5GRO1ky5RmIBpPGrptr7t/QdbcdtvzVllX4IjbZAjxGRTbp
         RG3s5ExMtkZ2GVnu+tinBi8a+eMW3l1uRW5uAKKnLc8Wd+e/wzSO3mBVRsruOuNe0m40
         e0Rg==
X-Gm-Message-State: ALKqPwf/8s5vtPK5Ew59zHDiZNY0iR7r7TmUDkg8Y6Ef+J0N8bB8SfYF
        ZE91hmGtjXkuiN6mjn9sGQJuWCPCVKoHt8SIJQU=
X-Google-Smtp-Source: ADUXVKLvY/d9iBY2DV0+25fg5w2rV+kXWuMBmZXOVl115GxZXUUy5nRtRL6TZX1zoCf3KkhTKgg2hHSilum5A9q9ULU=
X-Received: by 2002:aca:51ce:: with SMTP id f197-v6mr3619315oib.32.1527339024090;
 Sat, 26 May 2018 05:50:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Sat, 26 May 2018 05:49:53
 -0700 (PDT)
In-Reply-To: <87k1rr7f86.fsf@evledraar.gmail.com>
References: <CAPig+cR59-OEDL7GDNZF2v7a-NOrUH2zC9EwDvuog8QLRtvKTA@mail.gmail.com>
 <20180524194704.936-1-avarab@gmail.com> <xmqqpo1knog0.fsf@gitster-ct.c.googlers.com>
 <CACsJy8BjdiNF623vygUkp_1T82X5DwQiCQP9T55mATzFHuH1RQ@mail.gmail.com> <87k1rr7f86.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 26 May 2018 14:49:53 +0200
Message-ID: <CACsJy8A67bNEHqdi-dg5YCKseutiKhZGyBeBF_z3oY_EB6rQqQ@mail.gmail.com>
Subject: Re: [PATCH v3] checkout & worktree: introduce checkout.implicitRemote
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 8:38 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, May 25 2018, Duy Nguyen wrote:
>
>> On Fri, May 25, 2018 at 10:12 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>>>> +Currently this is used by linkgit:git-checkout[1] when 'git checkout
>>>> +<something>' will checkout the '<something>' branch on another remote=
,
>>>> +and by linkgit:git-worktree[1] when 'git worktree add' refers to a
>>>> +remote branch. This setting might be used for other checkout-like
>>>> +commands or functionality in the future.
>>>
>>> Hmph, that is an interesting direction.  You foresee that you'll
>>> have a single repository with multiple remotes to grab and share
>>> objects from different people working on the same project, and use
>>> multiple worktrees to work on different branches, yet you are happy
>>> to declare that each worktree is to work with one particular remote?
>>>
>>> We'd need a per-worktree config file to make it work, I guess, or
>>> a three-level checkout.$worktree_id.defaultRemote configuration
>>> variable, perhaps?
>>
>> I still plan to revisit per-worktree config support [1] at some point
>> and finish it off. Or is it decided that we don't need a generic
>> mechanism and will add a new level like this for each config var that
>> is per-worktree? If defaultRemote sets a precedence, then it'll be the
>> way to go from now on or we'll have another mess when some config does
>> "foo.$worktree.bar" while others use per-worktree config files.
>
> What do you think about including worktree in this at this time? I'm not
> very familiar with it and just included it because I worked my way
> backwards from the DWIM function, but I could exclude it if you think
> it's too much trouble, i.e. if you'd like to hold out for some facility
> like the per-worktree config Junio mentioned.

I think Junio was talking about the future. What is currently in the
patch, both code and document, is fine. But if you're going to
implement core.$worktree.defaultRemote at this time, maybe wait a bit.
I could try to resurrect the per-worktree config topic in a month or
so and if it does not work out, then everybody will add new config
vars if they want per-worktree support.
--=20
Duy
