Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B962C200B9
	for <e@80x24.org>; Mon,  7 May 2018 15:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeEGP5X (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 11:57:23 -0400
Received: from mail-ua0-f174.google.com ([209.85.217.174]:46575 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752303AbeEGP5W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 11:57:22 -0400
Received: by mail-ua0-f174.google.com with SMTP id e8so16446410uam.13
        for <git@vger.kernel.org>; Mon, 07 May 2018 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/pw9z+FbVtjm4YsjFzgSznicBkPjlPZN1o7vXB7US+0=;
        b=SO2XqH2fEkFu0P/wgJORTzzEv5BHfsRcadVsz8F8pS94IsYG3EbQjJ+znEFj9WQg0M
         TR0myIY2rts7iJHgO9PmP8CARB0NnujukhxFQECR4dJjnAYdKRVPmyoxw5oaXG8LttsO
         ralclFPh0FT4/eSqcMR5YmDCO7BXBnrlwnPQ3Pws+5Tv/XmgcAXius+9p0uhB5P7iUjJ
         JxQ0Rqu17hdGpPb5hitGzN4I6+LfHW/hatNkcEn/ykcj4M3/ZXlQsFb0AxSFr0ZD1D4S
         /XUs9bkCHle7PfwYSn7Y6WmOABuWTCmL3f6vL0bjjnoR04iPl60P8HHEfyYeGnBsROFK
         C+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/pw9z+FbVtjm4YsjFzgSznicBkPjlPZN1o7vXB7US+0=;
        b=NEoSrtdsIbzRG92atGQ5TUtKg54A3w9yLfya5JVVzMZbHWNbtjJsQz2UCcN+MGXnIy
         IbZ6dXgcz8uq4yff99CS05lwYczmlv6Ahuva4CKAllhGtkMwkkcV6QWvm69/pVfltYDG
         8Q8heLUGWyZv7BXgc21/MQor0AdhAADB18Whty8BUbLNA7bcKEkoZJ3kTtFKggCW9mQt
         XlXj+9BAkGaUFZ3AZHEGjF5/n+DAtrbz8xQDmcDllXcsoC53G5DQ04ts5iQkw6YYJWym
         z2Ni8LEk4PL9CXklIWbI4tNu63kDHkek84/1th7Y3yBHfjn9eHzI7qvT/GZ3oMEfGBmb
         uRKQ==
X-Gm-Message-State: ALQs6tBHReFbiiDiqYj5xAqVbAy/WtN9orZyQ39vlmRK5LKEpQ6Z3Cmy
        VBtRdD1FATJD0AaCxUIejPr/cUJLBt8DvJ6zI4M=
X-Google-Smtp-Source: AB8JxZokR4iINvd03Igt6WU/67gtd256QpAvkT2E2ePS27jVllSOcewieMoZYjnxEhikYAvRzU1J57i7fSSBQ8N7hbU=
X-Received: by 10.176.10.26 with SMTP id q26mr32810064uah.23.1525708641795;
 Mon, 07 May 2018 08:57:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 7 May 2018 08:57:20 -0700 (PDT)
In-Reply-To: <xmqqa7tbpl5q.fsf@gitster-ct.c.googlers.com>
References: <xmqqa7tbpl5q.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 7 May 2018 08:57:20 -0700
Message-ID: <CABPp-BGG8O=T1xQzPokcfCCujY7S05LtuQz-VQV_64hgmOEBJQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2018, #01; Mon, 7)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, May 7, 2018 at 7:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * en/rename-directory-detection-reboot (2018-04-25) 36 commits
>  - merge-recursive: fix check for skipability of working tree updates
>  - merge-recursive: make "Auto-merging" comment show for other merges
>  - merge-recursive: fix remainder of was_dirty() to use original index
>  - merge-recursive: fix was_tracked() to quit lying with some renamed paths
>  - t6046: testcases checking whether updates can be skipped in a merge
>  - merge-recursive: avoid triggering add_cacheinfo error with dirty mod
>  - merge-recursive: move more is_dirty handling to merge_content
>  - merge-recursive: improve add_cacheinfo error handling
>  - merge-recursive: avoid spurious rename/rename conflict from dir renames
>  - directory rename detection: new testcases showcasing a pair of bugs
>  - merge-recursive: fix remaining directory rename + dirty overwrite cases
>  - merge-recursive: fix overwriting dirty files involved in renames
>  - merge-recursive: avoid clobbering untracked files with directory renames
>  - merge-recursive: apply necessary modifications for directory renames
>  - merge-recursive: when comparing files, don't include trees
>  - merge-recursive: check for file level conflicts then get new name
>  - merge-recursive: add computation of collisions due to dir rename & merging
>  - merge-recursive: check for directory level conflicts
>  - merge-recursive: add get_directory_renames()
>  - merge-recursive: make a helper function for cleanup for handle_renames
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
>  (this branch is used by bp/merge-rename-config.)
>
>  Rename detection logic in "diff" family that is used in "merge" has
>  learned to guess when all of x/a, x/b and x/c have moved to z/a,
>  z/b and z/c, it is likely that x/d added in the meantime would also
>  want to move to z/d by taking the hint that the entire directory
>  'x' moved to 'z'.  Incidentally, this avoids updating a file in the
>  working tree after a (non-trivial) merge whose result matches what
>  our side originally had.

Thanks for adding a comment about the fix for the unnecessary update.
However, you've dropped a comment from the original release note about
the other fix this series also provides, namely, "A bug causing dirty
files involved in a rename to be overwritten during merge has also
been fixed as part of this work."  Was this intentional?
