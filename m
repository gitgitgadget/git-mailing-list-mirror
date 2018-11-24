Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4341F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 19:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbeKYGWt (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 01:22:49 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:38468 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbeKYGWs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 01:22:48 -0500
Received: by mail-ed1-f49.google.com with SMTP id h50so12700985ede.5
        for <git@vger.kernel.org>; Sat, 24 Nov 2018 11:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uYkeXGHchh+wwm7yCqBVXxgzc+dHPDAK9VTAw0W8kUc=;
        b=sOZQ6OKYf9OJ0KRle86+0Xsm3vN+aPv9djV5dycP9IOT5OeGD7hFCLfcQ/vcbTBd25
         I3KVmqlADn26il2wsGumro2Hv3OFIsEMUUsAK3+vuoHaM5Ztc28OCKv2xHqVKSitjYef
         SoY76UL7jem6pSlZZbcGej7o1ea+MkG+D17g6aimwL6sbFaT7FkXGwVKFFyLUYHTnNTz
         VFi2OAg0s4b5DeiHHlJE/J1YgGbjAigNUnvWTk+3lKMVLUPhw88b4B5bV/bpyYLDym5y
         7qtIEmkQtDoDZzCsjvGRcQOPA42+74T67NMoaH/VjXEm6UuFJG3pwI7hGHTYDwS7xBeN
         s4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=uYkeXGHchh+wwm7yCqBVXxgzc+dHPDAK9VTAw0W8kUc=;
        b=GP/BfAeMTygPFSl4GuZ2FbMAi0xchjW3vLAOc/PVPywVUqc8wCDl25c/4qY3sZXiww
         6i9b7dznD9u/oSVxtzFMq7mqcvOZqDClYIYQGveaHRRho1i0lj9Hwy6BUNzxutuLiAzu
         RNF7WQ4r7f2W0PK3x7bQ5clfUTGx2l1rAn0qUNGQ5coIE7RSMu3HFgRXg+TEgZJeTDMc
         n4F8O+CDx8mTwB17DinsTxj199iLocY7nWXlenuaDciLmeXWabMtKO2KCT7odGSxbmEH
         4vVqUC3eDajs+YbO1kShV0xMHZgArVIX/afXD85DuOC13sQKpoA2cLmqN713tJOrJgrj
         jKgQ==
X-Gm-Message-State: AGRZ1gLAcH57xr+SUZU6lehxWSQ+nsL1BO4OVUQE6PJsWYzIgeDOoaJc
        R3sf3w/l0LyExY0tnKvkfA0efav6
X-Google-Smtp-Source: AJdET5ekL7sRAVnH+O+0BRHQCCCGkhWAVZrBzP4sFRWaL4H5qe30Awssci9LplFvmfKpFhykLUXMHQ==
X-Received: by 2002:a17:906:c5a:: with SMTP id t26-v6mr15635562ejf.140.1543088019143;
        Sat, 24 Nov 2018 11:33:39 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id s3sm13593450edm.31.2018.11.24.11.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Nov 2018 11:33:38 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #01; Tue, 4)
References: <20180824152016.20286-5-avarab@gmail.com> <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com> <87bm9cs5y6.fsf@evledraar.gmail.com> <CAPig+cRrwW662Hzp8V1sH51x8qYxPyqG=VHpOkfd-=RwUSSZbw@mail.gmail.com> <877ek0rymz.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <877ek0rymz.fsf@evledraar.gmail.com>
Date:   Sat, 24 Nov 2018 20:33:37 +0100
Message-ID: <878t1i1d9q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 05 2018, Ævar Arnfjörð Bjarmason wrote:

> On Wed, Sep 05 2018, Eric Sunshine wrote:
>
>> On Wed, Sep 5, 2018 at 4:29 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>>> I recently gained access to a Solaris 10 SPARC (5.10) box and discovered
>>> that the chainlint.sed implementation in 2.19.0 has more sed portability
>>> issues.
>>>
>>> First, whoever implemented the /bin/sed on Solaris apparently read the
>>> POSIX requirements for a max length label of 8 to mean that 8 characters
>>> should include the colon, so a bunch of things fail because of that, but
>>> are fixed with a shorter 7 character label.
>>
>> I'm pretty sure that Solaris 'sed' predates POSIX by a good bit, but
>> that's neither here nor there.
>>
>>> Then GIT_TEST_CHAIN_LINT=1 still fails because 878f988350 ("t/test-lib:
>>> teach --chain-lint to detect broken &&-chains in subshells", 2018-07-11)
>>> added a "grep -q" invocation. The /bin/grep on that version of Solaris
>>> doesn't have -q.
>>
>> I knew that '-q' was potentially problematic on some platforms, so I
>> checked and saw that existing tests were already using it, thus went
>> ahead and used it. Dropping '-q' here and redirecting stderr to
>> /dev/null is a perfectly fine alternative.
>>
>>> We fixed a similar issue way back in 80700fde91
>>> ("t/t1304: make a second colon optional in the mask ACL check",
>>> 2010-03-15) by redirecting to /dev/null instead.
>>>
>>> A bunch of other tests in the test suite rely on "grep -q", but nothing
>>> as central as chainlint, so it makes everything break. Do we want to
>>> away with "grep -q" entirely because of old Solaris /bin/grep?
>>
>> I count 132 instances in existing tests (though, I may have missed some).
>>
>>> At this point those familiar with Solaris are screaming ("why are you
>>> using anything in /bin!"). Okey fine, but it mostly worked before, so
>>> are we OK with breaking it? "Mostly" here is "test suite would fail
>>> 20-30 tests for various reasons, but at least no failures in test-lib.sh
>>> and the like".
>>>
>>> However, if as config.mak.uname does we run the tests with
>>> PATH=/usr/xpg6/bin:/usr/xpg4/bin:$PATH, at this point sed is fine with 8
>>> character labels [...]
>>
>> So, if you run the tests via 'make test' (or whatever), then you get
>> /usr/xpg?/bin in PATH, but if you run an individual test script (and
>> haven't set your PATH appropriately), then you encounter the problems
>> you report above?
>
> You need to manually set the PATH before running the tests, the
> SANE_TOOL_PATH just affects git-sh-setup. We should probably fix that,
> i.e. now if you compile git our shellscripts will use the fixed paths,
> but not the tests.
>
>>> [...] but starts complaining about this (also in
>>> chainlint.sed):
>>>
>>>     sed: Too many commands, last: s/\n//
>>
>> Erm. Any additional context to help narrow this down?
>
> I tried playing around with it a bit, but honestly don't understand
> enough of this advanced sed syntax to make any headway, it's complaining
> about e.g. the "check for multi-line double-quoted string" rule, but
> then if you remove the s/\n// from there it complains about the next
> rule in that format.
>
> If you want to dig into this yourself I think the best way forward is
> the last two paragraphs of
> https://public-inbox.org/git/20180824152016.20286-1-avarab@gmail.com/
>
>>>     diff --git a/config.mak.uname b/config.mak.uname
>>>     @@ -163,6 +163,10 @@ ifeq ($(uname_S),SunOS)
>>>             BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__
>>>     +       # t/chainlint.sed is hopelessly broken all known (tested
>>>     +       # Solaris 10 & 11) versions of Solaris, both /bin/sed and
>>>     +       # /usr/xpg4/bin/sed
>>>     +       GIT_TEST_CHAIN_LINT = 0
>>>      endif
>>>
>>> It slightly sucks to not have chainlint on
>>> Solaris, but it would also suck to revert chainlint.sed back to 2.18.0
>>> (there were some big improvements). So I think the patch above is the
>>> best way forward, especially since we're on rc2. What do you think?
>>
>> Keeping in mind that the main goal of 'chainlint' is to prevent _new_
>> breakage from entering the test suite, disabling 'chainlint' on
>> Solaris is an entirely reasonable way forward. In present day, it
>> seems quite unlikely that we'll see someone develop new tests on
>> Solaris, so having 'chainlint' disabled there isn't likely to be a big
>> deal. Moreover, if someone does write a new test on Solaris which has
>> a broken &&-chain in a subshell, that breakage will be caught very
>> quickly once the test is run by anyone on Linux or MacOS (or Windows
>> or BSD or AIX), so it's not like the broken test will make it into the
>> project undetected.
>
> Since writing my initial message I see that the CSW package packaging
> git on Solaris just uses GNU userland:
> https://sourceforge.net/p/gar/code/HEAD/tree/csw/mgar/pkg/git/trunk/Makefile
>
> I.e. it puts /opt/csw/gnu in its $PATH, so this whole thing is probably
> a non-issue. I.e. if the near-as-you-can-get "official" package just
> compiles git against GNU tooling, perhaps we should stop caring about
> Solaris-native tooling.
>
> That does also mean that something like my patch above isn't OK, since
> we shouldn't be disabling GIT_TEST_CHAIN_LINT based on the uname, if it
> then turns out that GNU tooling is being used.
>
> So I think for the purposes of v2.19.0-rc2..v2.19.0 it's fine to just
> leave this as it is in master right now.
>
> It's somewhat of a shame that we're drifting to not supporing some of
> these more obscure POSIX systems "natively" though, but maybe that's the
> right move at this point, and maybe it isn't.
>
> When I was porting C code to Solaris ~10 years ago I'd often get SunCC
> turning up some interesting issues that were *real* issues, same with
> compiling with IBM xlc on AIX.
>
> Now when I'm re-visiting these systems much later I've yet to turn up
> some issue like that, just boring compatibility issues with their old
> tooling. E.g. one outstanding issue is that some test of ours fail on
> AIX because we use "readlink", but that command isn't in POSIX (only the
> C function is), so AIX doesn't implement it.
>
> SunCC used to be ahead of GCC & Clang when it came to certain classes of
> warnings, but e.g. now everything it complains about is because it
> doesn't understand C as well, e.g. we have quite a few compile warnings
> due to code like this, which it claims is unreachable (but isn't):
> https://github.com/git/git/blob/v2.19.0-rc2/read-cache.c#L950-L955

Correction. It is still useful for something:
https://public-inbox.org/git/87a7ly1djb.fsf@evledraar.gmail.com/
