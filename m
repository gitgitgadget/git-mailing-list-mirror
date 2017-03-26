Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9186C20958
	for <e@80x24.org>; Sun, 26 Mar 2017 22:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751493AbdCZWsr (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 18:48:47 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:62502 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751380AbdCZWsq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Mar 2017 18:48:46 -0400
X-AuditID: 12074413-f4fff700000077e1-6f-58d8454bfa84
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 1F.66.30689.B4548D85; Sun, 26 Mar 2017 18:48:44 -0400 (EDT)
Received: from [192.168.69.190] (p579076D0.dip0.t-ipconnect.de [87.144.118.208])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2QMmeuO032177
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 26 Mar 2017 18:48:41 -0400
Subject: Re: [PATCH v3 1/2] [GSoC] dir_iterator: iterate over dir after its
 contents
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1490465551-71056-1-git-send-email-bnmvco@gmail.com>
 <1490465551-71056-2-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <f8beff4b-8e50-99ac-715d-549ae40bba0c@alum.mit.edu>
Date:   Mon, 27 Mar 2017 00:48:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1490465551-71056-2-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsUixO6iqOvjeiPCYPkLMYvHn96yWXRd6Way
        aOi9wmzRPeUto8Xmze0sDqweO2fdZfdYsKnU4+IlZY/Pm+QCWKK4bFJSczLLUov07RK4Mg5e
        riqYIFRx9s0pxgbGR3xdjJwcEgImErvn7WbuYuTiEBLYwSSxe/UUdgjnApPE/m1/gRwODmGB
        MIk5291BTBEBa4nra7xAeoUEyiUu9s1hBbGZBWwkjjf1MoLYbAK6Eot6mplAbF4Be4kXR36x
        gdgsAqoSO+ecAKsRFQiRmLPwASNEjaDEyZlPWEBsTgFHib+fVzBCzNST2HH9F9R8eYntb+cw
        T2Dkn4WkZRaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXXy80s0UtNKd3ECAlc
        4R2Mu07KHWIU4GBU4uEVkLwRIcSaWFZcmXuIUZKDSUmU19PheoQQX1J+SmVGYnFGfFFpTmrx
        IUYJDmYlEd7dLEDlvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ3mwX
        oEbBotT01Iq0zJwShDQTByfIcB6g4dogNbzFBYm5xZnpEPlTjIpS4rxfnIESAiCJjNI8uF5Y
        YnnFKA70ijBvB0g7DzApwXW/AhrMBDR49oYrIINLEhFSUg2M8W6JlV+aDFY0nOH3SiuccHyK
        6IJNvFUhF8LSNXIPFXTv/3V2er/Tks4npx+t5iyd87xo1qubj7kW1NxoNuXaF/G2PeTDt7Tf
        QV1/C3deP5tg6OZ3+PVZlzUhtQcjGoo0vkufqWjptTOd85Wp2up715J5V813JRir6K4w35ea
        PK2ROdhq804zJZbijERDLeai4kQA1/KzRwcDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/25/2017 07:12 PM, Daniel Ferreira wrote:
> Create an option for the dir_iterator API to iterate over a directory
> path only after having iterated through its contents. This feature was
> predicted, although not implemented by 0fe5043 ("dir_iterator: new API
> for iterating over a directory tree", 2016-06-18).
> 
> This is useful for recursively removing a directory and calling rmdir()
> on a directory only after all of its contents have been wiped.
> 
> An "options" member has been added to the dir_iterator struct. It
> contains the "iterate_dirs_after_files" flag, that enables the feature
> when set to 1. Default behavior continues to be iterating over directory
> paths before its contents.
> 
> Two inline functions have been added to dir_iterator's code to avoid
> code repetition inside dir_iterator_advance() and make code more clear.
> 
> No particular functions or wrappers for setting the options struct's
> fields have been added to avoid either breaking the current dir_iterator
> API or over-engineering an extremely simple option architecture.
> 
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> ---
>  dir-iterator.c | 100 ++++++++++++++++++++++++++++++++++++++++++++-------------
>  dir-iterator.h |   7 ++++
>  2 files changed, 84 insertions(+), 23 deletions(-)
> 
> [...]
> diff --git a/dir-iterator.h b/dir-iterator.h
> index 27739e6..4304913 100644
> --- a/dir-iterator.h
> +++ b/dir-iterator.h
> @@ -38,7 +38,14 @@
>   * dir_iterator_advance() again.
>   */
> 
> +struct dir_iterator_options {
> +	unsigned iterate_dirs_after_files : 1;
> +};
> +
>  struct dir_iterator {
> +	/* Options for dir_iterator */
> +	struct dir_iterator_options options;
> +
>  	/* The current path: */
>  	struct strbuf path;

Another thing I noticed: the name of this option,
`iterate_dirs_after_files`, is a little bit misleading. If I understand
correctly, it doesn't make the iteration process files before
directories within a single directory; rather, it ensures that
subdirectories and their contents are processed before the containing
directory. Therefore, a better name might be something like "depth_first".

I should mention that I like the overall idea to add this new feature
and use it to simplify `remove_subtree()`.

Michael

