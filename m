Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEEB81F453
	for <e@80x24.org>; Thu,  7 Feb 2019 21:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfBGVem (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 16:34:42 -0500
Received: from mout.gmx.net ([212.227.17.22]:43493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfBGVem (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 16:34:42 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mh9cj-1gWDph1eJV-00MJeZ; Thu, 07
 Feb 2019 22:34:32 +0100
Date:   Thu, 7 Feb 2019 22:34:31 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
In-Reply-To: <xmqqy36rpki1.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902072233070.41@tvgsbejvaqbjf.bet>
References: <20190203230152.GA25608@sigill.intra.peff.net> <20190204205037.32143-1-martin.agren@gmail.com> <20190204233444.GC2366@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet> <xmqqimxyrs4w.fsf@gitster-ct.c.googlers.com>
 <20190206185520.GD10231@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1902071632280.41@tvgsbejvaqbjf.bet> <xmqqy36rpki1.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5XMeWHpzudGh+TUqfdUHt8uTV9fAmmr4POGBPTuAKqprIXdG9GO
 xae/OfCMbxvh8RbvA9LUAQKaUn49NegEYmPzWGNOI7xk8RD4VgoQUs9PxccJmPW9GqiQXVF
 LWtzQxpaYOwUdG9f8fSWW2RaTTu3Ev/5tk19aW7z5qi11iVnevfkjpL5emm8Teb2S5o0jWa
 SVPPgnSI/0dkktBN6xl8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dFuPYgSkAyA=:Z2B/E585oa0eSg30exq3qi
 lhWcKRcnjYemwD9TTbBVXNnOf4ESqJlkN+NppDUHDtNvNyDReooYnCQdwWsRyCPROXeouKU6O
 rUsTD0gAyKDkt10Moz1aykEIzdPY/43D81SE5hq4i5hNZ7Lm4JNcyBOytvRowrqtlY50PDX8a
 YX3v2iHDzVqJj0dpmqfrR8Lvc+wDO5xogu5/q2piZEKYB++0VVejI+IJigW7wzhAey3v6QTFk
 hGnFVvVU7jwNrbhlP69JltTGllx8IG4lncDDaaYcZ5zhe0rGY19AtkDSfODvIxSa+ge7UL4j3
 4hZBstNt6ZIcl437zC735eb/QMhww3Vu+P8cM3pVDu4H+p1mzn42SuwWpUMBfQB7ycTXsGDof
 kjGoFk7BmGiJWdQPoPNaQpiCqY1+iNkV/ZimKWzHMFmShuuYxgYZWglrXL/9GqsmqemvTJwlC
 r/4IJBweMdT4ZanWPwochGP9t6NPgA5jObuK3pj5Uw0FVD9UiRD1kq9x6WO+UfOZqLufa3vG4
 E0qmpbXD8ZSq+C9MtG5rFf9K3lqM34hErsAxvg4fqphQQ0/M9f/fKVe8DEkGTubDiUh3p6Uqn
 l0RHVWdILivl5X9Qz7T+7X9fG+XBq3zdDPXVJwcU/U48mT0IG5yBnXYgFuRdaURrqXn1sCwGr
 w0uG1jr7RF+RnU5AG5qwEjovDkxeyiJ+W57BP4JpGVneWY339/fi1YP0V1rFs0xo7mFJ9/tCg
 FczBwG10l+PytKRv+/RV6CTzR6aKBoQOLUXb+SIkEoUzx9D9eVETxA3F8JU1G+fMZEfg4vbaj
 /FWAVJACgSI4dzTODU/APAJlgShgV7IHVdVkvCuLLj727ugs97xJCj3CL+2fBk+SiDkDmDchF
 squGpZf6YnnUPCkhSRisFQxCVgdPixFy+8QNPRCFLCFV10trtIRiWgRsRrkR69HBznZwtAUE6
 AJnAXfFZt9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 7 Feb 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Even when there are even only as much as 12 merge bases to test (which is
> > the current number of merge bases between `next` and `pu`),...
> > ...
> > And I sadly have to report that that's not the end of it. Back when I
> > implemented the automatic bisect after failed builds (for details, see
> > https://github.com/git-for-windows/build-extra/commit/c7e01e82c), I had to
> > turn it off real quickly because the dumb bisect between `next` and `pu`
> > regularly ran into the 4h timeout.
> 
> Would it make it easier for you if you substituted all the mention
> of 'next' in your message with 'pu^{/^### match next}'?  

I was working on this in 2017, and could not make it to work as I wanted.
Ever since, that bisect code has been dormant.

In the meantime, I was able to parallelize the test suite enough to make
it feasible to test the topic branches. That usually takes care of things
really quickly, and I just bite the bullet and bisect manually.

Ciao,
Dscho

> 
> That mid-point between 'master' and 'pu' is designed to contain
> exactly the same set of non-merge commits 'next' has, with the tree
> that is identical to that of 'next', and from there to the tip of
> 'pu' forms a single strand of merges of tips of topic branches that
> are not yet merged to 'next' (by definition, it itself is the merge
> base of it and 'pu').
> 
> Bisecting along the first-parent chain from there to the tip of 'pu'
> would let us identify which merge is faulty as the first-and-quick
> pass and currently there are about 20 merges in that range on the
> first-parent chain.
> 
> 
