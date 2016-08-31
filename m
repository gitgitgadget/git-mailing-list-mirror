Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4AC1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 19:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754683AbcHaTvD (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 15:51:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:50817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752600AbcHaTvD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 15:51:03 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MV6EP-1bbdGH1Dkj-00YOED; Wed, 31 Aug 2016 21:50:00
 +0200
Date:   Wed, 31 Aug 2016 21:49:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] cat-file --textconv/--filters: allow specifying
 the path separately
In-Reply-To: <xmqqwpj6owgg.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608312133150.129229@virtualbox>
References: <cover.1471524357.git.johannes.schindelin@gmx.de> <cover.1472041389.git.johannes.schindelin@gmx.de> <d9e9d8b111efd161986aee32bb3ae0baec0dcf34.1472041389.git.johannes.schindelin@gmx.de> <xmqqinuqqcor.fsf@gitster.mtv.corp.google.com>
 <xmqqwpj6owgg.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eCuktN8H7BCbo4r/Y5/38m+qgPknCY2VWYxsVKKEk9g884kGPFc
 JNfWrmHPOQiTV7wo7kTzhCCDzkb820TP8wn9EE7dahyePUKZYgqnlvioYFKRQ1Tz/oKzkh6
 3B1ydCNQDhRTK6iRfZ3eHdHzOtaO/h5M+MG36IUs5vz+z8oRmdpDzfTdC62uZeUw4PNjZxG
 YwXG1bbuy4L0biWLLbptw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jDuvfkEh2ws=:KdTCV7AGmCTbZrZIpF4A6c
 2yKJpFeYU80TkUxpxTKRySyWabvdbyArzitbFEIWkThhNsc9XKr1dA2XPamjBr29H8C7ij69N
 5Fr6lghdCPWMYSV008SXMdc9JOllBOJMZq1Ew/IDWrlvcuAQbJN60Npbnd1J1FLQumGwwT5Ac
 bp6ESI1gT/oo8oQMpE6czZoH9S1f4fStXOyZTAbtGjONKXUgGZf5UzgtB38Y7W/cVzaeCZZA+
 meIsEdL+4AstDvTEnFDDuA/nVVyYCNhlMEYLOkt6+CXFevflJyk4zTmItISRTqgCI//xwa52m
 MTx0smqd2oNSJDKtVwR9xSDysiVS+/tkb0I5zKYKPnLXC8rxe0+lS2icbBheh/0wCTux0yUCv
 rFNcAx+Sp4yAxl6GHx5B9101hgmra9jsdHROfk6SmfKgLtNb8ivpAw+2cVhxbDmlnsJG60DUK
 /GMtn4xI2aSLDf0juy0w2G31O19Dw1AaHr1JMTsT7p9sFXb/yPRFn1mZUAqlEhkcDbasODaem
 5ozA3mBHifU1yjIqmSVqqtbVvPiqeujhHuhS+R7FZhdh4YZcwr6hp5sy+rHXvHpy6/JWOwsBg
 RD04LFJJui2v91q4Y01CBY2XZqwNUZuTYGQMNnXHFyINtxOjMKvKp9kyKoKQbJcl0iRRAW6HR
 ZggLp8VoyhBILxfWfEbMx0fuMI44hYqASvSVUUXW46BZZPVg8Tl5yKheYwwKl0yjcznGvW/19
 fYGmhdUrvTlAW4hgCYU4vNIkWgISRkNMTlOVjGuhlhyl8Ek3VcRMJU2XXoIP0ZNbwq4Kq4Wxz
 eAc+KDT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 24 Aug 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Mentioned elsewhere, but I think the above should be
> >
> > 	if (!path)
> >         	path = obj_context.path;
> >
> > 	if (obj_context.mode == S_IFINVALID)
> >         	obj_context.mode = 0100644;
> >
> > IOW, even when there is an explicit path supplied, we should fall
> > back to assumed "regular blob" mode, so that
> >
> > 	git cat-file --filters --path=README $(git rev-parse :README)
> >
> > would work as expected.
> 
> Actually, I am reading the conditional the other way, but the
> conclusion "defaulting from unknown mode to regular blob is
> necessary whether the user gave us a path or not" is the same.
> 
> The current code may fail if --path is not available and 40-hex that
> does not give us any context of look up is given because it won't be
> able to decide how to filter, so using "else if" would not have
> practical difference there, but conceptually it still is wrong.

Let's translate the logic

	if (!path)
		path = obj_context.path;
	else if (obj_context.mode == S_IFINVALID)
		obj_context.mode = 0100644;

into plain English.

Basically, we have two cases:

1) the user provided us with a --path option, in which case we only
   override the mode if get_sha1_with_context() could not determine the
   mode.

2) the user did *not* provide us with a --path, in which case we keep the
   mode exactly as determined by get_sha1_with_context().

Now, the change you propose would change 2) such that we would *still*
override an undecided mode with 100644, even if the user did not bother to
specify a --path option.

It is true that it is currently impossible to infer a path from a blob ID
without being able to infer also a mode. So the question is whether it
makes sense to allow cat-file to proceed on the assumption that it is a
regular file if it does not know?

I would say: no, it does not make sense.

However, I do not want to hold this patch series up just by being
stubborn.

Will change it,
Dscho
