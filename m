Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C7DC2D0E5
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960F020740
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gSLeCzDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgCYTBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:01:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:46145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgCYTBO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 15:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585162873;
        bh=dw90rkjzJezYDRIbd2+CCuhqh+mpZCKryWnrWuos+J8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gSLeCzDmr/Nat05/hW5w7e5iEdjJrSEw5TJkWphu72z5eCAmjoBXC2L4rDhr/B8SM
         LCJYAaqomfQhQhor2IfsbE42AtSdfpDpt2DQlFk0q78VzUsGxvhVNh1onMt1GWHCw4
         2WUsiMhTTlQ/FwP+f5Dh373WTM7IiVJppvRlfC5I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.214.37]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MIx3I-1iwtEY36ss-00KSGY; Wed, 25 Mar 2020 20:01:12 +0100
Date:   Wed, 25 Mar 2020 20:01:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeffrey Walton <noloader@gmail.com>
cc:     Git List <git@vger.kernel.org>
Subject: Re: Test results for GNU HURD
In-Reply-To: <CAH8yC8mn+c_v85eMTqLEZS1=OgetOKe9uX3MoPDmRZEyfENuTQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2003252000200.46@tvgsbejvaqbjf.bet>
References: <CAH8yC8mn+c_v85eMTqLEZS1=OgetOKe9uX3MoPDmRZEyfENuTQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2Z2jwp1eGhZdK1LVuCgtTMZdxQH0VqvNNyuggerdqjt4ROZ7XCK
 OG9XT+aDMzqYD+ksjrLdhX9gXyZIePek6QppPY4ScKeq5jtI4BmFmvEzdUw6Nk3OzOSMZVO
 Pi4JHCP8/jcb1LlceHwUR/vROfQ3aWdsgV+YjcVJtAO6DkbfEWMK/Sjl39sYHeYb9xV4nVs
 GQHSKkjFclTjtj8sBMg3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jTLxmWvPtZg=:RVteEmqZ6U1kjnEwo3/TUE
 H1Bo57VIxUqfSAbk0+1OnjJUFoaNTd1xqZNAAi9MF6KpquEsjaCcXey2QuL2hmXhO55Z72Lws
 7FFnCNx2L9UL18+Hn5gWixaWerCiE9nHcR5sl/o4epwOgeHLV/YZ0GlKRUTHXDwNLnU24v/ys
 b+e0ZYvvbe6AJ+41i6xYUsj0g09D74jm1kK5E91B79YfbAY8iwyz3OzMzbKarbK2q59GP2KVp
 wgPtM9DtsE7uD1I58fvYcMUkKTl1enKFO5Z4j3nnELl9DblSSEiWiN319rqCnAlcdTdWMpngM
 VKppbqmjymCtKkJ/BHNwBUWmIzziO/zc2HUmbpwYkGF3ZYiVcvreH3priiB9ZlSh4juwZIGgN
 5TjDjzPkBQDwXWGSKA2cLGBkL+5dx95eMwRK9WvEtsB4ElsG/v4wnBxkvWgwkIazi/bZ3ZxXt
 5QwhbezbQRyTwAngHSlXpFXpZJfH5hmbNxHC0edo1IvrKqZRVa/mYiMO4ZHcnp8ToXnwWq5WP
 AwDp+5tDJ31pCiyDPhOcbfZWLTXps+5yT27JhuwcWnx6z6ino7SsnyAjBrKiOmo0mRQ+j2JNC
 W7UBUevNwAs3aQ55qIUdkAiN8y/kDjKnbCPAXqoAlwMB+IgKcBaedyryl6gUjDMtdi9F0CtiW
 tUM3CLo8++q5A5J0RMQ+4TQ2bTc1SJZzwxPMIr7RpMJISW5bOEX/vC9XuhRmiwS9PD76nIzES
 T/oez4CAPVVDgzX78XcAo+iTSsDUb+6XZb30H+7NnEjTnyFvHTuOJ9x+YNvT/qt5/YQCkVhvo
 utHwbqnJMxnVYKCLjsL5E8qOvzWZkknQhba7nu0GGj3ENo5wj73scPF3Aqxe9lU6Lg/x/xR2s
 9ltmgp5faoK5flqPbW2BwFYlFg2OD3nEwwD6UWrsKmHVgLaQrJ69BsUXPho1YgtZ4mdf7pZ8a
 4PprVbkhc470VTj5R54tDOfRtdnChJQ4ZFWUvS8VprnL1XOy//se7YQLz02SNVPB+WqB9gxN1
 0Fsruc8hFqkW62cnRJaBS/D4j+Y4gRErFh7cbCAzekNZFOr+7E+SbZOTVOL+Cd3/ECXnNqcpp
 dFFMLWsuwLoqyytIFSzyJiu6OAbO2WTugi2OjP5dXWyAVHcisYBMJfry9b3qqHsA1jAED9hST
 DQpcPGe3F0lxXNBixMvDtHVQ4J5/emgqucckG+avYTtkO8J1ccJyLmiygSOhWpvV3eoYuLxL7
 34BsU1YGTV2N77T/E
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeffrey,

On Wed, 18 Mar 2020, Jeffrey Walton wrote:

> Hi Everyone,
>
> Here are test results for GNU HURD built from the 2.25.1 release
> tarball. HURD is the JAN 2020 image, and fully updated with apt-get.
>
> I may be missing something for testing.

Maybe you can re-run this test script with the `-i -v -x` options? That
will stop at the first failure, produce verbose output, and also trace the
commands as they are run.

Ciao,
Johannes

>
> *** t5562-http-backend-content-length.sh ***
> ok 1 - setup
> ok 2 - setup, compression related
> ok 3 - fetch plain
> ok 4 - fetch plain truncated
> ok 5 - fetch plain empty
> ok 6 - fetch gzipped
> ok 7 - fetch gzipped truncated
> ok 8 - fetch gzipped empty
> ok 9 - push plain
> ok 10 - push plain truncated
> ok 11 - push plain empty
> ok 12 - push gzipped
> not ok 13 - push gzipped truncated
> #
> #        test_env HTTP_CONTENT_ENCODING=3D"gzip" test_http_env receive
> push_body.gz.trunc &&
> #        ! verify_http_result "200 OK"
> #
> not ok 14 - push gzipped empty
> #
> #        test_env HTTP_CONTENT_ENCODING=3D"gzip" test_http_env receive
> empty_body &&
> #        ! verify_http_result "200 OK"
> #
> ok 15 - CONTENT_LENGTH overflow ssite_t
> ok 16 - empty CONTENT_LENGTH
> # failed 2 among 16 test(s)
> 1..16
> Makefile:56: recipe for target 't5562-http-backend-content-length.sh' fa=
iled
>
