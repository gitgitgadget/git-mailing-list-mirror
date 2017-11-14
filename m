Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F216220291
	for <e@80x24.org>; Tue, 14 Nov 2017 00:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751123AbdKNAHI (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 19:07:08 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:46017 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdKNAHH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 19:07:07 -0500
Received: by mail-qt0-f174.google.com with SMTP id n32so5678240qtb.2
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 16:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f0Q6bA3GN9OlzenusdxpzQkLcj2iqdXeJqZWG+1Ci/k=;
        b=tFgbcK+F5KUkB2rgly4P7Eabca+/ci30bSHT0sto+BTwOS/UPIx/eRtzuXvFMPbsPy
         PXYqRNgFAZNXcHYFZYNhuXqcN5fL+1yR4HIIcbVVmZACyuXGlr8O0lcYy7e7KVG0lBEB
         /IW72/4G9Aa1TzYGLWI0DULTka3rmN0cuCl6MOQvMD/cl/bNDHcvFU9QIcuebQuiOcgZ
         SpXxduzzDg6u06JNHtTsDBwfc1VWh8TuHuEiZ+CgVw28HpWC/uFFsLSQ3rDbbePKzDuM
         R20u9gT1FRTt+PMhXfNO7W2M00OvWTf+L2VRScRDpIgs9BREwQwF/YMCPPKkn4dqeFtQ
         sKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f0Q6bA3GN9OlzenusdxpzQkLcj2iqdXeJqZWG+1Ci/k=;
        b=re+JvE4ajp66O0UL5hNH2I/k51A5zVdw/2699+Vxm98waKwbO0AttW6JloqO+oW9bV
         AH7uuSUmuoBDTbJ3P40TbCmXDe6kZjeS7rz2Kx0lNaHpLM38wxnzJbUThHA+USQVMZNn
         qTyOsmvGoEhks56raAIJXjG2vwP8j8HGMl1OYTynqFRaZH/RQAeEqPEcpTOVxdj+jW+5
         lpMDcJCeFrU3G6S6AqpNVXuGO6iIYIlLFkS7zErEiirKAhvQaMVkq9IzkT8AQsBMN1D2
         TD5VEZQpRM91EqrqupcNPBrCbZXsgUFWc6aFdYDzmw9urpzlTH95hSFY4U9fqowRC41g
         3tGg==
X-Gm-Message-State: AJaThX6buXcTiJgJnFLlXbNWpE48daekiv3wpytSgxnaoVbDTVOIFAqC
        kVX+k57xYEZGrbQkfqlKQmLD18NKj3oxer/+3AjaVQ==
X-Google-Smtp-Source: AGs4zMY8PVrqCHJKPI0tuXAGqYZVpnRJ61g0TXjsb/JtuvIV32+oeHhyH9/H4pgduc3WiJb0VvqBxAWO0ye6KXTkmCI=
X-Received: by 10.200.27.225 with SMTP id m30mr15105461qtk.260.1510618026950;
 Mon, 13 Nov 2017 16:07:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 13 Nov 2017 16:07:06 -0800 (PST)
In-Reply-To: <20171110190550.27059-8-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-8-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Nov 2017 16:07:06 -0800
Message-ID: <CAGZ79kaR5yfpopa+oB13ZftY_Qi37OXaATjeL21gyAP6abpxAw@mail.gmail.com>
Subject: Re: [PATCH 07/30] directory rename detection: partially renamed
 directory testcase/discussion
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6043-merge-rename-directories.sh | 100 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>
> diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
> index 021513ec00..ec054b210a 100755
> --- a/t/t6043-merge-rename-directories.sh
> +++ b/t/t6043-merge-rename-directories.sh
> @@ -650,4 +650,104 @@ test_expect_success '3b-check: Avoid implicit rename if involved as source on cu
>  #   of a rename on either side of a merge.
>  ###########################################################################
>
> +
> +###########################################################################
> +# SECTION 4: Partially renamed directory; still exists on both sides of merge
> +#
> +# What if we were to attempt to do directory rename detection when someone
> +# "mostly" moved a directory but still left some files around, or,
> +# equivalently, fully renamed a directory in one commmit and then recreated
> +# that directory in a later commit adding some new files and then tried to
> +# merge?
> +#
> +# It's hard to divine user intent in these cases, because you can make an
> +# argument that, depending on the intermediate history of the side being
> +# merged, that some users will want files in that directory to
> +# automatically be detected and renamed, while users with a different
> +# intermediate history wouldn't want that rename to happen.
> +#
> +# I think that it is best to simply not have directory rename detection
> +# apply to such cases.  My reasoning for this is four-fold: (1) it's
> +# easiest for users in general to figure out what happened if we don't
> +# apply directory rename detection in any such case, (2) it's an easy rule
> +# to explain ["We don't do directory rename detection if the directory
> +# still exists on both sides of the merge"], (3) we can get some hairy
> +# edge/corner cases that would be really confusing and possibly not even
> +# representable in the index if we were to even try, and [related to 3] (4)
> +# attempting to resolve this issue of divining user intent by examining
> +# intermediate history goes against the spirit of three-way merges and is a
> +# path towards crazy corner cases that are far more complex than what we're
> +# already dealing with.

This last paragraph ("I think") sounds like part of a commit message,
rather than
a note inside a testing script. Not sure if I recommend moving this
text into the
commit message.

> +# This section contains a test for this partially-renamed-directory case.
> +###########################################################################
> +
> +# Testcase 4a, Directory split, with original directory still present
> +#   (Related to testcase 1f)
> +#   Commit A: z/{b,c,d,e}
> +#   Commit B: y/{b,c,d}, z/e
> +#   Commit C: z/{b,c,d,e,f}
> +#   Expected: y/{b,c,d}, z/{e,f}
> +#   NOTE: Even though most files from z moved to y, we don't want f to follow.

Makes sense.

> +###########################################################################
> +# Rules suggested by section 4:
> +#
> +#   Directory-rename-detection should be turned off for any directories (as
> +#   a source for renames) that exist on both sides of the merge.  (The "as
> +#   a source for renames" clarification is due to cases like 1c where
> +#   the target directory exists on both sides and we do want the rename
> +#   detection.)  But, sadly, see testcase 8b.

Looking forward for that test case.
