Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6996E1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 12:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbfA3MwK (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 07:52:10 -0500
Received: from mout.gmx.net ([212.227.17.21]:52707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfA3MwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 07:52:09 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzGV3-1hAUtG1RMv-014R7K; Wed, 30
 Jan 2019 13:51:55 +0100
Date:   Wed, 30 Jan 2019 13:51:37 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH (Apple Git) 02/13] test-lib: Export PERL5LIB for testing
 git-svn
In-Reply-To: <09281A61-1EDA-4226-AD59-6A97EDF1B1DB@apple.com>
Message-ID: <nycvar.QRO.7.76.6.1901301344430.41@tvgsbejvaqbjf.bet>
References: <20190129193818.8645-1-jeremyhu@apple.com> <20190129193818.8645-3-jeremyhu@apple.com> <xmqq1s4v6pzm.fsf@gitster-ct.c.googlers.com> <09281A61-1EDA-4226-AD59-6A97EDF1B1DB@apple.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GYsgNRLsjCSVDL7LLdcDc/wMl+3/5sUAH5ZUx/ZrQHnACzC1vlU
 +HDPUxnPmfC0k5g4n3x394XFy/hckHU92sul2MUF8XdaBTvBcN/inYkVuPawm+QN5a34jzH
 JUcIIPsf0863z3jgmNEAAm4oKW4UluX0E7HT0ATn9blDSUKBxXDrFMiDhqdVhnh29Zl4/OZ
 1Ut/Zsg40YvWcSM4v+pnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MHE/EGWGffI=:pEdaQ3OQGltDnkezN2jfGU
 nLojDZaYoPdOogWCWLecATMJ2UruT4tXyHYZDbF1gTKlHzRKtl/GK5Xi3qp0lESBHNBc6pS63
 JVxc7HRvYZb7QAJaQO7aSHNXPIDb2ZjRcnni39yHFuxvtL7rCl6dSCu4rrZIjT3SeAJwnUUL2
 fgWdCTejbnCK6Yg5DIum5YZ3rtp4u3oVqaDm4DzvrfrQE2H8p8CGkKbp4K9ukAaA/jLdj3JBl
 vV4cN+8cuoYnHv82O+Wb1x45qKnl2R3rvbRuJNpqpFj/IgKYTZIaxlZ21z9rUybh7rfL6XSHX
 yJCmCqhiYJj5+Z8FDItZqG2ccYmEdGO1Zp6vl2nrOvYX2Mqh0As/m477Yc23drRUiiyT6RfRP
 gGmcUHOon07uREFYl9S3ul0fj0oS5UXsHlfi/jtz5u8dL3M/hmvgsZCcNFC7M8aN5YagW9U48
 02wRnhJXiiYUADPn9bUeHbKzW1vFfiWav69vXq+mgfE8ZQY0J3hYU8xz39Xnt76+BSHpO1zAX
 3K1vXsOfoKV8kfc6FsJk8iywBkktO8CmB3Kr1i1byzUYeZnxOXKYJTtC/f3bA+Tml3avGLfT3
 2s1po3SpW0+wfBeqpyfDoBWLhZFfNcsJOs0XtwKda9DmdXQ+RI7mX/d6Py4z0Hi/9uasEnAbY
 D1bk23G63kgUXnhpdkMw8Q3KePst+kgrLIqAa0l5bCGvsDqXhm8XRE9UrpkuqZqEAaQE6ENWB
 sywEpkxa4vBVouU5sJ5UaqY3rfeTjR13xZsdPDsTDwVS/4tE/VLvTCE6PXa9mzQs0J9jLhXrB
 DaBTV+4ovcAWIEgzke6OD6nGk92vuVSgbl5DiuAXPZTNuJeIcx4KN0IvR4MKINunHsGdVJzow
 mE77ajPCzzbgbGSHLwydZzD7ugzzfgxHQUj05Elokv7Yn+FJUP7SfqpYQbOhTuwwy362B5+Qr
 njKGW12yqCA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeremy,

On Tue, 29 Jan 2019, Jeremy Huddleston Sequoia wrote:

> > On Jan 29, 2019, at 2:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:
> > 
> >> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> >> ---
> >> t/test-lib.sh | 3 +++
> >> 1 file changed, 3 insertions(+)
> > 
> > This obviously won't be acceptable as-is to my tree.  Shouldn't this
> > be something to be dealt with in config.mak.uname or something that
> > is meant to define platform-specific customization?
> 
> The issue here is that we're not locating relocatable perl modules
> during testing.  This is a general problem with testing RUNTIME_PREFIX
> configurations, and a more general solution to this sledgehammer would
> be appropriate.  I don't think config.mak.uname really makes sense since
> it's a general RUNTIME_PREFIX issue and not specifically a darwin issue.

First of all, as others have pointed out, this code is very, very specific
to Darwin (not only xcode-select but also Library/Perl/ are very, very
specific to that platform, I would even argue it is not even
Darwin-specific but instead macOS specific because bare-bones Darwin does
not have Library/Perl/, does it?).

So you *definitely* want to put that code into guards testing for that
platform (I do not think config.mak.uname is the correct place, though, as
it should be accessible to test scripts when run directly, i.e. not
through `make`).

But let's take a huge step back first: why? What is the exact problem this
commit tries to solve? The commit message unfortunately does not really
leave me any wiser.

So I am left with the unfortunate position of having to guess, which is
not really a good use of both of our time. If I allow myself to indulge in
the guessing game, I would guess that whatever `perl` executable is used
in your scenario picks up some unfortunate environment variable that
overrides its internal defaults where to look for Perl modules.

And that simply should not be the case. We are very careful to set
GITPERLLIB in bin-wrappers/, *not* PERL5LIB.

And when we build Git on macOS agents in Travis or Azure Pipelines and
then run the test suite, I fail to see any Perl-related error that looks
like it could be solved by this here patch.

In short: this commit is in dear want of a more substantive commit
message, and most likely in search for a different solution.

Ciao,
Johannes

> 
> > 
> >> 
> >> diff --git a/t/test-lib.sh b/t/test-lib.sh
> >> index 0f1faa24b2..4060a53f56 100644
> >> --- a/t/test-lib.sh
> >> +++ b/t/test-lib.sh
> >> @@ -1017,6 +1017,9 @@ fi
> >> 
> >> GITPERLLIB="$GIT_BUILD_DIR"/perl/build/lib
> >> export GITPERLLIB
> >> +PERL_VERSION=$(grep DEFAULT /usr/local/versioner/perl/versions | sed 's:^.*= *\([^ ]*\)$:\1:')
> >> +PERL5LIB="$GIT_BUILD_DIR"/perl:"$(xcode-select -p)"/Library/Perl/$PERL_VERSION
> >> +export PERL5LIB
> >> test -d "$GIT_BUILD_DIR"/templates/blt || {
> >> 	error "You haven't built things yet, have you?"
> >> }
> 
> 
