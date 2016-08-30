Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AA5E1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 18:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758794AbcH3SKU (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 14:10:20 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33095 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758791AbcH3SKT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 14:10:19 -0400
Received: by mail-oi0-f50.google.com with SMTP id c15so37544076oig.0
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 11:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C7R71hWWxHQYETWx4uWhjl8t1OTfDSy7eRlSoVulB98=;
        b=vI5T+MJtHiBDKrvtWCcedksUBXOjnRxFpFT5HRLBRvxtDBEu0eaAXF9525dxYH414L
         8FjrpS7+8bDIxF6/ejHYMvlh7r3xT7wJ15CfmVzRsyKZrlcvw+qAQHIRrfwFL/pmgaYK
         iYfopi635HbPSt7tpRTuULTkw8hGGW4i3ewwOgWB5Rs1G6ukswZu8dAaMzZLlvW3ukKD
         ETu+xYO2bpDl0+umU0lNPW+Q1wgwZ0ZceLy9gCkQCufSXEQ0MUbTiO2RbDS5fAEtg/uJ
         l2t1wgPw/wxWs8nfAicBgUMT/a0fzmMDr8fwIlixY8rraXoj1SX/1GC13ZbEP2PlrloB
         SeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C7R71hWWxHQYETWx4uWhjl8t1OTfDSy7eRlSoVulB98=;
        b=RY0rLYYfBehtscbc240h2Uy51KJG2+1gJJpqfiGfyumtumDo3XWAZrCGkQK3QhjhAz
         PM0SAM3N3l17rTBoL+gAHL6jNdIoC1JtMhua37LD30fFaUvxjZhxjZSUDm9WytpsB9bU
         dB5aLXEj3ASYMFofJ3r6wokguz8SY+s5GMIO++YN7HELdn7FPSKq5L7U2ltOqcD9zxEG
         F9GerD9UvMvMEzkU91rXEGw9aDaZOjYa+QKtw3vwSig8ZdEbl9URwvGPQJDfnhYq2pXi
         DS451kLPOQD1ME3R4HLfoyZcrQbLaYQw1ascbhk/nPz27mpwffJT64QBiyLsqBNFXyky
         AcyA==
X-Gm-Message-State: AE9vXwNb/ngzKotuLfrtr+WkuhMmMoHi0uaURwmvCH1L410YX8RFijOY10CKSYsdHwvUtbsGnUvmMa3bP8e7xw==
X-Received: by 10.157.19.111 with SMTP id q44mr5616805otq.139.1472580618991;
 Tue, 30 Aug 2016 11:10:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.245.203 with HTTP; Tue, 30 Aug 2016 11:09:58 -0700 (PDT)
In-Reply-To: <xmqqy43f9wzh.fsf@gitster.mtv.corp.google.com>
References: <CAKkAvazQxhtQauSb3MTVhzoK=xWbjMzQLBPQZUpp1n7VMUMJbQ@mail.gmail.com>
 <20160828105159.GA5477@ikke.info> <4114ccbc-6b23-b7fe-ce4a-fcd0c9e4038a@gmail.com>
 <CA+P7+xrGh687cYHJmYyXiWfjg_8i2-31FZOvk4bEMsO1FU22WA@mail.gmail.com> <xmqqy43f9wzh.fsf@gitster.mtv.corp.google.com>
From:   ryenus <ryenus@gmail.com>
Date:   Wed, 31 Aug 2016 02:09:58 +0800
Message-ID: <CAKkAvaxyEMjASzfGTqt73AtW7ag-YfqN1yVLEhFreiU-UVdnkA@mail.gmail.com>
Subject: Re: Notation for current branch?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Kevin Daudt <me@ikke.info>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30 August 2016 at 03:49, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>>> What's wrong with simply using 'HEAD' for scripting?
>>
>> When you want to display the current branch to the user, e.g. when
>> scripting a shell prompt or similar use
>
> Wait.  Even if a hypothetical version of Git understood @@ as "the
> current branch", how would you use that notation, instead of HEAD,
> to decide what to "display the current branch to the user"?
>
> You obviously will not be doing
>
>         echo @@
>
> You would be doing something around "git symbolic-ref" at the very
> least, and wouldn't you be feeding HEAD to that symbolic-ref anyway
> while doing so?
>

For now the best use case I can think of is with git-reflog, e.g.,
the meaning of `git reflog HEAD` and `git reflog feature-branch`
are quite different, even if I'm currently on the feature-branch,
especially when I want to track the rebase histories (if any).

If there's a notation for the current branch then I don't have to
find the name of the current branch, then copy/paste it.
However, in this case, maybe git-reflog can have a `-b` option to
show the reflog of the current branch (if on any)?

- ryenus
