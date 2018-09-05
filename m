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
	by dcvr.yhbt.net (Postfix) with ESMTP id 699581F404
	for <e@80x24.org>; Wed,  5 Sep 2018 11:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeIEPhF (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 11:37:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36233 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeIEPhE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 11:37:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id m27-v6so7222142wrf.3
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 04:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vlzETZUF4/Jqt3NGUOYgOwPIKzXBoMdwT0vgOwyth+g=;
        b=VOfP9XkV5E50K8qn/kMvmskp2MJK4ETemNfENtEW34R2BCVDf7LL1JSiXfyPOPwr33
         SVHToe5yS9z+ennTf9rGmPkTTfJk0bXA8adS8hrAomtXwogZncFHWxY6VL2sTbWjeeWM
         7DhjVQ4uuywHEkbTPO8V+78VyDjWtRWYAhnQnEIL2c0/CPqLf21giLFsEqvxKhANJhWr
         SCvQIwbH9BksuTJDWAL6u0pmhpSlzkg1a8KMHfbmJzHl0Nj+SSyIR/Gi+OX4WRwKuCsR
         g0ywMLMq1fbaH8On1+jUz1X0XkRKte1UBmZPrgHQzfMfvI7U6+xSjcV1CCFwRz56uNKq
         RH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=vlzETZUF4/Jqt3NGUOYgOwPIKzXBoMdwT0vgOwyth+g=;
        b=jSN/3oxmz0u/uHWlRxKElruXwyXb+MPVY7+wBO0Jpy3A5RNUxzAm00zB3YbURpJ0nW
         Udxs8MWWmXrx1X68fS9nDBoOp0gFeKidi/WPdFdwRlUxHSC4IU1cNKu+2cgcsWnBfAk/
         Jux8M6UygnC40T1pXpV5KhoV0CYpmBeGjHsiV4FgAlNZAlAB2o5IPXPiqGtYbR+muNOB
         zSsPA5FoSyzRe2zR8x+d8pmPMY/aR7+Ckv24JXEwl9+N5+i7G1HFwdKiYDF8gPVzm5v0
         1Bau0p/fy2Wgqhsday9xKNomMXARRzWFMRvPFHZvIP7WeVy7vaiRcTyTPFQwt7RVhFjE
         ubOQ==
X-Gm-Message-State: APzg51CGzmkNK6d7HZaG/CT5uIhsPqe3F04GbrtG+K9Fs2S5yH0aFQGG
        HNCwY6FBR0WMN7mxhPWUAJQ=
X-Google-Smtp-Source: ANB0VdaDABvyCJJiUYQpdUTGDrK98n2yRyFMcSc5G6/zn6onqih0V6Gn+OjNUDbNYJ55CpJ4Fh4AXg==
X-Received: by 2002:adf:f391:: with SMTP id m17-v6mr13245821wro.279.1536145638798;
        Wed, 05 Sep 2018 04:07:18 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id o19-v6sm1857651wro.50.2018.09.05.04.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 04:07:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #01; Tue, 4)
References: <20180824152016.20286-5-avarab@gmail.com>
        <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
        <87bm9cs5y6.fsf@evledraar.gmail.com>
        <CAPig+cRrwW662Hzp8V1sH51x8qYxPyqG=VHpOkfd-=RwUSSZbw@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAPig+cRrwW662Hzp8V1sH51x8qYxPyqG=VHpOkfd-=RwUSSZbw@mail.gmail.com>
Date:   Wed, 05 Sep 2018 13:07:16 +0200
Message-ID: <877ek0rymz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 05 2018, Eric Sunshine wrote:

> On Wed, Sep 5, 2018 at 4:29 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> I recently gained access to a Solaris 10 SPARC (5.10) box and discovered
>> that the chainlint.sed implementation in 2.19.0 has more sed portability
>> issues.
>>
>> First, whoever implemented the /bin/sed on Solaris apparently read the
>> POSIX requirements for a max length label of 8 to mean that 8 characters
>> should include the colon, so a bunch of things fail because of that, but
>> are fixed with a shorter 7 character label.
>
> I'm pretty sure that Solaris 'sed' predates POSIX by a good bit, but
> that's neither here nor there.
>
>> Then GIT_TEST_CHAIN_LINT=1 still fails because 878f988350 ("t/test-lib:
>> teach --chain-lint to detect broken &&-chains in subshells", 2018-07-11)
>> added a "grep -q" invocation. The /bin/grep on that version of Solaris
>> doesn't have -q.
>
> I knew that '-q' was potentially problematic on some platforms, so I
> checked and saw that existing tests were already using it, thus went
> ahead and used it. Dropping '-q' here and redirecting stderr to
> /dev/null is a perfectly fine alternative.
>
>> We fixed a similar issue way back in 80700fde91
>> ("t/t1304: make a second colon optional in the mask ACL check",
>> 2010-03-15) by redirecting to /dev/null instead.
>>
>> A bunch of other tests in the test suite rely on "grep -q", but nothing
>> as central as chainlint, so it makes everything break. Do we want to
>> away with "grep -q" entirely because of old Solaris /bin/grep?
>
> I count 132 instances in existing tests (though, I may have missed some).
>
>> At this point those familiar with Solaris are screaming ("why are you
>> using anything in /bin!"). Okey fine, but it mostly worked before, so
>> are we OK with breaking it? "Mostly" here is "test suite would fail
>> 20-30 tests for various reasons, but at least no failures in test-lib.sh
>> and the like".
>>
>> However, if as config.mak.uname does we run the tests with
>> PATH=/usr/xpg6/bin:/usr/xpg4/bin:$PATH, at this point sed is fine with 8
>> character labels [...]
>
> So, if you run the tests via 'make test' (or whatever), then you get
> /usr/xpg?/bin in PATH, but if you run an individual test script (and
> haven't set your PATH appropriately), then you encounter the problems
> you report above?

You need to manually set the PATH before running the tests, the
SANE_TOOL_PATH just affects git-sh-setup. We should probably fix that,
i.e. now if you compile git our shellscripts will use the fixed paths,
but not the tests.

>> [...] but starts complaining about this (also in
>> chainlint.sed):
>>
>>     sed: Too many commands, last: s/\n//
>
> Erm. Any additional context to help narrow this down?

I tried playing around with it a bit, but honestly don't understand
enough of this advanced sed syntax to make any headway, it's complaining
about e.g. the "check for multi-line double-quoted string" rule, but
then if you remove the s/\n// from there it complains about the next
rule in that format.

If you want to dig into this yourself I think the best way forward is
the last two paragraphs of
https://public-inbox.org/git/20180824152016.20286-1-avarab@gmail.com/

>>     diff --git a/config.mak.uname b/config.mak.uname
>>     @@ -163,6 +163,10 @@ ifeq ($(uname_S),SunOS)
>>             BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__
>>     +       # t/chainlint.sed is hopelessly broken all known (tested
>>     +       # Solaris 10 & 11) versions of Solaris, both /bin/sed and
>>     +       # /usr/xpg4/bin/sed
>>     +       GIT_TEST_CHAIN_LINT = 0
>>      endif
>>
>> It slightly sucks to not have chainlint on
>> Solaris, but it would also suck to revert chainlint.sed back to 2.18.0
>> (there were some big improvements). So I think the patch above is the
>> best way forward, especially since we're on rc2. What do you think?
>
> Keeping in mind that the main goal of 'chainlint' is to prevent _new_
> breakage from entering the test suite, disabling 'chainlint' on
> Solaris is an entirely reasonable way forward. In present day, it
> seems quite unlikely that we'll see someone develop new tests on
> Solaris, so having 'chainlint' disabled there isn't likely to be a big
> deal. Moreover, if someone does write a new test on Solaris which has
> a broken &&-chain in a subshell, that breakage will be caught very
> quickly once the test is run by anyone on Linux or MacOS (or Windows
> or BSD or AIX), so it's not like the broken test will make it into the
> project undetected.

Since writing my initial message I see that the CSW package packaging
git on Solaris just uses GNU userland:
https://sourceforge.net/p/gar/code/HEAD/tree/csw/mgar/pkg/git/trunk/Makefile

I.e. it puts /opt/csw/gnu in its $PATH, so this whole thing is probably
a non-issue. I.e. if the near-as-you-can-get "official" package just
compiles git against GNU tooling, perhaps we should stop caring about
Solaris-native tooling.

That does also mean that something like my patch above isn't OK, since
we shouldn't be disabling GIT_TEST_CHAIN_LINT based on the uname, if it
then turns out that GNU tooling is being used.

So I think for the purposes of v2.19.0-rc2..v2.19.0 it's fine to just
leave this as it is in master right now.

It's somewhat of a shame that we're drifting to not supporing some of
these more obscure POSIX systems "natively" though, but maybe that's the
right move at this point, and maybe it isn't.

When I was porting C code to Solaris ~10 years ago I'd often get SunCC
turning up some interesting issues that were *real* issues, same with
compiling with IBM xlc on AIX.

Now when I'm re-visiting these systems much later I've yet to turn up
some issue like that, just boring compatibility issues with their old
tooling. E.g. one outstanding issue is that some test of ours fail on
AIX because we use "readlink", but that command isn't in POSIX (only the
C function is), so AIX doesn't implement it.

SunCC used to be ahead of GCC & Clang when it came to certain classes of
warnings, but e.g. now everything it complains about is because it
doesn't understand C as well, e.g. we have quite a few compile warnings
due to code like this, which it claims is unreachable (but isn't):
https://github.com/git/git/blob/v2.19.0-rc2/read-cache.c#L950-L955
