Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 964FF2013E
	for <e@80x24.org>; Sun,  5 Mar 2017 16:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbdCEQEs (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 11:04:48 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:38647 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752290AbdCEQEr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2017 11:04:47 -0500
Received: by mail-it0-f52.google.com with SMTP id m27so37554035iti.1
        for <git@vger.kernel.org>; Sun, 05 Mar 2017 08:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Oa2926HIgj0666IF8fBHMh7lHBZUXCpJwGbWHVGQw8w=;
        b=kth4ozG8RwJm26O+m4wkosAFeVEVfk/OIF4Z5UumTNwNnIyZbDOApelymL0UJwjK9R
         G8hJh/wM9CdHfdYsVMi1RIG5fDra6Nx59Ew3aqfWRjHakPoB66T/PXNoASYN1poIEGkW
         bDw578nWGGvilGQu9UyK9YIyK2kDCUWx1Ya95SieEvZXWhaES/Odagzyy9YVlANHIfJS
         IuFee69Ys5OKnAdEhvbCfPCNqk1k/vWey0UxBjqLygc27ujVlfqQN1DUmDTurm8jpKQz
         O5wZjHwcRyeiFVjEvg033erG8TvKNXUnTQDGsQ4zVw1t3sMGy5nCbi+jV/ZJAAVt8xdm
         ki0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Oa2926HIgj0666IF8fBHMh7lHBZUXCpJwGbWHVGQw8w=;
        b=ABPiw5W8hD5q69CsaxImgPEXZ46r3mldqBX9GMqfBpnQ+5M3f3D0mCTbGgBTsNcHeS
         WutBoe/jbKuf8/p8A7BvKbX+FJfPeZH+9TppjsQtwXlTltEqkIR5ToG/2eEjgEEu68Iq
         /9jF7G66BQar+Csa5xcLvqKmYf5m5nHOIK/eEPDXvcKp6g6/Nxhc3EPVGYejYFXY5uML
         XdjcM22TUayTWeHkBBPGSsanxL2Qh9DRGeeCb2I+Xq/82te+g+fTI4P/UaFGPw4yvXRW
         PiPJrdZqqem0IBaxyMeq7OIKxaRqBpkHvQoAf56EQKGyyWeJ6ixohUTxWxFEGe8UzJjv
         8shQ==
X-Gm-Message-State: AMke39kJXcxhyucokelwxqgp7szbwX2KbjIwvUXtGONZSJDwxfCW9eNn3U3ses6mbCAZYVnbF2rPs/i1RHl18w==
X-Received: by 10.36.93.213 with SMTP id w204mr12812940ita.60.1488729885935;
 Sun, 05 Mar 2017 08:04:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.13.214 with HTTP; Sun, 5 Mar 2017 08:04:45 -0800 (PST)
In-Reply-To: <d1c90081-5ce1-c17a-120c-3cf80e276467@gmx.net>
References: <xmqqh93a6iy6.fsf@gitster.mtv.corp.google.com> <d1c90081-5ce1-c17a-120c-3cf80e276467@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sun, 5 Mar 2017 21:34:45 +0530
Message-ID: <CAFZEwPNJg4inOws3TTtFujTcMkBBz+2P-cNktyoDXCAJUa+nZA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2017, #02; Fri, 3)
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan

On Sat, Mar 4, 2017 at 8:05 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi Pranit,
>
> On 03/04/2017 12:26 AM, Junio C Hamano wrote:
>> --------------------------------------------------
>> [Stalled]
> [...]
>>
>> * pb/bisect (2017-02-18) 28 commits
>>  - fixup! bisect--helper: `bisect_next_check` & bisect_voc shell function in C
>>  - bisect--helper: remove the dequote in bisect_start()
>>  - bisect--helper: retire `--bisect-auto-next` subcommand
>>  - bisect--helper: retire `--bisect-autostart` subcommand
>>  - bisect--helper: retire `--bisect-write` subcommand
>>  - bisect--helper: `bisect_replay` shell function in C
>>  - bisect--helper: `bisect_log` shell function in C
>>  - bisect--helper: retire `--write-terms` subcommand
>>  - bisect--helper: retire `--check-expected-revs` subcommand
>>  - bisect--helper: `bisect_state` & `bisect_head` shell function in C
>>  - bisect--helper: `bisect_autostart` shell function in C
>>  - bisect--helper: retire `--next-all` subcommand
>>  - bisect--helper: retire `--bisect-clean-state` subcommand
>>  - bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
>>  - t6030: no cleanup with bad merge base
>>  - bisect--helper: `bisect_start` shell function partially in C
>>  - bisect--helper: `get_terms` & `bisect_terms` shell function in C
>>  - bisect--helper: `bisect_next_check` & bisect_voc shell function in C
>>  - bisect--helper: `check_and_set_terms` shell function in C
>>  - bisect--helper: `bisect_write` shell function in C
>>  - bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
>>  - bisect--helper: `bisect_reset` shell function in C
>>  - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
>>  - t6030: explicitly test for bisection cleanup
>>  - bisect--helper: `bisect_clean_state` shell function in C
>>  - bisect--helper: `write_terms` shell function in C
>>  - bisect: rewrite `check_term_format` shell function in C
>>  - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
>>
>>  Move more parts of "git bisect" to C.
>>
>>  Expecting a reroll.
>
> I guess you are short on time but I am hoping that you are still going
> to send a reroll to the list (probably on top of [1]?). This is because
> I would like to start to work on rerolling my bisect patches from last
> year [2] ... but to avoid a mess of merge conflicts, I am waiting until
> pb/bisect found its way into "next". (There were also recent discussions
> on other bisect strategies [3] and it's probably only a matter of time
> until a new big patchset on bisect--helper comes up...)

I am sorry I haven't found much time on it. I actually came across a
bug and haven't been able to fix that so I had just not worked on it
then. I almost forgot that you too had a patch series and this series
is important for you. I will start working on this and send a re-roll
soon.

Regards,
Pranit Bauva
