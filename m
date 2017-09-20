Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9D7620A28
	for <e@80x24.org>; Wed, 20 Sep 2017 13:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbdITNuB (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 09:50:01 -0400
Received: from mout.web.de ([212.227.15.14]:65473 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751306AbdITNuA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 09:50:00 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Me6Va-1dk8tD1TOY-00PrSZ; Wed, 20
 Sep 2017 15:49:53 +0200
Date:   Wed, 20 Sep 2017 15:49:52 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/1] test-lint: echo -e (or -E) is not portable
Message-ID: <20170920134952.GA1898@tor.lan>
References: <ce17a042-91e4-bf84-d9e6-36a9e99f3644@web.de>
 <20170917054318.28560-1-tboegi@web.de>
 <20170919203714.GF75068@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170919203714.GF75068@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:AD12kmzpJ4NUxDgOW5KT+on3gIYYNiYrHo1z3kqRPX7eK5qn2Cy
 0SiUdxN+wID4nU248fd8hNc5Yh/P6N642iYLJYf3mhuyrcVQX/WQT0mlsCzm6aeVy8+qg5P
 0+D40ykr5L7qn3bM4ZfYV/qc3Nx7IQZbRFJJUVFXz4PggHr50kDjiwyVgL/4slIPgZVAIDy
 Dvh5ZOz3hxQhSGC7Tl8Zw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O3RDBXSYJoI=:JDx6Anl50XoPQ8kR0q2xNS
 XkyX4vW/9yBdht+CsZeqKdxoHtrh/ANLWCm57vMR7X/QiIV4laR0DyWw1upieUB2MhATCdArJ
 ufYVHpvOOqgdbo89a8sIJJlGs5j2sC6NlUR18PeH5/FAwJJpnvELRmqLqgigTFdFdhxyX5n8o
 g/DuHvXsFtP9yTVdeng3DNsrDa4z1QR41YAaLxTXzOlUkjaE1E3LYVOAuqgzjpYLUEaIo3uX2
 DGb+vKdCRX/KiqzZJ2n+yjDyNF4oEE3ftm/p0K1pNusDLuilY9oV+UZob+plpwf86yJmunoAA
 NMILUp9EAYBYq4W8h9oUy5cdntzoULDd2ozBkE7ChpyMEMLHNBGp7ac8ewvXHl22oTtyOva/G
 KRWRawzqhAqxnCqTLyxu0QirFiNwyS6tYG7I+R+i1UDl00scmzP4cSZB0kIunZlOQXNbpbqwo
 ERQlVbNuc26zA4ItuDkSCqg38P0epkbEs8W1ENw+RTYXcTl/+r3HxxO7iZmu/+dNO2Yd4Qem8
 w/9jy9tmV1yJSVjHiA45ZfDZlqz/IZv0J7VEDCKjB74ZGUUfFu+C1ojpAOcATYa1sIuvL7Bxn
 f6Kgp/Q5nzA0WEOZ4JxyKWAAQAsu50GCClJRxKDkt4BeTlL1N5pUXKc5Q3xIR8gitj2dhkNDa
 zM3zs7N+kfYmsbHIEtxZnyr6/nQ9CDTS/29RPIoInVJn054/q3XbU3hk/Rpf0DLqMGrfuYP2D
 pgIF9eUFzqdSdXVJGpQ2cuWYXjzldX8eYJkwIyePyteVExtGB6c1Mh126pTceOYR4fRZwdoWe
 wwP0wBHMEEUoLkPbrJ+7s4a1KEkCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2017 at 01:37:14PM -0700, Jonathan Nieder wrote:
> Torsten Bögershausen <tboegi@web.de> wrote:
> 
> > Some implementations of `echo` support the '-e' option to enable
> > backslash interpretation of the following string.
> > As an addition, they support '-E' to turn it off.
> 
> nit: please wrap the commit message to a consistent line width.
> 
> > However, none of these are portable, POSIX doesn't even mention them,
> > and many implementations don't support them.
> >
> > A check for '-n' is already done in check-non-portable-shell.pl,
> > extend it to cover '-n', '-e' or '-E-'
> >
> > Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> > ---
> >  t/check-non-portable-shell.pl | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> An excellent change.  Thanks for noticing and fixing this.
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for the review.
Junio, if you wouldn't mind to squash that in, 
another fix is needed as well(trailing '-' after '-E') :

s/'-n', '-e' or '-E-'/'-n', '-e' or '-E'
                   ^
                   

