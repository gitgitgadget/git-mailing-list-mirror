Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D1191F4DD
	for <e@80x24.org>; Thu, 24 Aug 2017 05:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbdHXFvC (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 01:51:02 -0400
Received: from mout.web.de ([212.227.17.12]:52287 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbdHXFvC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 01:51:02 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWB8f-1e4jgc2fzV-00XM4G; Thu, 24
 Aug 2017 07:50:55 +0200
Date:   Thu, 24 Aug 2017 07:50:54 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Ben Boeckel <mathstuf@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] Documentation: mention that `eol` can change the dirty
 status of paths
Message-ID: <20170824055054.GA32617@tor.lan>
References: <20170822174918.GA1005@megas.kitware.com>
 <20170823211741.9633-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170823211741.9633-1-mathstuf@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:TdemOw34SuqKWiY871+P+owY2KDPO6ZMmQ/REMy2zCe9rrIf84j
 eYRkL96KklxjJAn2b+92Hc0IuFrhHsesKTfOBja5m3kwm7y0XclDqxJN0ahahE9234PkXnA
 k+Xlr+LgHZs+tOn0o+bGFc758cVkCCsZ7OZD8YIqJDaWqLai2a5KuqJdYMplvbu8vR+KnUh
 zPzPL3XfQ7Ft/AqEzopuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WoA3hz2Mcmw=:MSa8EO++4HzJ+uD8ecStkm
 RKsjhAxoymEcdwhUZj9mGnORfPNYFEZab2R35bIq4bXFQ1b2wyXRJUftjiBCY0wEI3P+52NJV
 ATQkIfpu83Zb+37FDD22jnZP8hSh4v83eulkz8G339UzR1PVq0SB3yK/vsxWZioXwa19yDFkE
 /JsnR9syTwJ2EUwSDS/PpbtS0S/S4bEB6b3YXFGhJHGtgK8Lgm0WLip7b9qKLXUi6CyGZyXlL
 T7E9ifhumsL6syW7qWKktZh/EIAhUcDCcE/zovLRVX21e16JDPzCw6FmoaTJBJpYEzKozAKyD
 dWuDUie9Mc/TnfMWBCIv5/sLhoMiTL1WbBRFbo3XlNS6FfNxWbxHygTzy7SJ/Gwb6afaxjdRd
 fihXTYYKQTUaBD/n7NvCN1sXgTJO4KRka5QjqYGnmyxD1HsvueiNdJWz0AGOVXkPJOpm7IRoJ
 KsZY/05/TflFkj285sxwHN8FuyJb+M4S6efZia8u+n8bmFHBwSfcSJL5fmdJnFgGTBNG5n6Ja
 jy4PWheq4cJjENknVYNsXI2KGvuqcJ5BTIMumIOrXjtBQHmdZklgInOw0DA9G7/pe1FMoOUIb
 5KqYCFGNhZygcjYpc5me4UGfbMGHVpktiWcuwliWLcnMvcZ2BDSAd4bvrVN2p+4iUpckipzDe
 e0rVDrGL+8GJHeboE/0/q0ahwWAf0qRzzA3IfLVkaT1G0fMM0OGWloZTbVZk+Xt31GglIS9r/
 mxZPOaBuHOW6vFgW4dsCJ798qOBD5QyOvImdyMrG/huLvW6yw/x6jDsOkdryhkBKSvtFIvdYC
 kotkWUivXv4gkXXOjEJy5Al4utXow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 05:17:41PM -0400, Ben Boeckel wrote:
> When setting the `eol` attribute, paths can change their dirty status
> without any change in the working directory. This can cause confusion
> and should at least be mentioned with a remedy.
> 
> Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
> ---
>  Documentation/gitattributes.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index c4f2be2..3044b71 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -151,7 +151,11 @@ unspecified.
>  
>  This attribute sets a specific line-ending style to be used in the
>  working directory.  It enables end-of-line conversion without any
> -content checks, effectively setting the `text` attribute.
> +content checks, effectively setting the `text` attribute.  Note that
> +setting this attribute on paths which are in the index with different
> +line endings than the attribute indicates the paths to be considered
> +dirty.  Adding the path to the index again will normalize the line
> +endings in the index.
>  

There is one minor comment:
The problem is when files had been commited with CRLF (regardless what your
eol= attribute says)

How about something like this :

  This attribute sets a specific line-ending style to be used in the
  working directory.  It enables end-of-line conversion without any
 -content checks, effectively setting the `text` attribute.
 +content checks, effectively setting the `text` attribute.  Note that
 +setting this attribute on paths which are in the index with CRLF
 +line endings makes the paths to be considered dirty.
 +Adding the path to the index again will normalize the line
 +endings in the index.

