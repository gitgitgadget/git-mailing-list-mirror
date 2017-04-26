Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB799207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 09:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1956826AbdDZJ0W (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 05:26:22 -0400
Received: from mout.gmx.net ([212.227.15.15]:55158 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941308AbdDZJJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 05:09:29 -0400
Received: from virtualbox ([95.208.59.147]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lck9X-1dnKYH1P5L-00k7S2; Wed, 26
 Apr 2017 11:09:22 +0200
Date:   Wed, 26 Apr 2017 11:09:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, computersforpeace@gmail.com
Subject: Re: [PATCH v2] sequencer: require trailing NL in footers
In-Reply-To: <xmqqinlrudij.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704261101250.3480@virtualbox>
References: <20170425190651.8910-1-jonathantanmy@google.com> <20170425235741.32546-1-jonathantanmy@google.com> <20170426000741.GS28740@aiede.svl.corp.google.com> <xmqqinlrudij.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RGz8fcct8O901+X5XvitdDOjOzRimW+VAIJh02FnDzLk7Yt19YB
 S0lld4FwuKR04qwwTTIU0UwUhsyH0FU93jwdVHAzyfqJwaL5wfgvNG9lhP2jZPr4826k+uv
 QHD76NpBClSq9ITdL54aLLnEguqz6Ty4lN/6sR7QXCj1ql92usGxDcNC3B9Bk+rKjllukTs
 9uAhmmE8u4WDvP5ymaAZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dF8ZadKAlyU=:urJOCctu721FENLwHj7BDR
 CBYMlQdpyzNd/cKnNw1smyKjlfw5AgnMM9tLMVv+EXTLpsyq4uQnoM9mIdaBpk5dVeWTrIYgP
 zQJ+VI4hOv9Q6WaNkGD3/IKNDekrGqh7CT7bh/0vFnTDenBekpJgY1bF/3PwePC0EnPAZTYFn
 +zrL+6lTPebx2GCS+ldkthcru4XesEN1FHUaIwY0Mb5nXAgePVyEjcggi7OqTgXu2TE3rZiSG
 9WuSQeo0JJqr/JlGEULDsccB+dAfTdoSDzxqgjarToE3Fw3rEIxqHoKHVKHo94jt2RFoBl6Cw
 UXye868XzQuvINyaHh9gDXobdJsH2JasuMSA+b6wonsrpM/mTXde8ZnRjpHCMLIrvr6nyszPq
 gkdF4cbX3stw4J3v77ExvCB7JnB7RRstvp9he1CWd1MaZIMumYgDcmXmw52Nk+RhFTXoPooft
 Mhz9oEkxoINPVUDaHOv3fUReTajaEPPe58160BKWr8MzwaIBvPIZBOdfDghz0dyoMCnnguNv3
 ffZ3Msf5Xxs3ZrsqqrnX23nv/3lESdLRCp/oVkImDApPShx4YffhfBAp1Ige5U7y3h7wt3gEU
 L/7NWsp4PzxJYt6sO9nAiw+YPeoXw8i49iS+Sf9xM/Of98z4RBST1wE409QhNME7g5Suao9Ff
 0oH0hqytTTDfNZ2XcNu60H4I+b/HOR+bH5E+x4aP/eEB96Ep9mWz2uoBDnoGLk8aOvnrkBuQi
 FnIwyOSIqGo8by5AM1uRa6s34yvhs0Bq+ROwPmnGjB/Tr4et2ImkfzlFwvNFuubmrDWdnUCD6
 Sg1k3A0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 25 Apr 2017, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Jonathan Tan wrote:
> >
> > [...]
> >> --- a/t/t3511-cherry-pick-x.sh
> >> +++ b/t/t3511-cherry-pick-x.sh
> >> @@ -208,6 +208,20 @@ test_expect_success 'cherry-pick -x -s adds sob even when trailing sob exists fo
> >>  	test_cmp expect actual
> >>  '
> >>  
> >> +test_expect_success 'cherry-pick -x handles commits with no NL at end of message' '
> >> +	pristine_detach initial &&
> >> +	sha1=$(printf "title\n\nSigned-off-by: a" | git commit-tree -p initial mesg-with-footer^{tree}) &&
> >
> > nit: Should this use a more typical sign-off line with an email
> > address, to avoid a false-positive success in case git becomes more
> > strict about its signoffs in the future?
> >
> > Something like
> >
> > 	printf "title\n\nSigned-off-by: S. I. Gner <signer@example.com>" >msg &&
> > 	sha1=$(git commit-tree -p initial mesg-with-footer^{tree} <msg) &&
> > 	...
> 
> That is a good point and has an added benefit that the test script
> becomes easier to follow.

If you already try to make it easier to follow, you might just as well go
the whole nine yards:

> diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
> index 6f518020b2..c2b143802d 100755
> --- a/t/t3511-cherry-pick-x.sh
> +++ b/t/t3511-cherry-pick-x.sh
> @@ -210,12 +210,14 @@ test_expect_success 'cherry-pick -x -s adds sob even when trailing sob exists fo
>  
>  test_expect_success 'cherry-pick -x handles commits with no NL at end of message' '
>  	pristine_detach initial &&
> -	sha1=$(printf "title\n\nSigned-off-by: a" | git commit-tree -p initial mesg-with-footer^{tree}) &&
> +	signer="S. I. Gner <signer@example.com>" &&
> +	printf "title\n\nSigned-off-by: %s" "$signer" >msg &&
> +	sha1=$(git commit-tree -p initial mesg-with-footer^{tree} <msg) &&
>  	git cherry-pick -x $sha1 &&
>  	cat <<-EOF >expect &&
>  		title
>  
> -		Signed-off-by: a
> +		Signed-off-by: $signer
>  		(cherry picked from commit $sha1)
>  	EOF
>  	git log -1 --pretty=format:%B >actual &&

It is even easier to read `--format=%B` than `--pretty=format:%B`, and as
`%B` does *not* indent, the indentation in the lines writing the `expect`
file is bogus anyway. And with the `msg` file having most of the stuff
already, we Do Not Need To Repeat Ourselves:

	printf '\n(cherry picked from commit %s)\n' $sha1 >>msg &&
	git log -1 --format=%B >actual &&
	test_cmp msg actual

Ciao,
Dscho
