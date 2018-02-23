Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C7B1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 21:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeBWVJP (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 16:09:15 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:43381 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbeBWVJO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 16:09:14 -0500
Received: by mail-vk0-f45.google.com with SMTP id p189so1718282vkd.10
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 13:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9ubBUVdNSIYWwhmM036C4dmCOLWupGurDkaIxK+qpT4=;
        b=ZTPIpHcDCooqPVWGwqpojXd0G1D+2lXGwaSY4UrUkxrbYUdFyUIS83sWRz29H5W6tK
         ZZUUfwCpXHP4EQIKU2SGaUsnvyCMTE5uIeO1AvATP8BeXZK65nzZNDy8JoDOIV5ijsaS
         oHe9FSzCshjghiZj6tiNNdBWUqmO/zqLeU+EeEttzOs8K7kh2BSysXLUYJp6hb65W+CU
         5u2/KFzkzRnSxQNIl/AfkHpHGsjPUmbB1ucOKT8P39uI1pXRp5Ms7LLuHjBgVNy5xTPO
         93ItefVFi8s07Psmrbgd8V348Ub8IUQcnxtuUF1TfXcqa72ZUUsIYIvHtYCxuswrGXTg
         Yrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9ubBUVdNSIYWwhmM036C4dmCOLWupGurDkaIxK+qpT4=;
        b=a8SPJc66UlCQOGwOqno7w0jhtPfjJoX6QW9fq/I1AwOqKWlIK+zaviEcD1kTDq4Hge
         x+OHmOGkDEHo/JoCtsRKh8rNw5Xl7pVEQTim131w0lWChj7vMsISU9IUtAYZ4jEBpkLi
         EU4nLebbY+vYUOjQfbSJVFtkWulLZh+Ljj5VzRlJ4dBsiS4jyEIn4d9ybweDKLBF+tnZ
         DGMJBdyjK15rCrvaLrxvWB239H3yOJrABTebfuQd+XSzt8W212H01hTl5GOCq+37MpGy
         GfsbcYHWHCypOFdfg+zZddD0VKUG4N7h3AUq2WOZk2aMwlwP++q6CU0MM4v9ePOVu6Vn
         Awrw==
X-Gm-Message-State: APf1xPDQQhstX/jeVbx4v4mwbUlikRAoOxaN2DixZZRBmUCTFkSRcNy+
        iqE61Ig6dWYpM/Zyk3xkDUNjTgQ3goo0ikSIha8=
X-Google-Smtp-Source: AG47ELtWEPcuqbkaVbA3jkRDy2nd+OjQ6201vfnTYFMfXG0d5jARsBnujMWUnJJ4k+spF3yQLKHAISYaDbPzndY+lTc=
X-Received: by 10.31.115.197 with SMTP id o188mr2218190vkc.106.1519420153228;
 Fri, 23 Feb 2018 13:09:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.49 with HTTP; Fri, 23 Feb 2018 13:09:12 -0800 (PST)
In-Reply-To: <xmqq1shdyidz.fsf@gitster-ct.c.googlers.com>
References: <xmqq1shdyidz.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Feb 2018 13:09:12 -0800
Message-ID: <CABPp-BEZ+a4aKvMbQpSeJWh5v_o+BAHhO7Az50Dr4nahH67y=g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2018, #03; Wed, 21)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 4:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * en/rename-directory-detection (2018-02-14) 29 commits
>  - merge-recursive: ensure we write updates for directory-renamed file
>  - merge-recursive: avoid spurious rename/rename conflict from dir rename=
s
>  - directory rename detection: new testcases showcasing a pair of bugs
>  - merge-recursive: fix remaining directory rename + dirty overwrite case=
s
>  - merge-recursive: fix overwriting dirty files involved in renames
>  - merge-recursive: avoid clobbering untracked files with directory renam=
es
>  - merge-recursive: apply necessary modifications for directory renames
>  - merge-recursive: when comparing files, don't include trees
>  - merge-recursive: check for file level conflicts then get new name
>  - merge-recursive: add computation of collisions due to dir rename & mer=
ging
>  - merge-recursive: check for directory level conflicts
>  - merge-recursive: add get_directory_renames()
>  - merge-recursive: make a helper function for cleanup for handle_renames
>  - merge-recursive: split out code for determining diff_filepairs
>  - merge-recursive: make !o->detect_rename codepath more obvious
>  - merge-recursive: fix leaks of allocated renames and diff_filepairs
>  - merge-recursive: introduce new functions to handle rename logic
>  - merge-recursive: move the get_renames() function
>  - directory rename detection: tests for handling overwriting dirty files
>  - directory rename detection: tests for handling overwriting untracked f=
iles
>  - directory rename detection: miscellaneous testcases to complete covera=
ge
>  - directory rename detection: testcases exploring possibly suboptimal me=
rges
>  - directory rename detection: more involved edge/corner testcases
>  - directory rename detection: testcases checking which side did the rena=
me
>  - directory rename detection: files/directories in the way of some renam=
es
>  - directory rename detection: partially renamed directory testcase/discu=
ssion
>  - directory rename detection: testcases to avoid taking detection too fa=
r
>  - directory rename detection: directory splitting testcases
>  - directory rename detection: basic testcases
>
>  Rename detection logic in "diff" family that is used in "merge" has
>  learned to guess when all of x/a, x/b and x/c have moved to z/a,
>  z/b and z/c, it is likely that x/d added in the meantime would also
>  want to move to z/d by taking the hint that the entire directory
>  'x' moved to 'z'.  A bug causing dirty files involved in a rename
>  to be overwritten during merge has also been fixed as part of this
>  work.
>
>  Will merge to 'next'.

SZEDER G=C3=A1bor requested (just over a week ago, but I was out at a
funeral) that I switch is_null_sha1() to is_null_oid() in one of these
patches.  It's a trivial change and squashes cleanly, but if you're
merging this series to next, I'm curious whether I should submit this
change as a new patch on top of the series, if you'd prefer a full
re-roll of the whole series, or something else.  It's the only change
I'm aware of anyone wanting to see; otherwise I think the series is
complete.
