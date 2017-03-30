Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3FD1FAFB
	for <e@80x24.org>; Thu, 30 Mar 2017 11:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933200AbdC3LHL (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 07:07:11 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:59144 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932541AbdC3LHK (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 07:07:10 -0400
X-AuditID: 12074411-4d7ff700000005a9-03-58dce6d8f114
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 9F.71.01449.8D6ECD85; Thu, 30 Mar 2017 07:07:04 -0400 (EDT)
Received: from [192.168.69.190] (p579060CC.dip0.t-ipconnect.de [87.144.96.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2UB71bm026280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 30 Mar 2017 07:07:03 -0400
Subject: Re: [PATCH v5 6/6] remove_subtree(): test removing nested directories
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
 <1490844730-47634-7-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <520a6bbb-5915-b51e-7292-ec67e3274f9e@alum.mit.edu>
Date:   Thu, 30 Mar 2017 13:07:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1490844730-47634-7-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsUixO6iqHvj2Z0Ig9dvOC0ef3rLZtF1pZvJ
        oqH3CrNF95S3jBabN7ezOLB67Jx1l91jwaZSj4uXlD0+b5ILYInisklJzcksSy3St0vgynhz
        dD9jwSruiue7OpgaGOdxdjFyckgImEj8fLaIvYuRi0NIYAeTxNQ/5xhBEkIC55kkjp4OALGF
        BfwkJjQ3AsU5OEQErCWur/GCKCmX2LH4HzuIzSxgI3G8qReslU1AV2JRTzMTiM0rYC/xeMMW
        NhCbRUBV4urzWawgtqhAiMSchQ8YIWoEJU7OfMICYnMKOEqcXv6TBWKmnsSO679YIWx5ie1v
        5zBPYOSfhaRlFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdXLzSzRS00p3cQI
        CV3BHYwzTsodYhTgYFTi4a1YeztCiDWxrLgy9xCjJAeTkijv5rl3IoT4kvJTKjMSizPii0pz
        UosPMUpwMCuJ8HI/AcrxpiRWVqUW5cOkpDlYlMR5+Zao+wkJpCeWpGanphakFsFkZTg4lCR4
        nz0FahQsSk1PrUjLzClBSDNxcIIM5wEaPg9seHFBYm5xZjpE/hSjopQ4706QZgGQREZpHlwv
        LLW8YhQHekWY9zlIFQ8wLcF1vwIazAQ0WNzmFsjgkkSElFQDY/K2gANWpU+m87U8f/POukHC
        QOeOyu7ZxxolbLbcC4w9GKsjX/xzTa5fyuH9HpNmBM55/d79RlpN5l0Pfgb+/LNydeaRJUJG
        V+9+lJ//Xkl+u56eeo75nuWXZOJ+blaUfPHksGJhN58Pg93+kpPxoc8nXdPJirxdVuTcX8Ai
        YZZzNnTu4vszlViKMxINtZiLihMBg6JJIwgDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/30/2017 05:32 AM, Daniel Ferreira wrote:
> Test removing a nested directory when an attempt is made to restore the
> index to a state where it does not exist. A similar test could be found
> previously in t/t2000-checkout-cache-clash.sh, but it did not check for
> nested directories, which could allow a faulty implementation of
> remove_subtree() pass the tests.
> 
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> ---
>  t/t2000-checkout-cache-clash.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/t/t2000-checkout-cache-clash.sh b/t/t2000-checkout-cache-clash.sh
> index de3edb5..ac10ba3 100755
> --- a/t/t2000-checkout-cache-clash.sh
> +++ b/t/t2000-checkout-cache-clash.sh
> @@ -57,4 +57,15 @@ test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
>  	git checkout-index -a -f --prefix=there/
>  '
>  
> +test_expect_success 'git checkout-index -f should remove nested subtrees' '
> +	echo content >path &&
> +	git update-index --add path &&
> +	rm path &&
> +	mkdir -p path/with/nested/paths &&
> +	echo content >path/file1 &&
> +	echo content >path/with/nested/paths/file2 &&
> +	git checkout-index -f -a &&
> +	test ! -d path
> +'
> +
>  test_done
> 

It would be better for this patch to precede "remove_subtree():
reimplement using iterators", as a slightly better proof that the change
to using iterators doesn't change the behavior.

Michael

