Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C8451FF72
	for <e@80x24.org>; Mon, 23 Oct 2017 11:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbdJWLJ1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 07:09:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:49235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751268AbdJWLJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 07:09:26 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWxtA-1djT9U21lU-00VwDX; Mon, 23
 Oct 2017 13:09:16 +0200
Date:   Mon, 23 Oct 2017 13:09:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Joel Teichroeb <joel@teichroeb.net>
cc:     git@vger.kernel.org, t.gummerer@gmail.com, peff@peff.net
Subject: Re: [PATCH v3 0/4] Implement git stash as a builtin command
In-Reply-To: <20170528165642.14699-1-joel@teichroeb.net>
Message-ID: <alpine.DEB.2.21.1.1710231308200.6482@virtualbox>
References: <20170528165642.14699-1-joel@teichroeb.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bdRn8V7H1Or4vVM0b+utfL5zRHvJ23QsyUiBcLSXljf6UPSimKv
 vfyZjMNpTHvAm7FEhCyOfVA/aSpGs2TXoyB7KFVqef3Fsg2C8UsRUqgeBEA6+7aDgXWWTnr
 K8DKNa3qXKO5ZHgCbZDYXCdhyXhShMA9ClJ3cM4b4DmyDzoqCP8+nD+g8/j3d0b8X4/usEN
 AqAqOVCEpGFo2LXgXfg6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rd+to8p/je0=:ggOiE52B0UwwBJ0Cg/Pwgq
 dblUxDkSsu3ZWeCZoloMZbKXbe+9+NkOitneMMRZVX5dIHoblqoUaCDB3xru5WKh8f4q9DFNb
 FFPlRijxuYg7rvOu6JZdQ7zZrmlLWv4nTCgwMlCLwviOGtpKbGK/UUuREeuHWbSLbACHnjlk6
 ARDKdS18HM1Tee7iT4S5ClobdYF6fGvFKF9e0ZH0dFk9tWGt3gbIDAu3HkNbXRJ9+OswMCPhF
 MVL5xCkkDt7AL5eTvYNcsohPf2ZfZ2wam5gf1EOeKd1K20hnQdcilnx6d7XOJX0vA1AX2O+RU
 EibT5BRc8nVlNhjM921MB55gNv05svsg/nvqpe1ggYzqCH5jJ8TNThOP/xsfbwbqkNrvA5Hla
 Otz2z34aO7sr0e/f4VgoDa2YFnyl1TBwAmyIhmetWVkVDN2hh4+vnXpJjIAXWCJwDxJ1GSYY3
 PDIDD7GM3b4J+gacmR40+7QUkDC4YENTySmxyt7/MgIKiCcqU419WJBRhRYmEei6zURBUBvN6
 i8lONglAGGWiG8YUWqLLre92h8kQw8dL3DDaPZzptujyYV9HCvRKBQrqqkVfVUalH1eLzQ9ie
 7Q0zK8vicxOs+vG9piBoJ8ADRltWz8wiilU5Mkf8w+3IFKcNyHxP7QdQz+5BewEvIM1AQKok6
 wi8GaL4uVjqDRSCMsF2Wjg0b5GwL44gQ1ai9Nwf3AowcM7p5Fok6UbIBxFAQrouVsoY9k7sM+
 SDgLojSxX0FLhlG6gU6DqT5aHD4DKZYgK0M1k/QVEXHOG6KPH2kGrdIL5Ki8UeMnnHej9b3Tj
 yjbTyT08udU+bkOq9rnrnfE8ZnEO3Syhzrf5qEzizzuJyqpjtHFLbyrvcgtR3gLdPuzB0hS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel,

On Sun, 28 May 2017, Joel Teichroeb wrote:

> I've rewritten git stash as a builtin c command. All tests pass,
> and I've added two new tests. Test coverage is around 95% with the
> only things missing coverage being error handlers.

I am embarrassed to say that I never found the time to have a detailed
look at this, and it has been 5 months since you sent this. Sorry about
that.

Do you have an easy-to-fetch branch with this somewhere?

Thanks,
Dscho
