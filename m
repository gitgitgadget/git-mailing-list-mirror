Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C1D1F859
	for <e@80x24.org>; Tue, 30 Aug 2016 10:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757620AbcH3Kuo (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 06:50:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:51118 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753282AbcH3Kun (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 06:50:43 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0ML6XF-1bePdq0Iuf-000K9C; Tue, 30 Aug 2016 12:50:35
 +0200
Date:   Tue, 30 Aug 2016 12:50:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] require_clean_work_tree: ensure that the index was
 read
In-Reply-To: <xmqqmvjv6uxn.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608301241590.129229@virtualbox>
References: <cover.1472137582.git.johannes.schindelin@gmx.de> <4122fc996a0076c2426d5e1325f2ce2810ef4f9b.1472137582.git.johannes.schindelin@gmx.de> <xmqqmvjv6uxn.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gjoRW3p4iarNdG5zZYUKx//XFBhM32N7HA0JhHGv4n33XRY1kQD
 COoAyBvouUiwS69WZ2s3SRmzKXd4NxORMW1bUCSNRdYekcUY8yX4CGli2aiSB/vuYPaK9Pg
 l43qDvC7GZbyvT7IZ6BW7ZgAas9Td8aoGMK5XENtetEK/3yqfGXK17Iutr0+oI+sL8a1SKm
 mIWok31NtfuvjtXXjFo6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3KRm0fZ/lj0=:O0zcgWLw7lDMysKkJPgm0I
 I4EJCDD/Qdqw4eQHspb71RU8/DeIZ5UySidLxXEb6DKQq2IgCQvgKylsDIJwuF8O1zPXRrQOZ
 cfjaU5LjNEiyXpoisthsFQb5plNm5CI+0dS9cV2d4WHzEPhy6O7nxP2J8i3/k9dGJESiRLi83
 N8GHntf3Sc2UWx3Hcr1qZG/yFvTlfbL/uhSZN6sjHC7g8TSBvIy6tujTeC1LaPBgK7DkRl3M9
 +v1WrbWNr0CoP4UNN7dvcrHdt4I91mAleMnhdwA3v4p56FACUrifSE+eHT3dbjiotXtl0IFGV
 Eq7BTEuzkJc8pMhu1eX5zuunBlSejIar3aGrsn+yAyP3canOiy0H3w/woLYqevO78wbdKOp4S
 CPX1nhaqfWGAmI7qe4rY5Hj2kndm28V3wbgvlf/LMCZmfNcNiRDnNGTekqMfYys6v8a86psDH
 saxBkJ53DblaEnt7M+4zuRRHPBLnJtCKEJyE2Ogqe3df/Xi95sAiA11Nc8ssZrWTsFhzCMamE
 slWjh+mV8foOvMpaY/cD4VBF2aL6NI0B2QDwjWqMsxH2IhRHOMlOROrSW3GTQ9uMJ0FwWlx+k
 9HybYKCHnXrCgxo714gYy6We3Qa71WUzvyAPN01z0dhagsCYigoNaoF5XvAb4szaDO/o3NzdR
 zLdn8+Lh8ydcbwU9NRUukF7pV53ScbACXIWx7CJDMk06qz4o5dPQqgDf1UTpjowDYdO+SOGy+
 BIX1gu5rO82OcDWsKfex1GZ2UVOLF8NQ+7rTZW8hezi2nqkKERP5rdbk7NtvUZnCpe0+seTGh
 W4UTgF6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 29 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The function would otherwise pretend to work fine, but totally ignore
> > the working directory.
> 
> s/^T/Unless the caller has already read the index, t/;

Changed. (I also removed the "otherwise" which would sound funny
otherwise.)

> I am not sure if it should be left as the responsibility of the
> caller (i.e. check the_index.initialized to bark at a caller that
> forgets to read from an index) or it is OK to unconditionally read
> from $GIT_INDEX_FILE in a truly libified function.  A caller that
> wants to read from a custom (temporary) index file can choose to
> make sure it does read_inddex_from() from its custom file before
> calling this function, but if it forgets to do so, the penalty is
> severe than ordinary callers who would have read from the normal
> index file anyway.
> 
> Even though the word-lego issue would make this particular API not
> yet suitable, "who is responsible for reading the index" is an
> orthogonal issue that we can discuss even on this version, so I
> thought I'd bring it up.

It is orthogonal alright. So I won't act on it, but just add my thoughts:

We might want to consider thinking about introducing a more consistent
internal API. This is even more orthogonal to the patch under discussion
than just teaching require_clean_work_tree() about different index files,
of course.

It might very well pay off in the future were we to design a more unified
"look & feel" to the API e.g. by putting more restrictions on the order of
parameters, required "int" return values for functions that may fail, a
unified error handling that does not necessarily print to stderr.

Having said that, I do not have time to take lead on that, either. :-)

Ciao,
Dscho
