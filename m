Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 766B21FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 17:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932523AbdJ3R0b (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:26:31 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:46926 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932434AbdJ3R0a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:26:30 -0400
Received: by mail-qt0-f181.google.com with SMTP id 1so17380875qtn.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 10:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MN5br/DN/qdDei4RjnKV/5RRp0DKARD6vrqPm3pXT2I=;
        b=GkKKWH0w/jN8rlAFlW0cSctsEq4fEOzHcc2aypSn3BKqXj6JCxWitddbe9mRs02yC5
         wGqHPGixDUo+yF4v5G5/bG5tTHguKbyCGpPHdcCJfJbYOQ/txJtHSPZrv7+w4odVq5gP
         X8mUSLYHZjd0/rAMni/OQTWLTXve69dyEAnNamIGdudqMeKnFnvegrsW2LH7Y4LEF07l
         /swBGv+HgzfPg0b7rQkQe9/5SOZl+D0MF9uGoxkpNp2M3FFjOgqTq6McFPhNhc7cjHw1
         0np2MRZCaMPRDvFPAX1Lv6NzUrBnq5wUF4vUwDvtQW7iHVd4CEg4uXUEKzj6nHpKrSQc
         V7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MN5br/DN/qdDei4RjnKV/5RRp0DKARD6vrqPm3pXT2I=;
        b=J7fTkZCvl3nkB6zdorCpGj63gqZ3JFbOj8cU50C90bjsQJpURAWJlXAlgU7DNyxko7
         C0hPN/qc+MUsvxWMUTQRd+rx21PQ/PgjES6gMzgVBriNdVDXXu8adqr/WxOS1tgUQ/QQ
         GR3m02vgwEv/rRG4NiSlTm7s8gB6WIREdx3Q0tf2FtIwlXjNKP4pODuX61qbM1W+cYMa
         esJsFAXlOs0DzFdzu5lOIUNZFcpttXwD0pBSs62ZBYy1XkWjrUE4E6bUmo+GRKqD9dtV
         dpSqSAVCTQS7CZ3AsaApwGVF+V/mvYmFttj6aqqo5754zHksvgvygjeWqBl8+qyGS685
         cPdQ==
X-Gm-Message-State: AMCzsaVIh8GnLoI7ewWhXvKbSobib64k/GqIJKo7w7AP2ntQ24W20Xj2
        V6EvtFyO91OOswkmOlfpI+H0SpS5VmbyqGERQgs=
X-Google-Smtp-Source: ABhQp+QTHteLKBoXwjubih5W9W1Kq9m0zE8O5qCk+4FKODrzp0oG0iUB6byPUE6Ftwj7bl06keMDMl8P5Nv1j9uwm28=
X-Received: by 10.200.4.130 with SMTP id s2mr15172802qtg.338.1509384389548;
 Mon, 30 Oct 2017 10:26:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.28.246 with HTTP; Mon, 30 Oct 2017 10:26:28 -0700 (PDT)
In-Reply-To: <xmqqshe4bib0.fsf@gitster.mtv.corp.google.com>
References: <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <xmqqshe4bib0.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Mon, 30 Oct 2017 22:56:28 +0530
Message-ID: <CAFZEwPPq30e_5Zp0UZ8UgTG415w3vLq_J6e=GFxThCZdCFjUxA@mail.gmail.com>
Subject: Re: [PATCH v16 Part II 1/8] bisect--helper: `bisect_reset` shell
 function in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Fri, Oct 27, 2017 at 11:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> +static int bisect_reset(const char *commit)
>> +{
>> +     struct strbuf branch = STRBUF_INIT;
>> +
>> +     if (!commit) {
>> +             if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1)
>> +                     return !printf(_("We are not bisecting.\n"));
>> +             strbuf_rtrim(&branch);
>> +     } else {
>> +             struct object_id oid;
>> +
>> +             if (get_oid_commit(commit, &oid))
>> +                     return error(_("'%s' is not a valid commit"), commit);
>> +             strbuf_addstr(&branch, commit);
>
> The original checks "test -s BISECT_START" and complains, even when
> an explicit commit is given.  With this change, when the user is not
> bisecting, giving "git bisect reset master" goes ahead---it is
> likely that BISECT_HEAD does not exist and we may hit "Could not
> check out" error, but if BISECT_HEAD is left behind from a previous
> run (which is likely completely unrelated to whatever the user
> currently is doing), we'd end up doing quite a random thing, no?

Yes. Thanks for mentioning this point. I don't quite remember things
right now about what made me do this change. There might have been
something which had made me do this change because this isn't just a
silly mistake. Any which ways, I couldn't recollect the reason (should
be more careful to put code comments).

>> +     }
>> +
>> +     if (!file_exists(git_path_bisect_head())) {
>> +             struct argv_array argv = ARGV_ARRAY_INIT;
>> +
>> +             argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
>> +             if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
>> +                     error(_("Could not check out original HEAD '%s'. Try "
>> +                             "'git bisect reset <commit>'."), branch.buf);
>> +                     strbuf_release(&branch);
>> +                     argv_array_clear(&argv);
>> +                     return -1;
>
> How does this return value affect the value eventually given to
> exit(3), called by somewhere in git.c that called this function?
>
> The call graph would be
>
>     common-main.c::main()
>     -> git.c::cmd_main()
>        -> handle_builtin()
>           . exit(run_builtin())
>           -> run_builtin()
>              . status = p->fn()
>              -> cmd_bisect__helper()
>                 . return bisect_reset()
>                 -> bisect_reset()
>                    . return -1
>              . if (status) return status;
>
> So the -1 is returned throughout the callchain and exit(3) ends up
> getting it---which is not quite right.  We shouldn't be giving
> negative value to exit(3).  bisect_clean_state() and other helper
> functions may already share the same issue.

I had totally missed that exit() takes only single byte value and thus
only positive integers. I think changing it to "return 1;" will do.
There are a few places in the previous series which use "return -1;"
which would need to be changed. I will resend that series.

>> +             }
>> +             argv_array_clear(&argv);
>> +     }
>> +
>> +     strbuf_release(&branch);
>> +     return bisect_clean_state();
>> +}

Regards,
Pranit Bauva
