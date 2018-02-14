Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 094D21F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162671AbeBNTHF (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:07:05 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:41908 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162470AbeBNTHF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:07:05 -0500
Received: by mail-vk0-f53.google.com with SMTP id g186so13519778vkd.8
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JHHnEHy5lre/omBWo94qoJN5mJo1RLjZDAKllqlc83M=;
        b=RjxpnJFwCnYGTSAXs6863EsWAYGyU5BCn77nTBHWZmZw57i2p8h05nKaRKeF8/tCoS
         /G7qPKkHMYmP9IRVov9+t8Yk+hTyFzIVR1awuqwWNPMrfZKZWUeqXQBiBR+65kqvzUY2
         LoHdNNXLpWD7y7CfFgcPaw6aeVDsr1ssbOoAnIWVymVTPlqnxrxGGb5g24Eah4pTohxL
         q2v5r4ZKlteIcqQQ1Xkg2FcEnPzQQaow3AK3u9LnhilD3XHXgGvirda9M01Bpwx8qNcU
         voewQbqbRAhgVGp0wzn4oz4RP4oau/47oW1+vH57kEOdXR6IQDGJWCHD3pQcmX3q+Bx5
         HEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JHHnEHy5lre/omBWo94qoJN5mJo1RLjZDAKllqlc83M=;
        b=tTnsjBej9xzWucILX0amgtrFUxQbgPSeOcaMpUXsHY1dIiJQaFSbon/ogrA42UL1Bl
         fink2DVRMNEZG51dY/evDCHvmhA/r2Hs1HRoXGZyCj37OcictzBlBSdJ+ESOVLhDdISA
         so4h1RdqCK0r05P+dGQwXc1Kl0ycqQith1hWb8QZ6dxcJN4IC7Ciryc1/UVxT2W4Z1Jm
         EQtxqj/WdG03X4+XO78aymkvYMJu2AtgFKbBAcwpY3sCK8ePZTEUuqhI4TH/rxpp9diz
         QWLeTtHMkQ4+go4eLsdOFvvIUs9cS2xMwhUXJRyBIsVpeyh10lpcfIJzHN5QlT/52inq
         UrXQ==
X-Gm-Message-State: APf1xPBwzuvtZQLi29yMRAERoPjP7Taqsk9YhWBiDmUsEaGEj3CjoQwz
        twjsgOMIggAvckiA9nf33k9iXVnoMpvUUr/kZT0ALQ==
X-Google-Smtp-Source: AH8x226Vsgkc/dAAnhnM53NXktLIo4KP58n+GywzhYb04PMY1/TXRogAX9nmyAQVyg/mybkEJKY8s2psctFsQy62vhk=
X-Received: by 10.31.217.193 with SMTP id q184mr251076vkg.75.1518635224227;
 Wed, 14 Feb 2018 11:07:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.33 with HTTP; Wed, 14 Feb 2018 11:07:03 -0800 (PST)
In-Reply-To: <xmqq8tbwpcdv.fsf@gitster-ct.c.googlers.com>
References: <xmqq8tbwpcdv.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Feb 2018 11:07:03 -0800
Message-ID: <CABPp-BEdAgpLMYW=i6ABzWHuqQvJcXDJ-6u-VuFAtU8sxiLvHA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2018, #02; Tue, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 5:51 PM, Junio C Hamano <gitster@pobox.com> wrote:

> * en/rename-directory-detection (2018-01-31) 31 commits
>  - merge-recursive: ensure we write updates for directory-renamed file
>  - merge-recursive: avoid spurious rename/rename conflict from dir renames
>  - directory rename detection: new testcases showcasing a pair of bugs
>  - merge-recursive: fix remaining directory rename + dirty overwrite cases
>  - merge-recursive: fix overwriting dirty files involved in renames
>  - merge-recursive: avoid clobbering untracked files with directory renames
>  - merge-recursive: apply necessary modifications for directory renames
>  - merge-recursive: when comparing files, don't include trees
>  - merge-recursive: check for file level conflicts then get new name
>  - merge-recursive: add computation of collisions due to dir rename & merging
>  - merge-recursive: add a new hashmap for storing file collisions
>  - merge-recursive: check for directory level conflicts
>  - merge-recursive: add get_directory_renames()
>  - merge-recursive: make a helper function for cleanup for handle_renames
>  - merge-recursive: add a new hashmap for storing directory renames
>  - merge-recursive: split out code for determining diff_filepairs
>  - merge-recursive: make !o->detect_rename codepath more obvious
>  - merge-recursive: fix leaks of allocated renames and diff_filepairs
>  - merge-recursive: introduce new functions to handle rename logic
>  - merge-recursive: move the get_renames() function
>  - directory rename detection: tests for handling overwriting dirty files
>  - directory rename detection: tests for handling overwriting untracked files
>  - directory rename detection: miscellaneous testcases to complete coverage
>  - directory rename detection: testcases exploring possibly suboptimal merges
>  - directory rename detection: more involved edge/corner testcases
>  - directory rename detection: testcases checking which side did the rename
>  - directory rename detection: files/directories in the way of some renames
>  - directory rename detection: partially renamed directory testcase/discussion
>  - directory rename detection: testcases to avoid taking detection too far
>  - directory rename detection: directory splitting testcases
>  - directory rename detection: basic testcases
>  (this branch uses en/merge-recursive-fixes.)
>
>  Rename detection logic in "diff" family that is used in "merge" has
>  learned to guess when all of x/a, x/b and x/c have moved to z/a,
>  z/b and z/c, it is likely that x/d added in the meantime would also
>  want to move to z/d by taking the hint that the entire directory
>  'x' moved to 'z'.

When you write release notes for this series, you may want to consider
also calling out one or more of the bugs that were fixed as a side
effect:
  * a bug causing dirty files involved in a rename to be overwritten
during merge
  * a few memory leaks
I added a reminder about these two fixes in the cover letter for my
latest (and possibly last?) roll of the series that I just sent out.
