Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B04421F404
	for <e@80x24.org>; Tue, 27 Mar 2018 14:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeC0Oru (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 10:47:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:33545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752458AbeC0Ors (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 10:47:48 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MH4Os-1en6e22xow-00DmkD; Tue, 27
 Mar 2018 16:47:44 +0200
Date:   Tue, 27 Mar 2018 16:47:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Joel Teichroeb <joel@teichroeb.net>
cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/5] Convert some stash functionality to a builtin
In-Reply-To: <20180327054432.26419-1-joel@teichroeb.net>
Message-ID: <nycvar.QRO.7.76.6.1803271646520.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180327054432.26419-1-joel@teichroeb.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ASBLCL1X1HosBbNphGTrBF/5ZEhCQf/VgRSYiyYMj5gK19yCzLh
 h2FJ1b0khj7u6jJvebhiqtRZI/vJlGcgYF4aPhsNFzvyiVaLkLouzzFA0lhbfccaBJiF5Dv
 Ifo/gKkcT2GG3rj099qwAi5NR7Q0LPc9+qszMKdROvvEM2H27O9nSnFgXNv9vr7iCpKTqz0
 ob+CGY5QBsdDkasY/hZkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9B/7E+sKIoY=:CDc8Ko9zTceqgeQgsJaJ0L
 UfP5kqTAut/aQD5XzEdgfRTo1E1oNjGnzBAKAtUvfy51HrqhYGwoW8BprZkYai3As1l4mOUo9
 Jxnbgfx6tT2VaPMVcIJ3ahs0Mm4RGKjnTbuu8aqQ0KKJUy8FznU2V8mnRGRDMMESSJbY1L5Uj
 oq7r+x536A9/YNRVmEwqUcqoN3hSfmJhvafCx8Tpge3QGIO2XW3jrXXJLYMj3OY8dqtY1s4Do
 phY5fLNvusEDhqhV+44ip4T673mFRpjQoj5n8IfY0PyoorhLZEGrissjpwusxD41fWnxb/9cR
 qI+icWEakkpZJvUF4czMfS0+HuFumAbJbv3FMcJ/WCxM73g/lOh3QySNS+wO3RTYTm+J16qn3
 eT6Scm1dAepAkKmpcsKjixu1XBRPhN6w70DFoWTAyawvkczTIMlApsF90NdRqKMlHxNm6669G
 gPmYjMnUMlbnt7cLczK5Qf31XodMThaU7YnaEgLB/MkhBSwx2wcwI24/yi3O3+uCjhaO/Z7Z6
 m3QUdmQn1RWzX18oqWq6ijHZlRQvcVqXgfMeuQr92aXBRmuFqYWLOdZtDw817Qj6eay7g36OQ
 UTRD2WpBAP6dGMk7QdX54c9uU6QxMFI/iG5sSSh2QzikRbiCV25RzUdUFf1LE5sgMHUg2XRZ/
 8z6MK8qCwwuGyXXJuk4ESPOjAUNVzvUnuGMNfPz5QE3W7eQbdEwWj6zMKMn+Zku5kkqwQx7tK
 7ix79GM25XyHQQSkxsBcKEwHsZNGiZuml8IWDI1Kwk1lENRmR7zADN2jV4jr23o/FRRfn8xTS
 hurH3ueNOcxfqGIL9ri5asPeAC17VhfnJoQHU19Bpuvthe81/0N2qlpK/6/QrlAFLheslbJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel,

On Mon, 26 Mar 2018, Joel Teichroeb wrote:

> I've been working on converting all of git stash to be a
> builtin, however it's hard to get it all working at once with
> limited time, so I've moved around half of it to a new
> stash--helper builtin and called these functions from the shell
> script. Once this is stabalized, it should be easier to convert
> the rest of the commands one at a time without breaking
> anything.
> 
> I've sent most of this code before, but that was targetting a
> full replacement of stash. The code is overall the same, but
> with some code review changes and updates for internal api
> changes.
> 
> Since there seems to be interest from GSOC students who want to
> work on converting builtins, I figured I should finish what I
> have that works now so they could build on top of it.

Great! This will help tremendously, I am sure.

Ciao,
Dscho
