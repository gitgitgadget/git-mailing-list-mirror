Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30B2C2042F
	for <e@80x24.org>; Wed, 16 Nov 2016 15:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbcKPP6P (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 10:58:15 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35731 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbcKPP6O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 10:58:14 -0500
Received: by mail-qk0-f175.google.com with SMTP id n204so180852752qke.2
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 07:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EWRbDLtnh1qrPoL0/1T60LKXVS6mqbiL82kpbJ4EOQ8=;
        b=XCINAQb3MJahyA8H+Z5QeER9JzP+eeOvOwC6/AnpHOA1yyi9BREJFDG+ZTHUIOz0O1
         oenw1HhXaQD+oaV9bXwi+nVZWAV0nIyBEw5Dj4fT3Yycs7d+Ii2DW1mip0nTsjoTWAf6
         h/vQdI8Lldb/H2dNi1kN8pwb4HZUKnR1575bytVcRCWQZm9vFbXZG/gthq+Z5tu59DlN
         7PdtW8dwppsT6gNdbGPGyNxHpSKBRMnyexn0//bMZQun8Mxq8H1MdDiY7oE593QpFCcM
         5yMUojDZMeyZu/bmirOzvW1GZgFnS1A9UoLU+Wy6oajVpDDFSUGXBuHA6AbOf4OP0mbj
         9Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EWRbDLtnh1qrPoL0/1T60LKXVS6mqbiL82kpbJ4EOQ8=;
        b=JNK73CcrmMhyY7JpTwyzj+Exr58xLmtQJjVuTAFBzkKlMk3K2CPdsnW5ou44QkcNNg
         TWLhMFDFb8pG1/VCZcfimyk6yf1mTa6b+lGwc1aAQ1IZ9E0CaxiodZrH4t0H/ZJcy6FW
         p7nX4MBhnhm4QsrA0vpOW1GEy968Bq/7q3lUsWB3Q8vIH6WmoCbqa8I2oO4IEdBSyC5X
         nsPsLG8mFO5oaar+NDceipCikLxH6ghWWwZDUnLcLFMOGh/UN6rK0fXVZfbLcXmoIBdA
         zz3B1TJznEqwmQcsAb/Ey8XERW1d4prBa5YXGNr0fgkw9Emek1QX+dNMev0dykR5kjdL
         aTGA==
X-Gm-Message-State: AKaTC009zNTG0Dpx/W0CyfXs9jNRFDeT5Q4F2BRSYNWZNOlPvtCmWfrzlRTV9uojZJCezpqsPLO1ZfPvU3zQtQ==
X-Received: by 10.55.201.21 with SMTP id q21mr4631046qki.242.1479311892907;
 Wed, 16 Nov 2016 07:58:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.45.100 with HTTP; Wed, 16 Nov 2016 07:57:52 -0800 (PST)
In-Reply-To: <2C8817BDA27E034F8E9A669458E375EF2BE689@APSWP0428.ms.ds.uhc.com>
References: <2C8817BDA27E034F8E9A669458E375EF2BE63B@APSWP0428.ms.ds.uhc.com>
 <CANoM8SX91JAvJ6EAE6=wavPutUG4ZU1BY-A=5EobW=8zrdEcjw@mail.gmail.com> <2C8817BDA27E034F8E9A669458E375EF2BE689@APSWP0428.ms.ds.uhc.com>
From:   Mike Rappazzo <rappazzo@gmail.com>
Date:   Wed, 16 Nov 2016 10:57:52 -0500
Message-ID: <CANoM8SVXeeZsc40xgVqZep_9oT=J2h4mOO0Ksn+kb0g8Ct=KrQ@mail.gmail.com>
Subject: Re: merge --no-ff is NOT mentioned in help
To:     "Vanderhoof, Tzadik" <tzadik.vanderhoof@optum360.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Please reply inline)

On Wed, Nov 16, 2016 at 10:48 AM, Vanderhoof, Tzadik
<tzadik.vanderhoof@optum360.com> wrote:
> I am running:    git version 2.10.1.windows.1
>
> I typed: git merge -h
>
> and got:
>
> usage: git merge [<options>] [<commit>...]
>    or: git merge [<options>] <msg> HEAD <commit>
>    or: git merge --abort
>
>     -n                    do not show a diffstat at the end of the merge
>     --stat                show a diffstat at the end of the merge
>     --summary             (synonym to --stat)
>     --log[=<n>]           add (at most <n>) entries from shortlog to merge commit message
>     --squash              create a single commit instead of doing a merge
>     --commit              perform a commit if the merge succeeds (default)
>     -e, --edit            edit message before committing
>     --ff                  allow fast-forward (default)
>     --ff-only             abort if fast-forward is not possible
>     --rerere-autoupdate   update the index with reused conflict resolution if possible
>     --verify-signatures   verify that the named commit has a valid GPG signature
>     -s, --strategy <strategy>
>                           merge strategy to use
>     -X, --strategy-option <option=value>
>                           option for selected merge strategy
>     -m, --message <message>
>                           merge commit message (for a non-fast-forward merge)
>     -v, --verbose         be more verbose
>     -q, --quiet           be more quiet
>     --abort               abort the current in-progress merge
>     --allow-unrelated-histories
>                           allow merging unrelated histories
>     --progress            force progress reporting
>     -S, --gpg-sign[=<key-id>]
>                           GPG sign commit
>     --overwrite-ignore    update ignored files (default)
>
> Notice there is NO mention of the "--no-ff" option

I understand.  On my system I can reproduce this by providing a bad
argument to `git merge`.  This is the output from the arg setup.  For
"boolean" arguments (like '--ff'), there is an automatic counter
argument with "no-" in there ('--no-ff') to disable the option.  Maybe
it would make sense to word the output to include both.


>
> -----Original Message-----
> From: Mike Rappazzo [mailto:rappazzo@gmail.com]
> Sent: Wednesday, November 16, 2016 7:37 AM
> To: Vanderhoof, Tzadik
> Cc: git@vger.kernel.org
> Subject: Re: merge --no-ff is NOT mentioned in help
>
> On Wed, Nov 16, 2016 at 10:16 AM, Vanderhoof, Tzadik <tzadik.vanderhoof@optum360.com> wrote:
>> When I do: "git merge -h"  to get help, the option "--no-ff" is left out of the list of options.
>
> I am running git version 2.10.0, and running git merge --help contains these lines:
>
>        --ff
>            When the merge resolves as a fast-forward, only update the branch pointer, without creating a merge commit. This is the default behavior.
>
>        --no-ff
>            Create a merge commit even when the merge resolves as a fast-forward. This is the default behaviour when merging an annotated (and possibly signed) tag.
>
>        --ff-only
>            Refuse to merge and exit with a non-zero status unless the current HEAD is already up-to-date or the merge can be resolved as a fast-forward.
>
>
>
> This e-mail, including attachments, may include confidential and/or
> proprietary information, and may be used only by the person or entity
> to which it is addressed. If the reader of this e-mail is not the intended
> recipient or his or her authorized agent, the reader is hereby notified
> that any dissemination, distribution or copying of this e-mail is
> prohibited. If you have received this e-mail in error, please notify the
> sender by replying to this message and delete this e-mail immediately.
