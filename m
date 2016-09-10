Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB1751F856
	for <e@80x24.org>; Sat, 10 Sep 2016 07:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753754AbcIJH7U (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Sep 2016 03:59:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:56582 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753005AbcIJH7T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2016 03:59:19 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LkBPy-1bAwKj0muw-00c9Bi; Sat, 10 Sep 2016 09:59:03
 +0200
Date:   Sat, 10 Sep 2016 09:59:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/4] cat-file --textconv/--filters: allow specifying
 the path separately
In-Reply-To: <xmqq4m5pc5hx.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609100958160.129229@virtualbox>
References: <cover.1472041389.git.johannes.schindelin@gmx.de>        <cover.1473415827.git.johannes.schindelin@gmx.de>        <9e01395c0732b47b382d2363a2ef6f4bf361666e.1473415827.git.johannes.schindelin@gmx.de>
 <xmqq4m5pc5hx.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wP9sL6UgPpkgi5DShSg5apuixhCLQ4DwStiD0uLvhsdWjoL25zR
 l7uGbrpqP8rIaxCQHq5WgdfKVnySJxO51jopKuJGhI4bnNDMoN9TEgaUEQoP11/3dlDhZcY
 ueTTUwwbloOWjPJLD0IwSfkq8ShlGsiAh1Nsc2XshhAZ2hr4VLs78SXk+j+CQlzRnhtz1AG
 g9rNo0urLnHbgKLhgHGdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m6thf3lRKwg=:8ZVy11JY5e5MwDjL9Blasa
 UbXAiFYMhUObMLZ8vv3xTIIpcJEiu9dVrRFMevoP2WBpqSjcwhO4YPbTlDzPjj+TmyupiEWp9
 sX2GTxfcqbFC8WJfoXd4zojTGLFqe/ZK+RhVkBkgKbfZFfM8Y4TE3Qd9LdCMjY36WOe6EWB0k
 DRJrN/oxxL39t7J+zA+HTMhjiwP75IbO0Pwt6mWM8syWKq2f3efuT13Ie4zR5nqK/manxaQLI
 7bRi21YFvcShhHY1t69WqYzZGP2y6jq+XAITV5PCA68gTNJNqF2Ixj4XkBYAQpJuq0GIB1ng8
 HT8dRWvCpK1gcr0y6fVCP73g2zOpuNVUlYBDg4IZFj5Pg4vAIzVkYqAVqDXiZZp8Czrf6WXe9
 KLSd7iM/NXmsfJwYUTlLfJhEnOevuh3hmp/s4/LTyAgBRYzM/bfYFCtl+t8uwi/Yo80rVsVa0
 AMf7dlibkjxgvbLJfRGVF1IFquYj4IqLBZr+MOyIYOHeXQ5l/xO7BIwf3N1+Ugan0NrkQDOc+
 9htXOWzrbjx9Y3L3o83RZee1BMkjB++l2MOtvJGFoPp1p21KhwMqgIflitr3QVWyuWTetlTdf
 8W/jQrC1suD8ICxnHBV+suiL3u/AN6W2st7BG1wm/hP5Y4SaSp/gWjKqVpNMauPJTp6EhXE6h
 vbiJMkNz5UDE0zuQ6VPoAi0/5wc1gzvKadwRgYDJzbXnEcS3ww8bFHcj/PGtFmiLS1fh5bgsJ
 B+w/szLeBdlIUO/XcWH+5TQ7PZeVRh1Viu7n1XgZVWllTtuJV2X4nvV3JpTihTCp2OB00it6f
 LAhLDZL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 9 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > +test_expect_success '----path=<path> complains without --textconv/--filters' '
> 
> I wonder where this "----path" came from; it wasn't in v2 I queued,
> but somehow came back mysteriously.

No idea how it crept back in. Sorry.

> Will locally amend.

Thanks!
Dscho
