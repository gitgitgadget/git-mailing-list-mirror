Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE1D81F597
	for <e@80x24.org>; Mon, 16 Jul 2018 15:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeGPQTt (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 12:19:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:46693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbeGPQTt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 12:19:49 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M81vR-1g1HP92fkP-00vcIH; Mon, 16
 Jul 2018 17:51:30 +0200
Date:   Mon, 16 Jul 2018 17:51:26 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/25] t7400: fix broken "submodule add/reconfigure
 --force" test
In-Reply-To: <nycvar.QRO.7.76.6.1807161641140.71@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1807161749410.71@tvgsbejvaqbjf.bet>
References: <20180702002405.3042-1-sunshine@sunshineco.com> <20180702002405.3042-12-sunshine@sunshineco.com> <nycvar.QRO.7.76.6.1807161641140.71@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FcY3wwfr9D35+d0sZ+VYyuUt6/+wXx5Ptd73zvCAkKzaPgoTKBz
 T0fM5POqBbRDjgYfcuCXfRm10AR5j8eN/2bVRvVCFKxfXaZK20eljEJBYPzsETZ6g4m0c/7
 6c7/Uc0fSpO3aSi1J7nZaP85ePQ/Rr/rFZAfo8NQNf4BWB0SAkfZFJ8fDnIF51GJGkclePs
 HkUyaAVx7JY6roCWy54eA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PyyZxU6Ao+c=:KPYI2yRMMGqsZEELo85G7/
 ZLtCcI2RJkVeALO9I51JA8hHSzAf9OpFy2z3AesXAgiLpPlgDzI516sF3HVONmn1Dz6jxIrXq
 dB7lkfPjFkfiTSSBT9a3K9jZXQ7MbqFJYRjUNuxiJBBBqhl0cZwEXi1Vly1LYcqhMBxmF1tDl
 9IMszWYNYZwyzFxg9bwWn3aV3lV00dBDqYTTjpF7cDD8K/qtKiiHXp/zz69v49zQqS+V/p+08
 Xyx40eCscPNXtPfT6mc5YVQdEkMtJgtSmWLoESAUgEOuI7liIX/XXZAb8ldimoExp4eQoS8mG
 uO8yg+4qggqbQjhKk74LG7+zv+meEGjsL5Xm1lpRzr25i/Xz1tJ6YLBi9vg5BykKR/IAS6g5B
 B2ppyLXOtMaQzoL8pAUtMWko5iOe/91WtQDajCtJ0IDwI21Tiz0ttyLmlJ2Qs4+lzUA1RBsMm
 Qakp0hUWirdaDttfA7/HSdhIDHD4LBdHm5HyFBe1nCrGq01OnAXD12wAVE/LqjjfmIeqGxcTh
 dMRWMX5pVYIzcMuNxuwBz1FNZ30AKal3Fh6mfMudimcAUznKfg7l+anBYrFFQn7jNFPkavmo8
 oQMAWImt+siL3MgA+6NvWr8p+hBwPBUIgupdR0d8MBcYSlM8SijFMP+Ii2wIaZCy9Jjqcl6iT
 tNS9cZyk/PZxkx44bbg1VroovZirB54xFwJ9vcRRL11z2RJDLe/r6+40mmMGwz0xj+5B/U36u
 4N2d+m6MAwFiJ0h6PQSA5Em8SjX10IQV+YULM17GrxaqUAShcFBU2uFkh3HR/nrViU4YbNUNG
 R8W7X/V
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 16 Jul 2018, Johannes Schindelin wrote:

> On Sun, 1 Jul 2018, Eric Sunshine wrote:
> 
> > This test has been dysfunctional since it was added by 619acfc78c
> > (submodule add: extend force flag to add existing repos, 2016-10-06),
> > however, two problems early in the test went unnoticed due to a broken
> > &&-chain later in the test.
> > 
> > First, it tries configuring the submodule with repository "bogus-url",
> > however, "git submodule add" insists that the repository be either an
> > absolute URL or a relative pathname requiring prefix "./" or "../" (this
> > is true even with --force), but "bogus-url" does not meet those
> > criteria, thus the command fails.
> > 
> > Second, it then tries configuring a submodule with a path which is
> > .gitignore'd, which is disallowed. This restriction can be overridden
> > with --force, but the test neglects to use that option.
> > 
> > Fix both problems, as well as the broken &&-chain behind which they hid.
> > 
> > Reviewed-by: Stefan Beller <sbeller@google.com>
> > Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> > ---
> >  t/t7400-submodule-basic.sh | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> > index 812db137b8..401adaed32 100755
> > --- a/t/t7400-submodule-basic.sh
> > +++ b/t/t7400-submodule-basic.sh
> > @@ -171,12 +171,12 @@ test_expect_success 'submodule add to .gitignored path with --force' '
> >  test_expect_success 'submodule add to reconfigure existing submodule with --force' '
> >  	(
> >  		cd addtest-ignore &&
> > -		git submodule add --force bogus-url submod &&
> > -		git submodule add -b initial "$submodurl" submod-branch &&
> > -		test "bogus-url" = "$(git config -f .gitmodules submodule.submod.url)" &&
> > -		test "bogus-url" = "$(git config submodule.submod.url)" &&
> > +		git submodule add --force /bogus-url submod &&
> > +		git submodule add --force -b initial "$submodurl" submod-branch &&
> > +		test "/bogus-url" = "$(git config -f .gitmodules submodule.submod.url)" &&
> > +		test "/bogus-url" = "$(git config submodule.submod.url)" &&
> >  		# Restore the url
> > -		git submodule add --force "$submodurl" submod
> > +		git submodule add --force "$submodurl" submod &&
> >  		test "$submodurl" = "$(git config -f .gitmodules submodule.submod.url)" &&
> >  		test "$submodurl" = "$(git config submodule.submod.url)"
> >  	)
> 
> This breaks on Windows because of the absolute Unix-y path having to be
> translated to a Windows path:
> 
> 	https://git-for-windows.visualstudio.com/git/git%20Team/_build/results?buildId=12365&view=logs
> 
> (In this case, it is prefixed with `C:/git-sdk-64-ci` because that is the
> pseudo root when running in a Git for Windows SDK that is installed into
> that directory.)
> 
> I could imagine that using "$(pwd)/bogus-url" (which will generate a
> Windows-y absolute path on Windows) would work, though.

Yes, this works indeed, see the patch below. Could you please squash it in
if you send another iteration of your patch series? Junio, could you
please add this as a SQUASH??? commit so that `pu` is fixed on Windows?
Thanks.

-- snipsnap --
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5ffc2726aad..2c2c97e1441 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -171,10 +171,11 @@ test_expect_success 'submodule add to .gitignored path with --force' '
 test_expect_success 'submodule add to reconfigure existing submodule with --force' '
 	(
 		cd addtest-ignore &&
-		git submodule add --force /bogus-url submod &&
+		bogus_url="$(pwd)/bogus-url" &&
+		git submodule add --force "$bogus_url" submod &&
 		git submodule add --force -b initial "$submodurl" submod-branch &&
-		test "/bogus-url" = "$(git config -f .gitmodules submodule.submod.url)" &&
-		test "/bogus-url" = "$(git config submodule.submod.url)" &&
+		test "$bogus_url" = "$(git config -f .gitmodules submodule.submod.url)" &&
+		test "$bogus_url" = "$(git config submodule.submod.url)" &&
 		# Restore the url
 		git submodule add --force "$submodurl" submod &&
 		test "$submodurl" = "$(git config -f .gitmodules submodule.submod.url)" &&
