Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50E9320D09
	for <e@80x24.org>; Tue,  6 Jun 2017 06:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbdFFGos (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 02:44:48 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36048 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbdFFGos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 02:44:48 -0400
Received: by mail-lf0-f54.google.com with SMTP id o83so33850404lff.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 23:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zXNgv7RtfTO/vH2BH5veLVWWRj36qKwkmcPLvye1tGo=;
        b=CVuxPqP9naaOSpD19BOOxFyYJ1NUD7BdLkhabuIMxUWIO/8Sy7BiFlBG3IF1o5koup
         QEuHyJUExmD3NSzcJoTsWPl5b32sBu0h2fdBdWjMl7+yzQm3dEChgrG5qngz44jl6av1
         zYCsfaduCdFjXDuW9q7A02hLDXv4g4Azpti4dMJ5vbVVATp8edVFHeXP2LRrLJaz9NWu
         5eA0Nrr9OrriuB7JgMp1JQe+40qmH8h/Izd1TqYrhuCdQvgDORBuivEisDaGaswcbYOm
         Y6Sq9A0VOtU8wB4cvQSpxg0z660GlSozuBhb6ZJOq5rCjc6bztI/Mh5FVghpqo0mqZ1C
         9tgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zXNgv7RtfTO/vH2BH5veLVWWRj36qKwkmcPLvye1tGo=;
        b=gSAb7BPAFYm77d73dNWaBxUQuBNwIQsC3mGFLp+3ztsDJWyakn5Od5gByxXbf9W7N+
         DB0ZTEE+2mkqJyzPX/+qeUScZYznhmspej3cT+0DRyKn0HiIGa2l2TNlY6426+psBm/7
         t3xgs0/lGo7OyujRhz1PzVHg6lOzYBoqu3BnnEuncOwCP2fszBeYyBcJcNwIltVfuR17
         gM++AgfHYDIsQNiaith/FWxS4eA5+5NIn6p5PYgQpBod+nV1gWCNbNaXgz0hIXjU/rDH
         DgQS1O/O2tu6cOdivo56b1MHaHbJDZHBZOfdQ1/RxRuXWp45teVX2i+LOcqkKyEJHQWW
         zcpg==
X-Gm-Message-State: AODbwcBg1mq7DwImjQ4C9LC6WVjoYJWAihRokdAOGRCYK3tVSlM2N9tc
        1vOnITJ9DJzpDl38vO8Va5BO0a4pcg==
X-Received: by 10.46.22.66 with SMTP id 2mr3453253ljw.35.1496731486065; Mon,
 05 Jun 2017 23:44:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.32.133 with HTTP; Mon, 5 Jun 2017 23:44:25 -0700 (PDT)
In-Reply-To: <CAGZ79kY2Z-fJYxczbzheu1hChLkKkdjEcDMwsP-hkN0TjUBotQ@mail.gmail.com>
References: <xmqq1sqzkrui.fsf@gitster.mtv.corp.google.com> <CAGZ79kY2Z-fJYxczbzheu1hChLkKkdjEcDMwsP-hkN0TjUBotQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 5 Jun 2017 23:44:25 -0700
Message-ID: <CA+P7+xpOuxviwmB0nv_HyzFUa9E7kQw_DKc20m1T9i_8Q514_w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2017, #03; Mon, 5)
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 11:23 AM, Stefan Beller <sbeller@google.com> wrote:
>> * sb/diff-color-move (2017-06-01) 17 commits
>>  - diff.c: color moved lines differently
>>  - diff: buffer all output if asked to
>>  - diff.c: emit_line includes whitespace highlighting
>>  - diff.c: convert diff_summary to use emit_line_*
>>  - diff.c: convert diff_flush to use emit_line_*
>>  - diff.c: convert word diffing to use emit_line_*
>>  - diff.c: convert show_stats to use emit_line_*
>>  - diff.c: convert emit_binary_diff_body to use emit_line_*
>>  - submodule.c: convert show_submodule_summary to use emit_line_fmt
>>  - diff.c: convert emit_rewrite_lines to use emit_line_*
>>  - diff.c: convert emit_rewrite_diff to use emit_line_*
>>  - diff.c: convert builtin_diff to use emit_line_*
>>  - diff.c: convert fn_out_consume to use emit_line
>>  - diff: introduce more flexible emit function
>>  - diff.c: factor out diff_flush_patch_all_file_pairs
>>  - diff: move line ending check into emit_hunk_header
>>  - diff: readability fix
>>
>>  "git diff" has been taught to optionally paint new lines that are
>>  the same as deleted lines elsewhere differently from genuinely new
>>  lines.
>>
>>  Are we happy with these changes?
>
> I advertised this series e.g. for reviewing Brandons
> repo object refactoring series and used it myself to inspect
> some patches there[1]. I am certainly happy (but biased) with
> what we have available there.
>
> Jacob intended to use this series
> for review as well, but has given no opinion yet.

I haven't had any problems thus far. Been using it for the past few
days at $DAYJOB.

Haven't said anything yet because I haven't really had anything to
add. I like it.

Thanks,
Jake

>
> You seemed to have used it for js/blame-lib?
>
> --
> Those patches had a wide reviewer audience cc'd,
> so I would think people are aware of this series.
>
> --
> Things to come, but not in this series as they are more advanced:
>
>     Discuss if a block/line needs a minimum requirement.
>
> When doing reviews with this series, a couple of lines such
> as "\t\t}" were marked as a moved, which is not wrong as they
> really occurred in the text with opposing sign.
> But it was annoying as it drew my attention to just closing
> braces, which IMO is not the point of code review.
>
> To solve this issue I had the idea of a "minimum requirement", e.g.
> * at least 3 consecutive lines or
> * at least one line with at least 3 non-ws characters or
> * compute the entropy of a given moved block and if it is too low, do
>   not mark it up.
>
> I am not sure if such a "minimum requirement" is the right approach
> at all. The nature of this discussion comes close to the diff heuristics
> at which Michael did present a wonderful solution, hence I had him cc'd
> on the series as he may have some good insights on how to improve
> the diffs. :)
>
> --
> In conclusion:
>
> We are happy to move to next as it seems technically sound.
>
> But we want more exposure on usage to point out UX bugs.
> (e.g. is the default mode for just giving --color-moved good for the
> majority of people/use cases? Are there subtle annoyances such
> as the closing braces?)
>
> So maybe merge to next with the strong option to evict it
> when finding more fundamentally wrong things?
>
> Thanks,
> Stefan
>
> [1]
> https://public-inbox.org/git/CAGZ79kZJF9iDsVgyi-hSKb6N8w0uhVCU4W-r89F0eRJPXe_4Og@mail.gmail.com/
