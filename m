Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2DA71FF34
	for <e@80x24.org>; Thu, 11 May 2017 08:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755266AbdEKIL4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 04:11:56 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:33520 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755230AbdEKILz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 04:11:55 -0400
Received: by mail-io0-f169.google.com with SMTP id p24so16699507ioi.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gSvCiQpQe7rDOjyRE8jMLIZl9YLwo3jwtVHOj3JWYVA=;
        b=jR5WhYettDU+O7QfOqdURvkGnUOh3DWTyR4ZM3meIxA9SzZeP7ySUJ1n2C0E5NL/1G
         7nwhysTXlAMiqgktC6XZ1AcI13ZdttdViVeEl34J7hCtj3suo8sN64sPM2AHgrKkmYHS
         VQ8QnClOta+tJY4aQIB48OArCYbh3MMdE1LR1EGLOpnq1f31xw4naBoBHMy0x3xWGySh
         0HmDyN87jOgLdsukg9Jj1RNIm1sxrc4E4BlTWbEAw14o2KQQJrt1qkLgOWOfY3hyvKWM
         XRMDYfGl4Crk1xs4zLwDStguAVNDghCeAGNE9x3Ua6AAK28lKmsIX3n33vPxg9rnkezS
         6HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gSvCiQpQe7rDOjyRE8jMLIZl9YLwo3jwtVHOj3JWYVA=;
        b=kh7K24iD1pzgA02JdfxWNuQ0F9Lx04xouAr2ZCs2oUDa+wNEiLOpl4DZhdKz3/WrB6
         +7YrUfqFrzzFYVbWDlidbYdprN5EtljwbKSCC3dxlMVgowaOYFwI79zSgD2//nQujG38
         6xBt/99A5Hyt3jU1pn/V0I1q9cGLy60GiB8Hhj5smufh+9ZUZlHJvOFqwGq21Xz76k3e
         l4WB7wfIJTrGgQ7Mo8aBGHDE8RALIQtUcnANJj54S8X9RisCt8BlECjFcVVA9KTrIeT7
         dWXvn0268pvCpjMeA00eQs3J1HLSkxU/w8Tqe5Lv1krs2B7XxM6F85GdWdqR+n7krYmy
         gbUw==
X-Gm-Message-State: AODbwcD7nzkuWzRCxVCew+sWA/gQ+Y2fUGRDRHDu6IsCu8diqg5a36in
        nIxYU97G0HSwxJXFmjEuZCpU5p9Lfg==
X-Received: by 10.107.201.131 with SMTP id z125mr6869724iof.160.1494490314350;
 Thu, 11 May 2017 01:11:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 11 May 2017 01:11:33 -0700 (PDT)
In-Reply-To: <xmqqfugbbzto.fsf@gitster.mtv.corp.google.com>
References: <xmqqfugbbzto.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 11 May 2017 10:11:33 +0200
Message-ID: <CACBZZX5tf9seb0mCR+UOUCk3jA-L47C9qowSnBzzNq9eZ4+H+g@mail.gmail.com>
Subject: Re: https://travis-ci.org/git/git/builds/
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 9:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I was hoping that by ejecting a few topics out of 'pu', we could
> finally see all the build jobs pass their tests under Travis CI.
> Unfortunately, no such luck.  It seems that we have some new issues
> with Gettext-Poison build/test after updates to t0027.  Also the
> updated compatibility regexp thing taken from gawk is not liked by
> the Windows compiler.
>
> Not all of these may not be new issues, but nevertheless, it would
> be nice if we can see all build jobs succeed every once in a while,
> not just for the three stable integration branches but also for 'pu'
> ;-)

The gettext part is my bad, I never tested with EXPENSIVE which
Torsten removed, so now the test runs & fails under poison.

This trivial fixup makes it pass:

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index effc3db0d5..deb3ae7813 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -69,7 +69,7 @@ check_warning () {
        *) echo >&2 "Illegal 1": "$1" ; return false ;;
        esac
        grep "will be replaced by" "$2" | sed -e "s/\(.*\) in [^
]*$/\1/" | uniq  >"$2".actual
-       test_cmp "$2".expect "$2".actual
+       test_i18ncmp "$2".expect "$2".actual
 }

 commit_check_warn () {

Can you please squash that into my patch?
