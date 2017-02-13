Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 522831FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 21:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752919AbdBMVo2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 16:44:28 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36167 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbdBMVo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 16:44:27 -0500
Received: by mail-wm0-f54.google.com with SMTP id c85so2388555wmi.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 13:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7pQjUc9BFsWiiiKYYQ+esoVa/ZX6SWV/TS+gdEqHz2k=;
        b=nu3FrC4q5E1Tr+0J4mopCkNz5s6arwpvBHpt+w8Yu/PPG/7K+sn4k1Gxz7q+9Jr1S2
         z06P7ltj5aTyZd28Bx27lP99XfvW0xt8Q1GbFeoqTf1LTU71NWQKpE2DsgZa5KkhoJrF
         8ae6ckRuhqxQ07ilKwUcHE+wQEZmg2vY+sKD7Sz6dphLCfNRVUhXtKH1J+3d65eC3S5U
         oOqb8Yjx9WQp7jKVea2+n22YyphrZRQhc/4Mlr/JpzV+pqTgoY7QcNAfRdh0URJKtSva
         P0QLEQ9Ss6SwEpj7pSReE4UmtkZhiUaFVdFDQKQVwCjaqzVta2mg1DeV6IFFIiv/H4sO
         u7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7pQjUc9BFsWiiiKYYQ+esoVa/ZX6SWV/TS+gdEqHz2k=;
        b=YGNo2Kh++uoVQdcpzxnKTrEHDnZnGe3xVK2GBMkOXnDDVeBrWocE3S2gM/hQu+a2cK
         NSZa3C3K43gUpfwgReo4m3Z0U2A/TCKgcpY4FRWA+ErYsHthlEACfbLZwwbbjHQBweSX
         oW2euFWHc6EWbcaA58Kth7M95g15dBp1pqsPDMHBJARYWfDRhOgcjvWduB9wS+uGv+2S
         cnpVNtkqd9YkvR4U/agusZcU/rccx2AEXeXz81Z+MAx6gvQssynCa6qAcRTS9B80DjC9
         TAFTbaJTKlIlKGw57OcAVy4O3THm8rFgFY4HN7bJ3+jh937DTbFSAo3iJcfTqdftHPds
         myYQ==
X-Gm-Message-State: AMke39k6sWHzFz2MTuVqqPCuXy4tfCHkmuEd+F2OmiZ6kDXw32Uu213Fxud/mpc5yGPThsyuWzYaSmA+oPijtA==
X-Received: by 10.28.132.2 with SMTP id g2mr314752wmd.103.1487022265874; Mon,
 13 Feb 2017 13:44:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.62.208 with HTTP; Mon, 13 Feb 2017 13:43:45 -0800 (PST)
In-Reply-To: <20170213212734.howisucqqhusbglc@sigill.intra.peff.net>
References: <CAM_JFCwYAKCWrHqCtcwid27V1HvhuSmp4QpbNpgyMzrzWUNYog@mail.gmail.com>
 <xmqqa89pevw0.fsf@gitster.mtv.corp.google.com> <CAM_JFCwN+o54mJ1XJ3rSKnXgPx3wt_i=fd8ZSGpcL-fSegQ=Ow@mail.gmail.com>
 <20170213211653.x3huwmzprvmm3yxj@sigill.intra.peff.net> <xmqq37fhdc27.fsf@gitster.mtv.corp.google.com>
 <20170213212734.howisucqqhusbglc@sigill.intra.peff.net>
