Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21C7F207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946539AbdDYVFC (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:05:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:60586 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1431660AbdDYVFA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:05:00 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LuJDv-1c1VDf2LqB-011maP; Tue, 25
 Apr 2017 23:04:36 +0200
Date:   Tue, 25 Apr 2017 23:04:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        peff@peff.net, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7] read-cache: force_verify_index_checksum
In-Reply-To: <xmqqk269xmmq.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704252225450.3480@virtualbox>
References: <20170414203221.43015-1-git@jeffhostetler.com>        <20170414203221.43015-2-git@jeffhostetler.com>        <870a8a36-fc6c-6b07-d09e-eec8a9f46a5c@kdbg.org>        <8bde0b54-c0f6-364d-1f08-ce5207eb6c86@jeffhostetler.com>
 <xmqqk269xmmq.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gCZXyCVyEo52lqAujjUU5IVssFQhdsASapWmXHd7EywPAwQAOka
 Tq1hEau7aqNjzX8OqPEJKQtsAYFbp/7fEDpKRWUv4iCXGtMaJ5xn7kZqRMMuVyrAi3dhBjl
 5/2Vkf3DNrhntwK1Dm3ifKMXlKhNe1mACIBpOYFJETebJh44H03Pao9z1ynlo3pTIxbHst7
 jBtwbDOLynToXXwzt6ZZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YRPJsjXQO3k=:KF/HHvAg2cZhyDvq7sizLt
 Jdmiy/d6XoBt62dJ7x834jwN7Ogvcaw9Cn1y/ZUKtgVjKugsoOMczT6Ph0oWFHAOutHkILvqZ
 6DpHnElV49h+kQBsbZqjnR/qzOtPr6kzAdas16zUdZu0aDWSqJkVsWVkeLNhnxQkoLdhaxMGW
 8wuIRObjlpK1z5+Mz9bVOymdbo5bT1GGsKG/C0NW9PGaDux8LAThykmI1m+vFWxNXRcJFFdaK
 o5SRk8A3lXn35iv0N4puLoxvG4fp42jICuDAKKFPpdoK4u7tBaMFB8Egs8P3XZ+zYu7VD+vsS
 PKUu4vSwx7hIKulm8yvKbR5J6iKS9uSpj0kEwwSHqt9WZ7D+pGizz9ubn0iPiNnbzp/jL9rPW
 SIgeQuMr2cqUkACNNSGqkEeUog+JxoKZ6+mTOwR05P4jBpHdgAs3jlpIqp6TdHM3l02+E989v
 6ymxdhpcKYdK91vd+y7SDlivVG+i66lWncEAyUYQsD1UYF9gkVDIYQH98KcBiX/ElcXvuP4Dp
 sbWB1XWnFfcXwBbqnwfHDLPKlvt3uWJ6HOUgZiqm91bRbRenFb7vmkgbcjjSD786zUFNm51Q5
 eSLf2h3/mDEGGEWUu6bFmIKdUeRCBuA9oIniEk5abSZUHGWOfpSNJf+bB2WRbPVstXvW6m5Jb
 kzXB03LMjj+tZwYb4VWJetLoU7wGa6cJZOdWcjXzHcZRDdFd5mwRmMFpmDg7/NEIBmm+TenvM
 a+MzwdKj+35eUP1oeX3C6IRyy4Ykw+KpZUBx9uAoEsRt1wrDmBwut/SetkYCNu8bq/SBSGvGa
 hEqmOfl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 24 Apr 2017, Junio C Hamano wrote:

> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
> >>> +test_expect_success 'detect corrupt index file in fsck' '
> >>> +    cp .git/index .git/index.backup &&
> >>> +    test_when_finished "mv .git/index.backup .git/index" &&
> >>> +    echo zzzzzzzz >zzzzzzzz &&
> >>> +    git add zzzzzzzz &&
> >>> +    sed -e "s/zzzzzzzz/yyyyyyyy/" .git/index >.git/index.yyy &&
> >>
> >> sed on a binary file? Sooner or later we are going to run into
> >> portability issues.
> >
> > In v5 of this patch series I used "perl" and it was suggested that I
> > use "sed" instead.  It doesn't matter to me which we use.  My testing
> > showed that it was safe, but that was only Linux.

I am sorry to hear that the Git mailing list's review gives you whiplash.

The problem with sed is that BSD sed behaves a bit differently than GNU
sed, and we quietly expect every contributor to be an expert in the
portability aspects of sed.

TBH I am quite surprised that anybody would have suggested to use sed
rather than Perl to edit binary files in the first place. In my opinion,
that was bad advice.

> > Does the mailing list have a preference for this ?
> 
> Instead of munging pathnames z* to y*, I'd prefer to see the actual
> checksum bytes at the end replaced in the index file.  After all
> that is what this test really cares about, and it ensures that the
> failure detected is due to checksum mismatch.

I see that v8 uses a Perl script again, and it is well written and
obvious.

Just in case that certain reviewers favor length over readability, let me
offer this snippet:

	size=$(perl -e "print -s \".git/index\"") &&
	dd if=/dev/zero of=.git/index bs=1 seek=$(($size-20) count=20

Since whatever hash will be used in the future is most likely larger than
20 bytes, this should still work fine (and even if somebody sane replaces
the SHA-1 of the index with a CRC-32 for the same benefit we have now, the
test will fail quickly and it is easy to replace the 20 by 4).

Ciao,
Dscho
