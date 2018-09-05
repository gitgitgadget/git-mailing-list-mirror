Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAC971F404
	for <e@80x24.org>; Wed,  5 Sep 2018 08:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbeIEM6b (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 08:58:31 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:44969 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIEM6a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 08:58:30 -0400
Received: by mail-ed1-f53.google.com with SMTP id s10-v6so5359422edb.11
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 01:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=CvtVna5pBvrVkB/LjZXTGUIwFo6Bj73LWcBhR8bW6B0=;
        b=tmyLAqqZVaw914VdkVZ3xj715X5mMVAxU9zSzvC2nGjyU/GOyVLWuqLvKyZYg65Ndm
         Y5Owjn7M/atj5VEfy6Ke6V/TE7rINA0MXJeLc5rVVtiBFyYHsnSikCH105lwNNRBAZfm
         z+cwoEJvt+xbO8srzXqwlQS81/uqbqkA21cScXR4IrvCK4Zju7zSLQzJ0yTdolWNbhzW
         eKoHvFhyKBqzIKA207PpWfd6/qbd9s97ls+Jx4E83XtLSB12QBxZBSrMmD/kD8olXRdR
         DgGKcyE2R2lPFKNuaSi1figjJoxwJnrAIleGoCPpznG9WSI8MF3SuwfE9tBhs3+nFfmD
         3RyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=CvtVna5pBvrVkB/LjZXTGUIwFo6Bj73LWcBhR8bW6B0=;
        b=tPBiJhy62udh5FJlBxY0nqob3BKkzpnvTtDAob8S5vy3B3WNWyyWb89BU0gvaSiUbo
         AFG3QUoWGby6d3yRx4Tje+mVuvXzVYCr/pZ+/EHl2YTBZmLUL7SiwWOzSfT1mUZvQytr
         V0KK3l8MJ0+kQFpUCaZwqrtEW57cOWjOfUVCefZSyTXJsWRLhYwiymBRx34dy7VuskJI
         YChblEPTmKCpm5sKUIODc0ifKCuqNoW2AR6QzHG01oxA7wKTZqzCRGGmZZYUX4lcz2S5
         yhOUNwPncg2HNIZI7UWZCIGb9cPb+XLBvMW67dQqokK+km1dkulZBXc+bYLGRLyJF8qB
         zgDQ==
X-Gm-Message-State: APzg51CO9xMbJO3wMYHfEfJLKWI8noLLf1GROtq5JoWWPgC8tnjzXqIa
        MVJ+AyTVhU5NpgFr/DoYgFo=
X-Google-Smtp-Source: ANB0VdYiGoA4rwMF1RRZD3oDekz5kNzs64ndyE3Fl6qOnLim8lr7eQ4hrac/FM4+qNUKe4sRpwSa3A==
X-Received: by 2002:a50:8322:: with SMTP id 31-v6mr41691439edh.122.1536136163028;
        Wed, 05 Sep 2018 01:29:23 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id b20-v6sm986090edc.30.2018.09.05.01.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 01:29:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #01; Tue, 4)
References: <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
        <20180824152016.20286-5-avarab@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 05 Sep 2018 10:29:21 +0200
Message-ID: <87bm9cs5y6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 04 2018, Junio C Hamano wrote:

> Git 2.19-rc2 is out.  Hopefully the tip of 'master' is more or less
> identical to the final one without needing much updates.
>
> You can find the changes described here in the integration branches
> of the repositories listed at
>
>     http://git-blame.blogspot.com/p/git-public-repositories.html
>
> --------------------------------------------------
> [Graduated to "master"]
>
> * ab/portable (2018-08-27) 6 commits
>   (merged to 'next' on 2018-08-27 at 37640e66ef)
>  + tests: fix and add lint for non-portable grep --file
>  + tests: fix version-specific portability issue in Perl JSON
>  + tests: use shorter labels in chainlint.sed for AIX sed
>  + tests: fix comment syntax in chainlint.sed for AIX sed
>  + tests: fix and add lint for non-portable seq
>  + tests: fix and add lint for non-portable head -c N
>  (this branch is used by ab/portable-more.)

I recently gained access to a Solaris 10 SPARC (5.10) box and discovered
that the chainlint.sed implementation in 2.19.0 has more sed portability
issues.

First, whoever implemented the /bin/sed on Solaris apparently read the
POSIX requirements for a max length label of 8 to mean that 8 characters
should include the colon, so a bunch of things fail because of that, but
are fixed with a shorter 7 character label.

Then GIT_TEST_CHAIN_LINT=1 still fails because 878f988350 ("t/test-lib:
teach --chain-lint to detect broken &&-chains in subshells", 2018-07-11)
added a "grep -q" invocation. The /bin/grep on that version of Solaris
doesn't have -q. We fixed a similar issue way back in 80700fde91
("t/t1304: make a second colon optional in the mask ACL check",
2010-03-15) by redirecting to /dev/null instead.

A bunch of other tests in the test suite rely on "grep -q", but nothing
as central as chainlint, so it makes everything break. Do we want to
away with "grep -q" entirely because of old Solaris /bin/grep?

At this point those familiar with Solaris are screaming ("why are you
using anything in /bin!"). Okey fine, but it mostly worked before, so
are we OK with breaking it? "Mostly" here is "test suite would fail
20-30 tests for various reasons, but at least no failures in test-lib.sh
and the like".

However, if as config.mak.uname does we run the tests with
PATH=/usr/xpg6/bin:/usr/xpg4/bin:$PATH, at this point sed is fine with 8
character labels, but starts complaining about this (also in
chainlint.sed):

    sed: Too many commands, last: s/\n//

As with other sed issues I fixed recently in chainlint.sed this one is
just the tip of the iceberg. Once you "fix" one (just remove it, I have
no idea how to rewrite it) others appear.

I was hoping this would just be a Solaris 10 issue, but it's also an
issue in Solaris 11 (5.11 11.3).

So, do we want to chase this down or just do this?:

    diff --git a/Makefile b/Makefile
    index 5a969f5..f125dc5 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -2602,6 +2602,9 @@ endif
     ifdef TEST_GIT_INDEX_VERSION
            @echo TEST_GIT_INDEX_VERSION=\''$(subst ','\'',$(subst ','\'',$(TEST_GIT_INDEX_VERSION)))'\' >>$@+
     endif
    +ifdef GIT_TEST_CHAIN_LINT
    +       @echo GIT_TEST_CHAIN_LINT=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_CHAIN_LINT)))'\' >>$@+
    +endif
            @if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi

     ### Detect Python interpreter path changes
    diff --git a/config.mak.uname b/config.mak.uname
    index e47af72..2b02a2b 100644
    --- a/config.mak.uname
    +++ b/config.mak.uname
    @@ -163,6 +163,10 @@ ifeq ($(uname_S),SunOS)
            INSTALL = /usr/ucb/install
            TAR = gtar
            BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__
    +       # t/chainlint.sed is hopelessly broken all known (tested
    +       # Solaris 10 & 11) versions of Solaris, both /bin/sed and
    +       # /usr/xpg4/bin/sed
    +       GIT_TEST_CHAIN_LINT = 0
     endif
     ifeq ($(uname_O),Cygwin)
            ifeq ($(shell expr "$(uname_R)" : '1\.[1-6]\.'),4)

If I could wave a magic wand I'd say "let's just rewrite chainlint.sed
in perl, at least that's portable", but that's a lot of effort (and I
doubt Eric wants to). It slightly sucks to not have chainlint on
Solaris, but it would also suck to revert chainlint.sed back to 2.18.0
(there were some big improvements). So I think the patch above is the
best way forward, especially since we're on rc2. What do you think?