From:   hIpPy <hippy2981@gmail.com>
Date:   Mon, 13 Feb 2017 13:43:45 -0800
Message-ID: <CAM_JFCzniePuqJTFOy-odLfuKcBjssh0zk3PFBsVcm6Ww6iW5w@mail.gmail.com>
Subject: Re: Incorrect pipe for git log graph when using --name-status option
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 1:27 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 13, 2017 at 01:18:40PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > I think the problem is specifically related to the "terminator" versus
>> > "separator" semantics. Try:
>> >
>> >   git log --graph --name-status --pretty=format:%h
>> >
>> > versus:
>> >
>> >   git log --graph --name-status --pretty=tformat:%h
>> >
>> > The latter works fine. The problem seems to happen with all diff
>> > formats, so I think the issue is that git is not aggressive enough about
>> > inserting the newline at the right spot when using separator mode.
>>
>> I guess that is one of the reasons why we made --format=%h a synonym
>> to --pretty=tformat:%h and not --pretty=format:%h ;-)
>
> Yeah. I have never found "--pretty=format" to do what I want versus
> tformat. I wish we could just get rid of it, but I think it is likely to
> be used as a plumbing interface.
>
> So I think there probably _is_ a bug in it to be fixed, but my immediate
> response is "don't ever use --pretty=format:".
>
> -Peff

I have 1 issue with tformat in that I feel it reduces
readability a bit when using options. But I can use it if that
is recommended over the other.

Without --name-status: This is OK.

$ git log --graph --date=relative --decorate --abbrev-commit
--format='%h - %aD (%ar)%d%n     %s - %an' -2
* bf7ace7daf - Mon, 6 Feb 2017 13:09:32 -0800 (7 days ago) (HEAD ->
rm/option-for-name-status)
|      wip: --ns for --name-status - Rishikesh Mandvikar
*   592e5c5bce - Wed, 1 Feb 2017 16:35:30 +0100 (12 days ago)
(origin/master, origin/HEAD, master)
|\       Merge pull request #994 from
jeffhostetler/jeffhostetler/fscache_nfd - Johannes Schindelin


With --name-status: I'm sorry if I nitpick here but I think the
--name-status items should either be preceeded and followed by
blank line OR not (as in oneline) but not just preceded (example
below).

$ git log --graph --date=relative --decorate --abbrev-commit
--format='%h - %aD (%ar)%d%n     %s - %an' -2 --name-status
* bf7ace7daf - Mon, 6 Feb 2017 13:09:32 -0800 (7 days ago) (HEAD ->
rm/option-for-name-status)
|      wip: --ns for --name-status - Rishikesh Mandvikar
|
| M diff.c
*   592e5c5bce - Wed, 1 Feb 2017 16:35:30 +0100 (12 days ago)
(origin/master, origin/HEAD, master)
|\       Merge pull request #994 from
jeffhostetler/jeffhostetler/fscache_nfd - Johannes Schindelin


So either of below is better that above (I feel):

Blank lines before and after --name-status items:

$ git log --graph --date=relative --decorate --abbrev-commit
--format='%h - %aD (%ar)%d%n     %s - %an' -2 --name-status
* bf7ace7daf - Mon, 6 Feb 2017 13:09:32 -0800 (7 days ago) (HEAD ->
rm/option-for-name-status)
|      wip: --ns for --name-status - Rishikesh Mandvikar
|
| M diff.c
|
*   592e5c5bce - Wed, 1 Feb 2017 16:35:30 +0100 (12 days ago)
(origin/master, origin/HEAD, master)
|\       Merge pull request #994 from
jeffhostetler/jeffhostetler/fscache_nfd - Johannes Schindelin

No blank lines before and after --name-status items:

$ git log --graph --date=relative --decorate --abbrev-commit
--format='%h - %aD (%ar)%d%n     %s - %an' -2 --name-status
* bf7ace7daf - Mon, 6 Feb 2017 13:09:32 -0800 (7 days ago) (HEAD ->
rm/option-for-name-status)
|      wip: --ns for --name-status - Rishikesh Mandvikar
| M diff.c
*   592e5c5bce - Wed, 1 Feb 2017 16:35:30 +0100 (12 days ago)
(origin/master, origin/HEAD, master)
|\       Merge pull request #994 from
jeffhostetler/jeffhostetler/fscache_nfd - Johannes Schindelin

What do guys think?

If there is a way to get what I want using tformat?


Thanks,
RM
