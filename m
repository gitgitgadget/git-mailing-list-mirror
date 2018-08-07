Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B427208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 15:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403831AbeHGSBL (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 14:01:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34306 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389066AbeHGSBL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 14:01:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id n96-v6so12000996lfi.1
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LMozXw1ovFDpX8B29eOKdQEbUgdFqqR+9l3YZ/C1NLw=;
        b=h6khfdmi1GqEDrkoXAINsUD0cqIZLuxIFHRYhwtyDOGATN9aK2n8lL5sWkn5/P8NYk
         SmaZWLb78Zsc0sN9AM4VDGQHCA4g8DUAkSZ/GxqeyprWGnXpwY+deiUNoVjEbGyiC1dv
         zEx7EJGb1Lip723SK7XvsYI2hUHuaQmdhQ9Xw3eXYCgUV5p8mg1OpcAQyYhg5aYgAhv5
         XYQ9CCsf9RFfvtZyvaCZI+743QRT/zz/jfFLGmkuuNpWGNXzBLRXMRsanaMxkCGM5nho
         E368UpkMvdD+ksWnD6V59powXOMNRJys8jqZOw8SKZT3CEihlunbJp/RiQC96dNyFMTp
         hM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LMozXw1ovFDpX8B29eOKdQEbUgdFqqR+9l3YZ/C1NLw=;
        b=VHR03mL8ig2ZuzIMQgrJDWiLyBYGV3U89d5g+UefRQBhr1vJoWDm0vpNK+SQFbfW6S
         s9sbZVCWxY0tjhL0tDwGoaaSCIYaoq7v7CAojjszOR9y4lZk57FF/rMEMlKepDVRllr0
         XGsuBwFS89JAKyKRmytcndxNWdqLaYpTcgqHwV2yKm8eUcsF+VCblSRrbjKrEmpEcooi
         MYcuqQEBb8xnY6gsKIFlSHg2mowRCnsoRdwWV/G1jxok3JSqh+9Hsr7zg5YtgQMLzxyr
         yU5dtG5HrK7U2cqpTm8yoKDO9q2+75UCKtCJEkg0tVNsQxh+p1knnMagxezd+jBVSr7l
         ozOw==
X-Gm-Message-State: AOUpUlFHWyNUTgQ2cFWidFmqKP0nt+b1E9opin5P6nNrCZXaHlmaT/ri
        8vCJr8MAI67U95VNBwyAMcLqhgEEsPRj+K5ys9Y=
X-Google-Smtp-Source: AAOMgpcjA5I/VQWN4KUqja/HfjedPEsfABY0wiRZUtZb26oCbLz7BLsHrvny89CLXpOv4x+mha02UtL0IUQNHQBfz64=
X-Received: by 2002:a19:a5c5:: with SMTP id o188-v6mr15557119lfe.149.1533656773638;
 Tue, 07 Aug 2018 08:46:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2bcc:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 08:46:13 -0700 (PDT)
In-Reply-To: <CAN0heSrsHNnZoMFF+v+Fc_Ketk3fnQsnM=BuYVwkT5DPRjHsLw@mail.gmail.com>
References: <20180807132113.118297-1-gitter.spiros@gmail.com> <CAN0heSrsHNnZoMFF+v+Fc_Ketk3fnQsnM=BuYVwkT5DPRjHsLw@mail.gmail.com>
From:   Elia Pinto <gitter.spiros@gmail.com>
Date:   Tue, 7 Aug 2018 17:46:13 +0200
Message-ID: <CA+EOSBmA_147s=ON3UMiQ=aN_7uy2TYQvcsU-qOnF9UtiyyiQQ@mail.gmail.com>
Subject: Re: [PATCH] worktree: add --quiet option
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-08-07 16:37 GMT+02:00 Martin =C3=85gren <martin.agren@gmail.com>:
> Hi Elia
>
> On 7 August 2018 at 15:21, Elia Pinto <gitter.spiros@gmail.com> wrote:
>> Add the '--quiet' option to git worktree add,
>> as for the other git commands.
>>
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>> ---
>>  Documentation/git-worktree.txt |  4 +++-
>>  builtin/worktree.c             | 11 +++++++++--
>>  2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree=
.txt
>> index 9c26be40f..508cde55c 100644
>> --- a/Documentation/git-worktree.txt
>> +++ b/Documentation/git-worktree.txt
>> @@ -115,7 +115,9 @@ Unlock a working tree, allowing it to be pruned, mov=
ed or deleted.
>>
>>  OPTIONS
>>  -------
>> -
>
> Grepping through Documentation/, it is clear that we sometimes have a
> blank line here, sometimes not. I'm not sure what to make of that.
>
>> +-q::
>> +--quiet::
>> +       With 'add', suppress feedback messages.
>>  -f::
>
> But I do think that for consistency, we'd prefer a blank line before `-f:=
:`.
>
> Both the commit message and this documentation makes me wonder if this
> focuses on "add" because it's the only subcommand where `--quiet` makes
> sense, conceptually, or because this is where you happen to need it
> personally, or due to some other $reason. Could you say something more
> about this?
>
> I'm not a worktree power-user, so please forgive my ignorance...
>
>> @@ -315,6 +316,9 @@ static int add_worktree(const char *path, const char=
 *refname,
>>                 cp.argv =3D NULL;
>>                 argv_array_clear(&cp.args);
>>                 argv_array_pushl(&cp.args, "reset", "--hard", NULL);
>> +               if (opts->quiet)
>> +                       argv_array_push(&cp.args, "--quiet");
>> +               printf("%s\n","soo qia");
>
> This last line looks like debug cruft.
>
>> @@ -437,6 +441,7 @@ static int add(int ac, const char **av, const char *=
prefix)
>>                 OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at n=
amed commit")),
>>                 OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the=
 new working tree")),
>>                 OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new =
working tree locked")),
>> +               OPT__QUIET(&opts.quiet, N_("suppress progress reporting"=
)),
>
> This matches other users. Good.
>
> I did some simple testing and this appears to be quite quiet, modulo
> the "soo qia" that I already mentioned. Could you add a test to
> demonstrate the quietness and to keep it from regressing? Something like
> `git worktree add ../foo >out && test_must_be_empty out" in e.g.,
> t2025-worktree-add.sh might do the trick (capture stderr as well?).
>
> Hope this helps
> Martin


Thank you all. sorry for the trash in the patch I will resend it.
