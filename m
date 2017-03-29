Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 919591FAFB
	for <e@80x24.org>; Wed, 29 Mar 2017 04:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751717AbdC2Ec3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 00:32:29 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50140 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750954AbdC2Ec2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Mar 2017 00:32:28 -0400
X-AuditID: 1207440d-041ff70000003721-0b-58db38d79a3f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id A5.E1.14113.7D83BD85; Wed, 29 Mar 2017 00:32:24 -0400 (EDT)
Received: from [192.168.69.190] (p4FEDF5D2.dip0.t-ipconnect.de [79.237.245.210])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2T4WKDw001589
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 29 Mar 2017 00:32:21 -0400
Subject: Re: [PATCH v4 1/5] dir_iterator: add helpers to dir_iterator_advance
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
 <1490747533-89143-2-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <cdcbf8ce-6641-8a96-6805-b9ff6fa0f3e1@alum.mit.edu>
Date:   Wed, 29 Mar 2017 06:32:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1490747533-89143-2-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsUixO6iqHvD4naEwce9qhaPP71ls+i60s1k
        0dB7hdmie8pbRovNm9tZHFg9ds66y+6xYFOpx8VLyh6fN8kFsERx2aSk5mSWpRbp2yVwZZxp
        fsBW8Imz4vb/OYwNjNM4uhg5OSQETCQeHr7G3MXIxSEksINJ4mb7bUYI5wKTxPWzmxlBqoQF
        fCWen37K0sXIwSEiYC1xfY0XSFhIoFzi5KYudhCbWcBG4nhTL1g5m4CuxKKeZiaQcl4Be4nz
        X7RBwiwCqhLfp+9kBrFFBUIk5ix8AFbOKyAocXLmE7DpnAKOEu8PlEBM1JPYcf0XK4QtL7H9
        7RzmCYz8s5B0zEJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsY
        IYHLu4Px/zqZQ4wCHIxKPLw78m5FCLEmlhVX5h5ilORgUhLlPWF4O0KILyk/pTIjsTgjvqg0
        J7X4EKMEB7OSCK++IlCONyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTB
        m28O1ChYlJqeWpGWmVOCkGbi4AQZzgM0/D5IDW9xQWJucWY6RP4Uo6IU0GiQhABIIqM0D64X
        llheMYoDvSLMqwBSxQNMSnDdr4AGMwENFre5BTK4JBEhJdXAGF/fdPRM148XWVXVu99tqEyM
        ubT0YS7fDpZnTwNOcQm/4Dks0+Qwa2arhnXfbt/c/zu+LnmZdD/gde1V7xS3Jw6BE3bI77ye
        fHj57sVvpQ7U8CpfnjAr/XrHbd6Ag+8OCEj7FMpuubwt+u3yhduqM1U7/hYlm6/MaXg947VA
        0Dfuhqi+dZZx+5VYijMSDbWYi4oTAQtFpP0HAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/29/2017 02:32 AM, Daniel Ferreira wrote:
> Create inline helpers to dir_iterator_advance(). Make
> dir_iterator_advance()'s code more legible and allow some behavior to
> be reusable.

Thanks for breaking up the patches. That makes them a lot easier to review.

> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> ---
>  dir-iterator.c | 65 +++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 42 insertions(+), 23 deletions(-)
> 
> diff --git a/dir-iterator.c b/dir-iterator.c
> index 34182a9..853c040 100644
> --- a/dir-iterator.c
> +++ b/dir-iterator.c
> @@ -50,6 +50,43 @@ struct dir_iterator_int {
>  	struct dir_iterator_level *levels;
>  };
> 
> +static inline void push_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)
> +{
> +	level->dir_state = DIR_STATE_RECURSE;
> +	ALLOC_GROW(iter->levels, iter->levels_nr + 1,
> +		   iter->levels_alloc);
> +	level = &iter->levels[iter->levels_nr++];
> +	level->initialized = 0;
> +}
> +
> +static inline int pop_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)
> +{
> +	return --iter->levels_nr;
> +}

`pop_dir_level()` doesn't use its `level` argument; it can be removed.

> [...]

Michael

