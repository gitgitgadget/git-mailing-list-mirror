Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 669FE20899
	for <e@80x24.org>; Sat,  5 Aug 2017 22:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbdHEWPu (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Aug 2017 18:15:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:65282 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751174AbdHEWPt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2017 18:15:49 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUoma-1eA0n10ceq-00Y9WY; Sun, 06
 Aug 2017 00:15:47 +0200
Date:   Sun, 6 Aug 2017 00:15:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael Forney <mforney@mforney.org>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] Drop some dashes from built-in invocations in scripts
In-Reply-To: <20170805064905.5948-1-mforney@mforney.org>
Message-ID: <alpine.DEB.2.21.1.1708060012080.4271@virtualbox>
References: <20170805064905.5948-1-mforney@mforney.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uqcJomhx2K/DLKul7/u6GWfIVKB578c5ctL8IVy9wg5QnzIYMdQ
 ne7Y6zCH63LfG+iiR4/t14wj/C7yLi7h1FuRt/k3EmpkQbwUI1PUcARORlPxdhLEnLfEST/
 +xGEumvHgSsW4M13XNiIfuy76Uu0TZ8BtHik7mGRfGU3216eSCOHqW+9YlwBJAkeUggJwNS
 Igb2RIqWI0vE/RJAMwT9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vQgxBfd/t50=:1GNY/x0o+nPR7pkrLkwm5G
 PbLJ5CXOm1KkOhXkFhCqYbjda7Zpswdkr0ThRyI56EePdq6izDA7tM4J5iAd2IRVvte4yrGvf
 LAG6oXoaIh9yx32rzoUUTGXudufXyRAylkDQu7IH5aYia4rIy5PWHb0SWgwm3BsJQdsxPrJPa
 y3RVSEqtvKZ9yKR1pRq4vefne8iPHOH6oiTAUfIo0fqxeq9m/fLMWycck2JujXaXobV9apNT0
 V4MPp0aXeT0tMSqhBp4C4LtPAwRWJpKbd1bmdAvq7tX8SYzeRBHC2D7OrLLbN9tKzLcucpB9N
 MeDcuGENQz8fBULTZ/8ecyC1eDT18XeDZEnt3q7AJAAsrgO+BqaowPgSw+cXWvPmFZ/DiuC0b
 pkjQ0VVWmYDlmDcRV4/XqFCE59Spedu511981Mm0Y7wTAB54J00D4oqFWABeuKNrSNv8j0SSi
 mrEw2QqX0PZENLFM6m8grFWgJD+eNPCUaTNj1qDhKmNYzRyF4wFCCeUxVXUl9LO11KF8UswGF
 ZnpcbHgbWWaH4Ittsq0uD3fyDAXqxiQ+ZH6rw+P8Bth0sszPnPplLEH9hLLKz+OO3ReG8mzYq
 9zfqpFkIYNP4gV/oyvrEWi+DXAHZMdtkCJxCSrUtLqWc9Vx2mnE6/9Qy6sMoApR6QM4LH2iD2
 fVEo6XlsOc8eQLF2xyMmL6jpOgb3uI941Nib0lQ1u+fGOKEOUrybwv1Hbws7fmDPbQxDfOtGz
 2Myhy9Z7HkKqm1Y6Rqg536kz/nbR0PILgGGgdoqaFs3aLeaQ+KRRDPFI7GaLHciO5R0wta+Dp
 rX2IDlaxjmDrssBcH0SMDmYJ1SAzeXBp9SIlPNIP4XL3erN7zE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Fri, 4 Aug 2017, Michael Forney wrote:

> This way, they still work even if the built-in symlinks aren't
> installed.
> 
> Signed-off-by: Michael Forney <mforney@mforney.org>
> ---
> It looks like there was an effort to do this a number of years ago (through
> `make remove-dashes`). These are just a few I noticed were still left in the
> .sh scripts.

I am very much in favor of this patch. It also helps with things like
building Git in Visual Studio (where hard-linking builtins is not part of
the process).

See also
https://github.com/git-for-windows/git/compare/2006e3973ce6%5E...2006e3973ce6%5E2

Thanks,
Johannes
