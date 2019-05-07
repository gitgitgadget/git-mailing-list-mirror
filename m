Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 547D61F488
	for <e@80x24.org>; Tue,  7 May 2019 14:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEGO6x (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 10:58:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40169 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGO6x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 10:58:53 -0400
Received: by mail-io1-f65.google.com with SMTP id s20so4782317ioj.7
        for <git@vger.kernel.org>; Tue, 07 May 2019 07:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8CN5L1S3F80CE1PHtICLaNKX8kky6widEEkkANkHVR0=;
        b=nZ/maVfqoUCZ7c3+8+oXfdsBNhfdA6TLrNBcRP8NlTOeGxZk7zt6MSTN8rKyvEA+tY
         ZXZWSEbrhJnPyigw1hHKqfuDbhP5ZsnhkPGx1RacDFUNiMcFbLdcKW0J5U+togThvi9u
         7yB6SEhH+2eLEMMsAN1RLmTqeLA3MZRsiEeFpLJZkwD8uwP8rULByxLFty/twRaVdYyL
         bcdydGVYCuQWyJ2q1J1DzqjauHGL8Yd/0/AG7AHTK6Db8qlJLGKvXOwPegYiw8gEgczm
         whbzN8kkvI0XwVl7i3yZCLldurrvys1g3XROluy97BVjwKuci5tH2g3b6Quf6WgBuV23
         Fv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8CN5L1S3F80CE1PHtICLaNKX8kky6widEEkkANkHVR0=;
        b=Kv8X7kGRZ7U/XWrugQFLTjGrAwawxucP93Ttu46QeZViD9VvmFFkDg5voyaFZpGrX+
         HCsxx+ifrhtFZuMSlm43/WllM+dt1A9dpTxrXyo8jA/lgIlmv5aUWUrb7vg6SbpSWzsb
         uPo/84B0xCMEKjLuIqOCuJfhJ9CAkel6T+JFSH+GxIWtrHtOHIAqm7ByaMPGkKFXnREQ
         UGlbAg6WveqjQxSKWGlVyrwHEgDzPVR8QtWDO4YjmcijMlUR+gklZuT2tyxmUD+pegvJ
         2B1v0jAnKhiT7IjsDjM/G6fvDSTp9J6S74DKtpPWVp5twRPsX6ndGzNB92MB7tB3aHNQ
         aOiQ==
X-Gm-Message-State: APjAAAWMvwJKVH4jCl0CwCjgZYv8rUV+1xQWMAV8EqZrIcaW7IrTDHAJ
        WPQHuGTIc1yNFwdbBuqfhvU=
X-Google-Smtp-Source: APXvYqywck9mzJiHvLAm0puweXXxV8xygR9K38sN6C+jVAEXi1gVd4C0XKLawATVrMwH+7HaT9NIPg==
X-Received: by 2002:a6b:f305:: with SMTP id m5mr14584610ioh.271.1557241132181;
        Tue, 07 May 2019 07:58:52 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:780:ed13:bfd5:1bea:adb7])
        by smtp.gmail.com with ESMTPSA id 129sm5057041iow.32.2019.05.07.07.58.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 07:58:50 -0700 (PDT)
Date:   Tue, 7 May 2019 10:58:49 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@googlemail.com>,
        Git <git@vger.kernel.org>
Subject: Re: Merge commit diff results are confusing and inconsistent
Message-ID: <20190507145849.GA6313@archbookpro.localdomain>
References: <CAHd499BEHd79zL76um2oB4YMdScM2icrMXstg1g=xwdBqk43EQ@mail.gmail.com>
 <20190503191231.GA5426@esm>
 <CAHd499CUOnFVkNGEG-MmG5OsUPpmWHET2X1j1fjNuGUkELf-5w@mail.gmail.com>
 <874l67i1ie.fsf@evledraar.gmail.com>
 <CAHd499BkdpsA2BdB0Hsv3xXzpMyMzW8CSuYf2gQX0Jf7OoYBGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd499BkdpsA2BdB0Hsv3xXzpMyMzW8CSuYf2gQX0Jf7OoYBGw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robert,

On Tue, May 07, 2019 at 09:10:12AM -0500, Robert Dailey wrote:

[snip]

> Even ignoring that issue, the more concerning observation of mine is
> that `diff @^!` produces any output at all. If you exclude both
> parents, why do I see a diff for parent 2 (I see the complete diff of
> the branch that was merged in)?
> 
> Again, thank you for your example, you definitely made things very
> clear for me. I see where the confusion is. And I think --cc is a good
> way to get more context. At this point I'm just concerned about the
> @^! behavior with merge commits & diff.

@^! is undocumented behaviour. Junio touched on why it behaves this way
here[1], in case you're interested.

For more details, this code[2] just blindly diffs the first two
endpoints returned preceding `repo_init_revisions`.

Also, not to rehash an old discussion but I'll let this thread be my
argument *against* allowing range-notation in git-diff.

[1]: https://public-inbox.org/git/xmqqef7ch80v.fsf@gitster-ct.c.googlers.com/
[2]: https://github.com/gitster/git/blob/master/builtin/diff.c#L385
