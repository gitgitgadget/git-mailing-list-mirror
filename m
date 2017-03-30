Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700481FAFB
	for <e@80x24.org>; Thu, 30 Mar 2017 08:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933196AbdC3IFZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 04:05:25 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:61899 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932864AbdC3IFV (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 04:05:21 -0400
X-AuditID: 1207440e-ccbff7000000340b-cc-58dcbc3f514e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id D7.35.13323.F3CBCD85; Thu, 30 Mar 2017 04:05:19 -0400 (EDT)
Received: from [192.168.69.190] (p579060CC.dip0.t-ipconnect.de [87.144.96.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2U85GWr018556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 30 Mar 2017 04:05:18 -0400
Subject: Re: [PATCH v5 4/6] dir_iterator: add tests for dir_iterator API
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
 <1490844730-47634-5-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <a738d683-0f2d-61b9-5ecf-ef8bc8f98ff6@alum.mit.edu>
Date:   Thu, 30 Mar 2017 10:05:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1490844730-47634-5-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsUixO6iqGu/506Ewabz2haPP71ls+i60s1k
        0dB7hdmie8pbRovNm9tZHFg9ds66y+6xYFOpx8VLyh6fN8kFsERx2aSk5mSWpRbp2yVwZTyY
        8JipYANPxec/TYwNjH85uxg5OSQETCTWXbvO1MXIxSEksINJ4tf7n8wQznkmiXV/r7CDVAkL
        eEg8//MPKMHBISJgLXF9jRdIWEigXGLvq9VgJcwCNhLHm3oZQWw2AV2JRT3NTCA2r4C9xL+L
        D1lBWlkEVCX+zQsECYsKhEjMWfiAEaJEUOLkzCcsIDangKPEupOtjBAj9SR2XP/FCmHLS2x/
        O4d5AiP/LCQts5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrFebmaJXmpK6SZG
        SOjy7WBsXy9ziFGAg1GJh7di7e0IIdbEsuLK3EOMkhxMSqK8m+feiRDiS8pPqcxILM6ILyrN
        SS0+xCjBwawkwmu3GCjHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLg
        XbMbqFGwKDU9tSItM6cEIc3EwQkynAdouC1IDW9xQWJucWY6RP4Uo6KUOK8nSEIAJJFRmgfX
        C0strxjFgV4R5t23C6iKB5iW4LpfAQ1mAhosbnMLZHBJIkJKqoGxnvtf8fkqf843PulFAs5Z
        bzMOKnYrZCSJ7SkuOZw998kDc/fovUkaa5l6fNQ7l5vYK302MF16vqZvpvJkK8Md3hcuHhZ8
        rzz54maxhdqJzbvaT58MquibUfPQOcrMoNEi32TXtdsPe6daH9uc9Kphn6TJpim2+q0WBqcf
        bZkyofTw92b9KzeUWIozEg21mIuKEwE6Rka9CAMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/30/2017 05:32 AM, Daniel Ferreira wrote:
> Create t/helper/test-dir-iterator.c, which prints relevant information
> about a directory tree iterated over with dir_iterator.
> 
> Create t/t0065-dir-iterator.sh, which tests that dir_iterator does
> iterate through a whole directory tree and that post-order directory
> iteration is correctly implemented.
> 
> [...]
> diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
> new file mode 100644
> index 0000000..b4a148f
> --- /dev/null
> +++ b/t/helper/test-dir-iterator.c
> @@ -0,0 +1,32 @@
> [...]
> +
> +int cmd_main(int argc, const char **argv) {
> +	if (argc < 2) {
> +		return 1;
> +	}
> +
> +	struct strbuf path = STRBUF_INIT;
> +	strbuf_add(&path, argv[1], strlen(argv[1]));
> +
> +	unsigned flag = 0;
> +	if (argc == 3 && strcmp(argv[2], "--post-order") == 0)
> +		flag = DIR_ITERATOR_POST_ORDER_TRAVERSAL;
> +
> +	struct dir_iterator *diter = dir_iterator_begin((&path)->buf, flag);
> +
> +	while (dir_iterator_advance(diter) == ITER_OK) {
> +		if (S_ISDIR(diter->st.st_mode))
> +			printf("[d] ");
> +		else
> +			printf("[f] ");
> +
> +		printf("(%s) %s\n", diter->relative_path, diter->path.buf);
> +	}
> +
> +	return 0;
> +}
> [...]

Oh I forgot to mention, in the Git project we don't allow declarations
to be mixed with code. Apparently there's some ancient compiler
somewhere that doesn't allow it. Declarations always have to be
together, at the top of a block. (Compile with
`-Werror=declaration-after-statement` to detect this.)

Michael

