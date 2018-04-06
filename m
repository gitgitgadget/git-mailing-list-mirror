Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E81361F404
	for <e@80x24.org>; Fri,  6 Apr 2018 13:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbeDFNHZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 09:07:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:54083 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752489AbeDFNHV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 09:07:21 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LikE1-1eWDGR14Qv-00cyUG; Fri, 06
 Apr 2018 15:07:14 +0200
Date:   Fri, 6 Apr 2018 15:06:57 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Joel Teichroeb <joel@teichroeb.net>
cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, gitster@pobox.com
Subject: Re: [PATCH v5 1/5] stash: improve option parsing test coverage
In-Reply-To: <20180405022810.15796-2-joel@teichroeb.net>
Message-ID: <nycvar.QRO.7.76.6.1804061439100.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180405022810.15796-1-joel@teichroeb.net> <20180405022810.15796-2-joel@teichroeb.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yqO44kyYB75XmoAiCU9jfEoQUSea4SZ6b8CwJJDB5jr83EA4pn1
 wlvfWXQ1r371XJ7yH1H0XWwVVMa5QyjQ0x1AKn8imgwJVA0VwNZVdQTKDrS2wJNM2ohxpVI
 /FslsxtiJp9NAYxS5NMBBeXJyumc6VWzSOnGzWVRKFGknB/H+keguUjx6WkrRespCQ3NFgX
 2MSk/MnRDdUW3Xe/hzPig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8TWbL0ubkao=:d6rvmq7eQqeLX7csIZ47DS
 ZTjqVItzGzHyWYHsvrGOZ1Wa0DjYRm7kInIeIU+NfABhlV+DAsOVg5WPj5xvL1afC5TC4YXXn
 qi548bsN0/J9q35Fb9rc9B/BFlTmhBVHIBCI0DlJ105vpYQCm4Rt6DlMGSq/dhQ64c6RbW8eR
 BKpvpfE2lZWSdLaDOrAGpdkZhkKn+5NiAwvYvYWluP/VhKMWakFn4Rr8RTk1C+AFLnqIFSqOQ
 Ivuvc7WKnbNy86DbjMJ2epOA73WvLsDSzqm9HdCXI+houQtqlptn3XJ5S85ESQk9HsrP6DvQP
 OeyglHfUQuv/xDjmEIiS2KnPYf3qkncFqSq7pF/9k01I7eQ55VfeRDE3FuqPI6oXbFlko3mqW
 EDZq/ZjQ9jaVfidQf06l+shpCiniAVsm6q3N79sGtyYYcFx/dEEI1HN1OAyYWSRTWWhIswDSb
 JN29sCiwHGeDUq5NSAgheB5/pcST1OyI2Bk6V5h716mPkGEfmJ0cOyHL1gw0QONxF3OTHPiI7
 PnG0gvq67adRH6UXrC35cBG8waA8T/+BoXtNG5YphossZ48Wpo/yfTX0UWgkec0n8pBWDS9P/
 yRw6PUuIFggwMy9xf5KBPthlEXbzEhBzM+xTed/Lsk3BGvzW6eiucVYi6SDC3FHhzU4bISVmK
 G4EEsc3GDxiG9bhvGsPUUy+kB8mowMFKXKW7Z/h7QQ04+nw/aJywiuSHkQjZv/gGfRrZcHb06
 u+31bM7pm/Dop3jbxC0goiR3XSPxLpz8KlfRd4oWXwRU7S17uqWQG16G32mzrp1DswljOPNeN
 /zN1EqN0C2jpGpsxEVBJmHS/gaajyDHWbnZ3YMzR08H9/EVES8lxigtr0w48DIp7FGHcKQO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel,

On Wed, 4 Apr 2018, Joel Teichroeb wrote:

> In preparation for converting the stash command incrementally to
> a builtin command, this patch improves test coverage of the option
> parsing. Both for having too many parameters, or too few.

Very good.

> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
> ---
>  t/t3903-stash.sh | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index aefde7b172..4eaa4cae9a 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -444,6 +444,36 @@ test_expect_failure 'stash file to directory' '
>  	test foo = "$(cat file/file)"
>  '
>  
> +test_expect_success 'giving too many ref agruments does not modify files' '

Quick, before Eric beats me to it! A typo! s/agruments/arguments/

> +	git stash clear &&
> +	test_when_finished "git reset --hard HEAD" &&
> +	echo foo >file2 &&
> +	git stash &&
> +	echo bar >file2 &&
> +	git stash &&
> +	test-chmtime =123456789 file2 &&
> +	for type in apply pop "branch stash-branch"
> +	do
> +		test_must_fail git stash $type stash@{0} stash@{1} 2>err &&
> +		test_i18ngrep "Too many" err &&
> +		test 123456789 = $(test-chmtime -v +0 file2 | sed 's/[^0-9].*$//') || return 1

Not your problem, but if there is future work on this (read: if I get to
mentor a GSoC student, and if I get them to work on it: this idiom
`test-chmtime -v +0 ... | sed ...` is too common, there really *should* be
a `test-chmtime --get ...`).

Any prospective GSoC student: you know what I have in stock for you ;-)

> +	done
> +'
> +
> +test_expect_success 'giving too many ref agruments to drop does not drop anything' '

s/agruments/arguments/

Also, we try to keep the lines to <= 80 columns. So maybe

+test_expect_success 'drop: too many arguments errors out (does nothing)' '

> +	git stash list > stashlist1 &&

Again, before Eric can beat me to it: we prefer the syntax `>file` (i.e.
without a space between the `>` and the file name).

BTW is there a public branch with your patches? I am not so much of a fan
of reviewing and having all the work being punted back to the contributor,
especially when we failed you for so long in reviewing these patches. I
would love, for example, to open a PR on GitHub (even if that would only
apply to code changes, not so much to commit message changes, not until we
have rebase support reword! and drop! keywords).

> +	test_must_fail git stash drop stash@{0} stash@{1} 2>err &&
> +	test_i18ngrep "Too many" err &&
> +	git stash list > stashlist2 &&
> +	test_cmp stashlist1 stashlist2
> +'

It might make sense to rename stashlist1 to `expect` an `stashlist2` to
`actual`, to clarify the roles.

> +
> +test_expect_success 'giving too many ref agruments to show does not show anything' '

Maybe

test_expect_success 'show: error on too may arguments (show nothing)'

to keep within the 80 columns/line limit?

The rest looks obviously correct to me.

Thanks!
Dscho
