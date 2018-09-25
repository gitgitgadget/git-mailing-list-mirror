Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43AC91F453
	for <e@80x24.org>; Tue, 25 Sep 2018 04:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeIYKMA (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 06:12:00 -0400
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21798 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727079AbeIYKMA (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Sep 2018 06:12:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1537848387; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=gcRxD8JolyWecKnpNGx627fDQ0AWEtSG1pg/GRfARu5pjf8w3mAkQWkBfVrV1schesTyxm8MWb5o2AaeCZTAD6Uvd8ts87j4KKcTLXmvfFL4nJ8FwY+Vf2ccyzQgLLvD0LN0jkZ+S0tuzQXroSKnObiTY284cO+1o3foJgug7xw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1537848387; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=YNvdZ+VHoic7jFMbx35jUnmdAEeB7v78OM3Vyy+4Iqw=; 
        b=XZqrQAwUvw4pz7Yo4Edtd1GxcB79bhbNu5mKORjJ6BLojG9GQouVnaG+UJCtOLR0xYDBkXimMZZskk7YeDm9HSHWf16jfCjd8nwMh7SPR03ipa8NYo+86/fxgqFo4iS8seA9N4tY04lm06HwRk/2bO7evTT8rNu3BdtnzPbh0MQ=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=astrangergravity.com;
        spf=pass  smtp.mailfrom=john@astrangergravity.com;
        dmarc=pass header.from=<john@astrangergravity.com> header.from=<john@astrangergravity.com>
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44]) by mx.zohomail.com
        with SMTPS id 1537848385958951.023114144011; Mon, 24 Sep 2018 21:06:25 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id o21-v6so4847270lfe.0
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 21:06:25 -0700 (PDT)
X-Gm-Message-State: ABuFfohetj5by8yQIWKhDQeoFjm46JrMZhkRKHlYrjH01vscNg51Glbh
        sVBHhrY083K4vERIthTHuIAk5o6JZJbjjOaf9JI=
X-Google-Smtp-Source: ACcGV62zXEWhs6TeK9YbZmEZT+EK3RRy7n+4CH/C51ZIsBOl8bmStkvfXgmrTYOXZ1OSba1zT4d7KNId5ZOsetqmVao=
X-Received: by 2002:a19:124b:: with SMTP id h72-v6mr1047105lfi.72.1537848384228;
 Mon, 24 Sep 2018 21:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <878t41lcfi.fsf@evledraar.gmail.com> <20180917135525.GF71477@syl>
 <874leokw3p.fsf@evledraar.gmail.com> <20180917164705.GA28056@kitenet.net>
 <8736u8kpgu.fsf@evledraar.gmail.com> <CA+AhR6doYuwoucdcN9aKw7-HxgR-qa6OiN4Dnzcy5rifL8PYvg@mail.gmail.com>
 <000501d45366$cf437060$6dca5120$@nexbridge.com> <CA+AhR6c+D84sHhABRm4xf=5RWnpVEBXMXzdQxipYMS5bmkw9iQ@mail.gmail.com>
 <20180924140122.GC68796@syl> <CA+AhR6cyNqPW7YvEdanv_vA=T2oLrUm2ZyMZjLLFtdx8B+dqYQ@mail.gmail.com>
 <20180924195840.GG68796@syl>
In-Reply-To: <20180924195840.GG68796@syl>
From:   John Austin <john@astrangergravity.com>
Date:   Mon, 24 Sep 2018 21:05:56 -0700
X-Gmail-Original-Message-ID: <CA+AhR6dzOUeJ0MsAF1C9-aUUJ9v4i5uaPKzxHJAPy0ZUjYtyVA@mail.gmail.com>
Message-ID: <CA+AhR6dzOUeJ0MsAF1C9-aUUJ9v4i5uaPKzxHJAPy0ZUjYtyVA@mail.gmail.com>
Subject: Re: Git for games working group
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Randall Becker <rsbecker@nexbridge.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        id@joeyh.name, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        pastelmobilesuit@github.com
Content-Type: text/plain; charset="UTF-8"
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 12:58 PM Taylor Blau <me@ttaylorr.com> wrote:
> I'm replying to this part of the email to note that this would cause Git
> LFS to have to do some extra work, since running 'git lfs install'
> already writes to .git/hooks/post-commit (ironically, to detect and
> unlock locks that we should have released).

Right, that should have been another bullet point. The fact that there
can only be one git hook is.. frustrating.

Perhaps, if LFS has an option to bundle global-graph, LFS could merge
the hooks when installing?

If you instead install global-graph after LFS, I think it should
probably attempt something like:
  -- first move the existing hook to a folder: post-commit.d/
  -- install the global-graph hook to post-commit.d/
  -- install a new hook at post-commit that simply calls all
executables in post-commit.d/

Not sure if this is something that's been discussed, since I know LFS
has a similar issue with existing hooks, but might be sensible.

