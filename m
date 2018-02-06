Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E6A51F404
	for <e@80x24.org>; Tue,  6 Feb 2018 12:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeBFMCt (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 07:02:49 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36898 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752634AbeBFMCr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 07:02:47 -0500
Received: by mail-ot0-f196.google.com with SMTP id e64so1478482ote.4
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 04:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TEETgwckOiNSDjZLmNjq6kqGgriLxhReFh2pVsE8aZ8=;
        b=bPc57AWfUbQC3JmaEO4nSZEfaAQxpg1GLY+BymrKvdQEwvjzLi+BDLsAcGsX8l8NjH
         Cp7HyZxXtbZTcMBC/6IQGEbn/oUfMOFRrf8ql0ppfR/xJ1YJwBcGahJrW8SitAdr6xwH
         w2IdC/2pH2ywzt2o+k5hvjNapudyf/bd0GWDJruf/uQhSIjVFP3XAmv76XZJNhzYsn1v
         4BH3rnrL/HEziWu17oUyL01G8vgqJwRjzjSM83+McgiYe8z/wDVrElk0c1e4sn9FFN9h
         BjyrNGPv6C7nxOXDDUrCjREQLOND0CzZo6FLQNF77CraS422wZOKf+P5rS+MaMkBo0+W
         52GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TEETgwckOiNSDjZLmNjq6kqGgriLxhReFh2pVsE8aZ8=;
        b=FqIvMMIPliMFshHNgrjk2VILSaFbiVvaSsYoszoffoAjDlOcnjTRnxqEW0QtjGT9Mj
         J1MlEa0rIgW/LHDJUCr810WfZLuM1kLNLBRa5JM7UPt/bNV42N9tgN5xFOCpczH+qghs
         SVOcWQOqNo+c2i5dcH5QrsbQ245fUKxvRRe0CsU37vuZx7MjMaK33EAwmdbx7ZaE8F+J
         yi674B1Hpm8t/HIvzKkGQUdM42PN7TSL/1X+OAnsPD5xYuD+y8xPNhpqGySsx34/8yWf
         XYhkE12f+cc8eBJ+ko0RWFjvTrqlvpan+SvZ27m7FNfHI4If/ZoT623fzxE821YzNCGb
         pwTw==
X-Gm-Message-State: APf1xPBbKz6i/JkMLFqoQ1KlnQ3qmb3lNBUfQirJKLtKjR08WAJVqFJ/
        qsRUOZ4B08yWy81BbpcakrDxjGlLfq0pfJbUb3s=
X-Google-Smtp-Source: AH8x225dfNOiKdyL4UXdFEN3/bpzjjD3pgWXCl1fYehzZH+OLPdanuUqlRo40jRaQmedqtz8SO3O16gzHRrU8/tWwB4=
X-Received: by 10.157.12.142 with SMTP id b14mr1626400otb.226.1517918566696;
 Tue, 06 Feb 2018 04:02:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Tue, 6 Feb 2018 04:02:16 -0800 (PST)
In-Reply-To: <f002344e-e8ae-84e8-a1aa-45e44c0ccc88@gmail.com>
References: <CACsJy8DH2_gBqj3xs4Cr6kOAUsQ5hn88weMeXR8GtYCNvYgLDQ@mail.gmail.com>
 <20180204093823.3671-1-pclouds@gmail.com> <f002344e-e8ae-84e8-a1aa-45e44c0ccc88@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Feb 2018 19:02:16 +0700
Message-ID: <CACsJy8DHvae4H+JuMkLxo+M=tWro-C_3th+bZnAi+G-_qA_ZJA@mail.gmail.com>
Subject: Re: [PATCH] dir.c: ignore paths containing .git when invalidating
 untracked cache
To:     Ben Peart <peartben@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 12:44 AM, Ben Peart <peartben@gmail.com> wrote:
>
>
> On 2/4/2018 4:38 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>
>> read_directory() code ignores all paths named ".git" even if it's not
>> a valid git repository. See treat_path() for details. Since ".git" is
>> basically invisible to read_directory(), when we are asked to
>> invalidate a path that contains ".git", we can safely ignore it
>> because the slow path would not consider it anyway.
>>
>> This helps when fsmonitor is used and we have a real ".git" repo at
>> worktree top. Occasionally .git/index will be updated and if the
>> fsmonitor hook does not filter it, untracked cache is asked to
>> invalidate the path ".git/index".
>>
>> Without this patch, we invalidate the root directory unncessarily,
>> which:
>>
>> - makes read_directory() fall back to slow path for root directory
>>    (slower)
>>
>> - makes the index dirty (because UNTR extension is updated). Depending
>>    on the index size, writing it down could also be slow.
>>
>> Noticed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>   Sorry for the resend, I forgot git@vger.
>>
>>   dir.c             | 13 ++++++++++++-
>>   git-compat-util.h |  2 ++
>>   wrapper.c         | 12 ++++++++++++
>>   3 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/dir.c b/dir.c
>> index 7c4b45e30e..f8b4cabba9 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -1773,7 +1773,7 @@ static enum path_treatment treat_path(struct
>> dir_struct *dir,
>>         if (!de)
>>                 return treat_path_fast(dir, untracked, cdir, istate, pat=
h,
>>                                        baselen, pathspec);
>> -       if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
>> +       if (is_dot_or_dotdot(de->d_name) || !fspathcmp(de->d_name,
>> ".git"))
>>                 return path_none;
>>         strbuf_setlen(path, baselen);
>>         strbuf_addstr(path, de->d_name);
>> @@ -2970,8 +2970,19 @@ static int invalidate_one_component(struct
>> untracked_cache *uc,
>>   void untracked_cache_invalidate_path(struct index_state *istate,
>>                                      const char *path)
>>   {
>> +       const char *end;
>> +       int skipped;
>> +
>>         if (!istate->untracked || !istate->untracked->root)
>>                 return;
>
>
> Thank you for this patch!  It's great to see people helping improve the
> performance of git.
>
> I ran a quick test and this is not sufficient to prevent the index from
> getting flagged as dirty and written out to disk when fsmonitor detects
> changes for files under the .git folder.  What I'm seeing is that when
> ".git/index" is returned, the test below doesn't catch them and end early=
 as
> would be expected.

Right. I focused too much on ".git" in the middle and the end of the
path and forgot that it's also at the beginning.

> As a result, invalidate_one_component() is called which calls
> invalidate_one_directory() which increments dir_invalidated counter and t=
he
> regular dirty process continues which triggers the index to be written to
> disk unnecessarily.
>
>> +       if (!fspathcmp(path, ".git"))
>> +               return;
>> +       if (ignore_case)
>> +               skipped =3D skip_caseprefix(path, "/.git", &end);
>> +       else
>> +               skipped =3D skip_prefix(path, "/.git", &end);
>> +       if (skipped && (*end =3D=3D '\0' || *end =3D=3D '/'))
>> +               return;
>
>
> If I replace the above lines with:
>
>         if (ignore_case)
>                 skipped =3D skip_caseprefix(path, ".git", &end);
>         else
>                 skipped =3D skip_prefix(path, ".git", &end);
>
> Then it correctly skips _all_ files under ".git".  I'm not sure if by
> removing the leading slash, I'm breaking some other case but I was not ab=
le
> to find where that was expected or needed. Removing the leading slash als=
o
> allows me to remove the fsmpathcmp() call as it is now redundant.

Removing "/" could catch things like abc/lala.git/def, which
treat_path does not consider special and may show up as untracked
entries. In that sense, the updated invalidate_... is broken if we
don't invalidate them properly.

I think what we need here is something like

    if (!fspathcmp(path, ".git") || starts_with(path, ".git/"))

but can handle case-insensitivity as well (starts_with can't).

> I wondered what would happen if there was some other directory named ".gi=
t"
> and how that would behave.  With or without this patch and with or withou=
t
> the untracked cache, a file "dir1/.git/foo" is ignored by git so no chang=
e
> in behavior there either.

That's what I meant by treat_path() and invisibility in my commit
message. We always ignore directories (or even files) named ".git". It
does not matter if it contains anything remotely related to git. I'm
not saying it's a good thing, but it's how it is and changing that
requires a lot more work, possibly some performance degradation if you
start to check if ".git" is a valid repo before ignoring. So I focus
on improving this function alone first.
--=20
Duy
