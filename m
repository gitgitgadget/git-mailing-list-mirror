Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53643ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 09:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiIAJLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 05:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbiIAJL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 05:11:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E45E0FC6
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 02:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662023479;
        bh=errNylINW3XkDTQVGmMZLsxGFVU+VT+wP37S1126id8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ACo+me5O4at8UPq0Gjc6cvJ26i28a1Gb8RxJhlDnlPr4mp05x00UHt9KP/VyBqGu0
         62MvK2S5SIfEOYpWp19Ef1OIwmmdxDUCzbgbrCgts3aG1dVagf3d2B66Leq/DXMk2o
         cezgZgOOQ3+G2ixjxsfTbDvkI0k6dIbl7mItWDkU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysRk-1pGg2n3ING-00vt1f; Thu, 01
 Sep 2022 11:11:19 +0200
Date:   Thu, 1 Sep 2022 11:11:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/8] scalar: include in standard Git build &
 installation
In-Reply-To: <4d69e5eaccb8873eece666a3d2bb2b22abdde7ea.1661961746.git.gitgitgadget@gmail.com>
Message-ID: <sso99so6-n28s-rq86-8q20-4456r3pn869r@tzk.qr>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com> <4d69e5eaccb8873eece666a3d2bb2b22abdde7ea.1661961746.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:egutNKeHiGsddu4VzrMiYwWunNAi+f/2ZaIZ1YUfuTWpqcouCz6
 P+efm8MR2rw6ikd1iOSVICQgBlcsAxR1wwWn8TFKu4mO54D1sql6slfLuiN17yrbE0rE/ci
 MSeX1p3s9UaJoah8Fp9VEFB7IUnk0ymSIKF+B9bC3Uxgr4WWC770iKqHn9z7XPhbnXgHBmI
 kP+SN9UvsTDQ0LxvsIuAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OSu6vxj1x/Y=:GUA3+Q8QG8rnvBNCaih/Z5
 CckpGeA02/ThpZKDCvGU3FsFjeRqkNDcLJGWDnCorGMNMY3qSvL5n130bI45lUUijkzDG9Eid
 171iX5g1OYsFuSM++rIWsP4j2/7VyYO1fQA8DHlfxxmgjdxpldRZ4vA5ktQZxBGiQvGF3SRlU
 m9DAAFl840BK6UZStnd5TFJVMIEi7CzZvhhfakvshRvWaMLCZfJUG4n7kX/iB5E/y6L839QFF
 Wlpoh1OHUIu3oWS65zh/om48q+cZ6XqyMiI1278692j+ME1RlNtCHjeaE2BImMDk1xlA8pvH5
 Uc7FbzYR0otZQxE2F0WATeIsuFcvai65N6PHet5AyuPkRhy+VbgiHwyg7wUu7QdaiSQhDGf6N
 yx0UCzvhg1eTNN0m5OwQrNALOiGUn+CtzFmqTTma9Lt1jPu7653tZvqAfMShqOvMCpUyjwTfM
 YNXgbeba9hb03sm0qd/nv5BlH+jcj9PPDMRmn0qYffm75O7Dj1MP40ElUEw3FXqES45nhtO9U
 15D8fJRqOJhQM4axQvRhh+ATamwteAln3Rp/PMu0W51vfAVbgBJPPdp74dlcynsi1igxjv5aI
 JRZhHCw/+puXdo6M4zR0NXHNDu3TUe+hn7OmRSZPqgfcSbb8cTfk6IpZFGQqHz6PtmTbiSYfR
 7qJzbTuIxzg/pfCfC5/9GZygS4N38rSvZRQSHLieVA2xoWWq4bPQi5ANzvIE5DJeF51PH+dmB
 xpx+1hxxJI7An5Czf7ukimCDepNnznQrbQsVKm+eNshcxIq98P3Qujgk5IijWDHSjV/Afuv89
 PkCO8hoT8sWAW5Y9lUxqYZUR3O6GM/d/dw28Iu6wfb8yM+FUHu19B1oDW9UNAw8S6TKe4Tk5V
 VZ6bUMeLok6+pifCckYst2Y69WWhYGsDz6wkVZ3btR2SGYpCdu07pWuIkomtUEDFebJQw2Xu8
 IYA78oWRM/JtD3/V/Peh77JNJ9u2q0FYtR9DYm+z9nMuG11BP95hSiOASghg4UjM5KIogbdMT
 fBLGVNUC8Ql0gixmc2vTpslyWWgTiwIk0ZuYBo7vNfC2H0OtmDkeVHCcIe0FzEj9QLY86Ecqw
 vvTy+wQBeqXvYu/+kYo6mFNi0Ke9bBSHn8NFhjHPfzHmwimUop0WGirNw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

On Wed, 31 Aug 2022, Victoria Dye via GitGitGadget wrote:

> From: Victoria Dye <vdye@github.com>
>
> Move 'scalar' out of 'contrib/' and into the root of the Git tree. The g=
oal
> of this change is to build 'scalar' as part of the standard Git build &
> install processes.
>
> This patch includes both the physical move of Scalar's files out of
> 'contrib/' ('scalar.c', 'scalar.txt', and 't9xxx-scalar.sh'), and the
> changes to the build definitions in 'Makefile' and 'CMakelists.txt' to
> accommodate the new program.
>
> At a high level, Scalar is built so that:
> - there is a 'scalar-objs' target (similar to those created in 029bac01a=
8
>   (Makefile: add {program,xdiff,test,git,fuzz}-objs & objects targets,
>   2021-02-23)) for debugging purposes.
> - it appears in the root of the install directory (rather than the
>   gitexecdir).
> - it is included in the 'bin-wrappers/' directory for use in tests.
> - it receives a platform-specific executable suffix (e.g., '.exe'), if
>   applicable.
> - 'scalar.txt' is installed as 'man1' documentation.
> - the 'clean' target removes the 'scalar' executable.
>
> Additionally, update the root level '.gitignore' file to ignore the Scal=
ar
> executable.

A great commit message, and even though the diff is large, it is eminently
reviewable, with one exception:

> @@ -3062,7 +3067,7 @@ bin-wrappers/%: wrap-for-bin.sh
>  	$(call mkdir_p_parent_template)
>  	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>  	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
> -	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(pats=
ubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
> +	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(fil=
ter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \

It took me a good while to wrap my head around this (and let me be clear:
I consider none of this your fault, it's the fault of the design of the
Makefile syntax).

Let me untangle this, for posterity's benefit. We substitute the
placeholder `@@PROG@@` with a concatenation of two strings that are both
derived from `@F`, i.e. the basename of the to-be-wrapped command.

Before, the first string would be the dashed command, verbatim, unless its
name starts with a `test-` prefix, in which case we would add another
prefix (`t/helper/`) _and_ append the `.exe` suffix on Windows.

And the second string would be a `.exe` for all remaining cases that need
it: the commands starting with `git` and listed as needing the suffix.
Otherwise, the second string would be empty.

Convoluted, sure, but it worked.

In the new version, the first string would be the basename of the
to-be-wrapped command, with `t/helper/` prefixed for the `test-` helpers.

The second string would be a `.exe` for _all_ commands, except for those
specifically listed as not wanting that suffix as per
`BINDIR_PROGRAMS_NO_X`.

The new logic is so much simpler to understand!

Feel free to add a `Reviewed-by:` footer for me if you send another
iteration of this patch series.

Thank you,
Dscho
