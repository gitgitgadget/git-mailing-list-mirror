Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3660F2013A
	for <e@80x24.org>; Fri, 17 Feb 2017 09:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932863AbdBQJ0X (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 04:26:23 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:55074 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932741AbdBQJ0U (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Feb 2017 04:26:20 -0500
X-AuditID: 1207440f-129ff70000003517-cc-58a6c1b8ab77
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id F4.48.13591.8B1C6A85; Fri, 17 Feb 2017 04:26:18 -0500 (EST)
Received: from [192.168.69.190] (p4FEDF52F.dip0.t-ipconnect.de [79.237.245.47])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1H9QE83022977
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 17 Feb 2017 04:26:15 -0500
Subject: Re: [PATCH v2 14/19] hex: introduce parse_oid_hex
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20170214023141.842922-1-sandals@crustytoothpaste.net>
 <20170214023141.842922-15-sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <dc402492-8b69-cf43-22d0-e4ec3af04e8c@alum.mit.edu>
Date:   Fri, 17 Feb 2017 10:26:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170214023141.842922-15-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsUixO6iqLvr4LIIg1UfTCy6rnQzWfxo6WG2
        aJv5g8mB2WP5zb9MHs969zB6fN4kF8AcxWWTkpqTWZZapG+XwJWx4N4B5oLvfBV9p8+xNzD+
        5+5i5OSQEDCR+LrwB1MXIxeHkMAOJomFh+exQDjnmSQu3NnIAlIlLGAl8X/mLXYQW0TAS2L+
        oxmsILaQQI3ExnX7wOLMArIS61f8ZQSx2QR0JRb1NDOB2LwC9hILbh0BquHgYBFQlbjXJgUS
        FhUIkZiz8AEjRImgxMmZT8BWcQq4SOy+848FYqSexI7rv1ghbHmJ7W/nME9g5J+FpGUWkrJZ
        SMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10cvNLNFLTSndxAgJUf4djF3rZQ4xCnAw
        KvHwZmxfGiHEmlhWXJl7iFGSg0lJlHfRtGURQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR41fYB
        5XhTEiurUovyYVLSHCxK4rzqS9T9hATSE0tSs1NTC1KLYLIyHBxKErwqwFgUEixKTU+tSMvM
        KUFIM3FwggznARpuADa8uCAxtzgzHSJ/ilFRSpz3+QGghABIIqM0D64XlkJeMYoDvSLMO3M/
        UBUPMP3Adb8CGswENLgzYinI4JJEhJRUA+OEKE93i2f5f9Y4GEyKUtl2v+Sk9qtFMY1zH95j
        eZEb/nJTnuKP/qcnbvDybvFP1Vl1KCpJU0zsyHKPLzuyL9+eq3tCL3Svw2y/a8ItNXf7El6t
        jjp1ueT4FrE5nt8XPVviPN2Ba8W021V7zdmjO/bVqggHnGo5+Ub9SJUbs6Bucujb4+nJoSlK
        LMUZiYZazEXFiQB2RTep/AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/14/2017 03:31 AM, brian m. carlson wrote:
> Introduce a function, parse_oid_hex, which parses a hexadecimal object
> ID and if successful, sets a pointer to just beyond the last character.
> This allows for simpler, more robust parsing without needing to
> hard-code integer values throughout the codebase.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  cache.h | 8 ++++++++
>  hex.c   | 8 ++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/cache.h b/cache.h
> index 61fc86e6d7..5dc89a058c 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1319,6 +1319,14 @@ extern char *oid_to_hex_r(char *out, const struct object_id *oid);
>  extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
>  extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */
>  
> +/*
> + * Parse a hexadecimal object ID starting from hex, updating the pointer
> + * specified by p when parsing stops.  The resulting object ID is stored in oid.
> + * Returns 0 on success.  Parsing will stop on the first NUL or other invalid
> + * character.
> + */
> +extern int parse_oid_hex(const char *hex, struct object_id *oid, const char **p);
> +

I like this function. This is a convenient kind of interface to work
with. A few minor comments:

If you rename the nondescript `p` parameter to, say, `end`, its purpose
would be more transparent. Alternatively, `skip_prefix()` calls the
corresponding parameter `out`.

It would be nice for the docstring to mention that the object ID must be
a full, 40-character hex string. Otherwise "Parsing will stop on the
first NUL or other invalid character" makes it sound like the function
might be satisfied with fewer than 40 characters.

Finally, you might mention the useful fact that `p` is only updated if
the function succeeds.

> [...]

Michael

