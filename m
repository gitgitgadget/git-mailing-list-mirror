Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998AFC5519F
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 00:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C6E246D1
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 00:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GdBgoA1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgKSAYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 19:24:19 -0500
Received: from mout.gmx.net ([212.227.17.21]:50451 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbgKSAYS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 19:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605745453;
        bh=VDCNz+8wYEy5fXYd5PFJO3lSdj5TzwTkuhTFzf2v/F8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GdBgoA1BTmmRgDLGziElZ6Ss8H0SHpguN5pkNCoypCozEBwDEKniRPwMkHY5Zi4lz
         s57j7X7NIv8Bwpgaptn2sfs4ZZoM/ms8pmspvh7wtRW9NBTDeEU+6Hjwpqal97Y9fk
         9Up2wtyJUOSc8JQREWOfOS0ABEbtXwcqRo2nf3B8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hvb-1kEDcI2mwh-011nHq; Thu, 19
 Nov 2020 01:24:13 +0100
Date:   Thu, 19 Nov 2020 01:24:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1309: use a non-loaded branch name in the `onbranch`
 test cases
In-Reply-To: <87a6vera3q.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011190107160.56@tvgsbejvaqbjf.bet>
References: <pull.791.git.1605709410465.gitgitgadget@gmail.com> <87a6vera3q.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-961743544-1605745455=:56"
X-Provags-ID: V03:K1:X6lYwh96Nu1c7PWFsLTx7j7M1egptPe/6uTI/oPDlEjwsNZ0zhz
 6MraXNFpZlN5HrpLFW9nE0t5PiK1pFQAHVkZb6mQfZ03Og1cbNXfsy0d7SCinURZsVf5fhz
 Ajb/Uk/qShIccWmptgz/XFqD2MyICjaSzGt8cyZzALgr+k52a7XwwZRHsi/5FjAK1Ljnsli
 CNhwQaBRGYvjgkWSQ0kKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nbuzmEW1MgM=:jS2Js6Lo9lJavRQ7pbNVtR
 /RTyvc+NgqxXATQOMqhy5SPnBE7AizDo0AyNLDt/wGcmb+SRLlzERUoujQN8w2Bq2m84spYor
 0Jtv8USRym5xSD2KglFgmWnBgPNIkrmxXzu9IDfQs0CUdsXTkK8ZME3lBz7wlZBVAejIb3FZM
 NYK4IuBWfhHEdKYIbz6QduScuUa+JbgxcfhKKSHLCVX7CX4a1d5nFT5muRQ6K++/rXox04ejJ
 Cmc0BnNQLiqVpIpDzXX0qiwZjEcneyrVN5t/gVCysgBP5K1YE+oiV757vqFZnY6EnEAjvx6x8
 J4NTGeYDjIIimpGHBAhq4Z77ZPGgQ9aXICw7l5V2g51HecJOxk1t50paYuCL4qBlaRBVm8BHu
 Gdl5g0u1ospxkzEW742VbYzD1t2ZJpe3zp77IGeyU349lqSziU0V8mwT55YXjBDm/1hE+hS1X
 2FlMFJQ2v92u5i2Imv85QJiEBiLC0GkBhJnADrdXv9nz3wKCKUIz/sSWa/XHjjgjuNMSnTHIN
 G2QA8b4IkVcdW6raq9ILaUEbymFIz5WKnD32EthP73Aq0aFh2BF8w8YvaYOxyZ/xtCosTJBi+
 Dom8t+hx07cTeHnlMEVYGRN8LSEC5ULk1W9MArWBNbAqRbU02SL/kH4k/HueLDSo8hGM91IXW
 pfh4yv9viBgNqWMAtoByhyNQsm6QciIXsDrY5H6yAFIAMOKdoZm9Zx6lDc5v32nLOvakLYMUA
 8fhXm9uYZBqqP5TV0UMjiEYdsCFB6uGgNn+MhhAwbOJAF90EdKhJPmxwntCkZZod9AtaIOOgo
 nP2XX/hswV22lhfMBrrmJ4a4NcAKzx0uE7vv0Kv1TxYACYwlm8c8Xo+7C0meQzBRQGpABQXbl
 TY/YfWy/IlyCL7Oy8tuvb7AM1Gr0sI8RMrnL5W/hA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-961743544-1605745455=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 18 Nov 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Nov 18 2020, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The `onbranch` test cases in question do not actually want to include
> > anything; Instead, they want to verify that the `onbranch` code path
> > does not regress in the early-config case or in the non-Git case, wher=
e
> > the `onbranch` include is actually ignored.
>
> It's unclear to me what this patch is for & why it's needed.

Well, the entire idea of switching to a new default branch name is to
avoid using words that we know cause undue emotional harm. In the grand
scheme, therefore, I want to avoid having any mention of such words in our
test suite.

> Yesterday in your v2 27/27 series you sent a different one that changed
> this from s/master/main/g:
> https://lore.kernel.org/git/b8fa037791683b50c3efb01aa6ac0d3f7b888a2b.160=
5629548.git.gitgitgadget@gmail.com/
>
> That's on top of "next", but this one is on "master", the two would
> conflict, and the 02/27 one seems like the right thing to do.

Yeah, I hadn't made it clear yet at the time you wrote this that my
intention was to give in to your and Junio's suggestion to restrict the
`GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME` assignments to _just_ the test
scripts that don't work with arbitrary default branch names.

I had hoped that mentioning gitgitgadget PR 762 (which is that 27-strong
patch series) would be indicator enough that I was in the process of
revamping it into a v3, and that this here patch is one part that I
separated out into its own patch.

> > Therefore, the actual branch name does not matter at all. We might jus=
t
> > as well avoid racially-charged names here.
>
> It seems to me the actual name matters a lot, and it must whatever the
> default branch name is.

Nope. Not at all. Because what we're exercising is the code paths when we
_don't_ have a branch name to work with.

In the non-Git case, this is trivial to see. There is not even a
repository! How can there be a branch?

In the early config case, it is too early to access the refs. I meant to
reference (but forgot) the commit 85fe0e800ca (config: work around bug
with includeif:onbranch and early config, 2019-07-31) because that
commit's commit message describes the catch-22 that is the reason why the
early config cannot see the current branch name (if any).

I should probably have thought of referencing 22932d9169f (config: stop
checking whether the_repository is NULL, 2019-08-06) for the second test
case, too.

So again, these two test cases do _not_ exercise the code path where
another config file is included. To the contrary, they try to prevent a
regression where `onbranch` would segfault in one case, and BUG in the
other (in both cases because the now-fixed code used to try to look at the
current branch name _anyway_).

> I.e. what the test is doing is producing intentionally broken config,
> and asserting that we don't read it at an early stage.
>
> Therefore if we regressed and started doing that the test wouldn't catch
> it, because the default branch name is "master", or "main" if/when that
> refs.c change lands, neither of which is "topic".

No, if we regressed, the code would start to throw a BUG, or a segfault,
respectively.

We never expect these two test cases to look at any branch name at all.

Ciao,
Dscho

> Maybe I'm missing something but it seems 58ebccb478 ("t1309: use short
> branch name in includeIf.onbranch test", 2019-08-06) and your own
> 85fe0e800c ("config: work around bug with includeif:onbranch and early
> config", 2019-07-31) which added the test support reading.
>
>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     t1309: use a non-loaded branch name in the onbranch test cases
> >
> >     Just something I stumbled over while working on
> >     https://github.com/gitgitgadget/git/pull/762.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-791%=
2Fdscho%2Ft1309-onbranch-tests-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-791/dsc=
ho/t1309-onbranch-tests-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/791
> >
> >  t/t1309-early-config.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
> > index ebb8e1aecb..b4a9158307 100755
> > --- a/t/t1309-early-config.sh
> > +++ b/t/t1309-early-config.sh
> > @@ -91,11 +91,11 @@ test_expect_failure 'ignore .git/ with invalid con=
fig' '
> >
> >  test_expect_success 'early config and onbranch' '
> >  	echo "[broken" >broken &&
> > -	test_with_config "[includeif \"onbranch:master\"]path=3D../broken"
> > +	test_with_config "[includeif \"onbranch:topic\"]path=3D../broken"
> >  '
> >
> >  test_expect_success 'onbranch config outside of git repo' '
> > -	test_config_global includeIf.onbranch:master.path non-existent &&
> > +	test_config_global includeIf.onbranch:topic.path non-existent &&
> >  	nongit git help
> >  '
> >
> >
> > base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
>
>
>

--8323328-961743544-1605745455=:56--
