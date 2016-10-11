Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D87E2098A
	for <e@80x24.org>; Tue, 11 Oct 2016 10:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbcJKKRx (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 06:17:53 -0400
Received: from mout.web.de ([212.227.15.4]:58093 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752798AbcJKKRw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 06:17:52 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LfAfQ-1b56mK3GVE-00oqNU; Tue, 11 Oct 2016 12:09:48
 +0200
Date:   Tue, 11 Oct 2016 10:09:46 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        peff@peff.net
Subject: Re: [PATCH v10 13/14] convert: add filter.<driver>.process option
Message-ID: <20161011100946.GA13745@tb-raspi>
References: <20161008112530.15506-1-larsxschneider@gmail.com>
 <20161008112530.15506-14-larsxschneider@gmail.com>
 <xmqqint0dlis.fsf@gitster.mtv.corp.google.com>
 <02E73D87-B036-40CA-AF54-F93415A028BC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02E73D87-B036-40CA-AF54-F93415A028BC@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:3soyq+1Hp9pLkJ9k29u7JQHeXslMUevwVODc3MUkB88ykxMFY8t
 AFOnNfX8Zocp5bYV1MupQLY6SiLzPcxuPe4eetaKGx2mdo8u0aT5ZTurUOjlaIb10gGUt1n
 4MkZsFdpO5kvDOoFonbDzAIqRKx5fDX2WntV2GXzyHr0vqxy/7xgM1iKPYTygPc2+5bs3r3
 F5ExWj82CXb5RA8sPUyNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EdNHG3weW90=:u/M3O1raAKLS79XXR7Jzcq
 HSO/AQDGmxHn2wBk1TzxVovvR+cKNdTALicZzmd2REgf6P7h8sE1vjly/fi/NVIo81QrL73eX
 vNXvsA9xg0teVCiaYeARXBE3YQZahoWlcs63K01xYPy3oEimZC/5x+W+f9nOkx3MTaGr7b14o
 pB59/EcJQw5L/d4n23SvNQPLsVPaNBVwcL8PshiqtW9qCFJOdZs0VYG7Tv1G/CVSNzgaMCg0q
 7ZO8uYn/UqHNi258BBp6r3wsFBQxUTTWb2FQWG84f8CzlsB73zKDb+LV67blu3sH6ItBcRzxg
 5NMrCHeDulpFej3s+7crCnGJxtMamrhQHkuFKWZn+6rV2jEMcCQJzT/X1aaCzTzmCTNUVZ+Yg
 isHWYdpNomvg25KIzlrxmmcJqT2nM8WwJxdnfJxNhH6m+hQqlWMiNAIDElrFOWLaeDnzyUOz3
 ZmbwtGTmpoiymdSxvJ3RLtzpUqXH0Frp9xN971We2ibjNXUe/GKZ4QyHshBUnxCI/fAcmq4ZI
 8ZoDA5lqN6KfxQ8SskvHbAZiKXeMOn/fVBXRyEm8VQyUfzC+QgXHw6SkXnOh1l16cKDwJm4yt
 MsDJCji2R2OEok07mVLY/UfM2LRt3+shjIfzOtxAy4wkOyiGHKrOQwJeV3XQjSBg6oTYaAlrP
 9ZJf4vcXczaXFRpwoOG+b+Yr1yiz7GLlj7ojkIdeZNfONzOAB6WC0mcgsyZGWYBEkltxJN/2p
 4oXojODMyBpPScLcEIiUoyzdriMG6hywaQcZXbcNiGyYRIWncp4xN9YPvn4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 10:11:22AM +0200, Lars Schneider wrote:
> 
> > On 10 Oct 2016, at 21:58, Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > larsxschneider@gmail.com writes:
> > 
> > [...]
> >> +# Count unique lines except clean invocations in two files and compare
> >> +# them. Clean invocations are not counted because their number can vary.
> >> +# c.f. http://public-inbox.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
> >> +test_cmp_count_except_clean () {
> >> +	for FILE in $@
> >> +	do
> >> +		sort $FILE | uniq -c | sed "s/^[ ]*//" |
> >> +			sed "s/^\([0-9]\) IN: clean/x IN: clean/" >$FILE.tmp
> >> +		cat $FILE.tmp >$FILE
> >> +	done &&
> >> +	test_cmp $@
> >> +}
> > 
> > Why do you even _care_ about the number of invocations?  While I
> > told you why "clean" could be called multiple times under racy Git
> > as an example, that was not meant to be an exhaustive example.  I
> > wouldn't be surprised if we needed to run smudge twice, for example,
> > in some weirdly racy cases in the future.
> > 
> > Can we just have the correctness (i.e. "we expect that the working
> > tree file gets this as the result of checking it out, and we made
> > sure that is the case") test without getting into such an
> > implementation detail?
> 
> My goal is to check that clean/smudge is invoked at least once. I could
> just run `uniq` to achieve that but then all other filter commands could
> happen multiple times and the test would not detect that.
> 
> I also prefer to check the filter commands to ensure the filter is 
> working as expected (e.g. no multiple start ups etc) in addition to 
> checking the working tree.
> 
> Would the patch below work for you? If yes, then please squash it into
> "convert: add filter.<driver>.process option".
> 
> Thank you,
> Lars
> 
> 
> 
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 9f892c0..714f706 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -31,38 +31,33 @@ filter_git () {
>  	rm -f git-stderr.log
>  }
>  
> -# Count unique lines in two files and compare them.
> -test_cmp_count () {
> -	for FILE in $@
> -	do
> -		sort $FILE | uniq -c | sed "s/^[ ]*//" >$FILE.tmp
> -		cat $FILE.tmp >$FILE
> -	done &&
> -	test_cmp $@
> -}
> -
> -# Count unique lines except clean invocations in two files and compare
> -# them. Clean invocations are not counted because their number can vary.
> +# Compare two files and ensure that `clean` and `smudge` respectively are
> +# called at least once if specified in the `expect` file. The actual
> +# invocation count is not relevant because their number can vary.
>  # c.f. http://public-inbox.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
> -test_cmp_count_except_clean () {
> -	for FILE in $@

> +test_cmp_count () {
> +	expect=$1 actual=$2

That could be 
expect="$1"
actual="$2"

> +	for FILE in "$expect" "$actual"
>  	do

> +		sort "$FILE" | uniq -c | sed "s/^[ ]*//" |
> +			sed "s/^\([0-9]\) IN: clean/x IN: clean/" |
> +			sed "s/^\([0-9]\) IN: smudge/x IN: smudge/" >"$FILE.tmp" &&
> +		cat "$FILE.tmp" >"$FILE"

How about 
		cp "$FILE.tmp" "$FILE"

