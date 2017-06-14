Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AF321FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 04:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbdFNEGM (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 00:06:12 -0400
Received: from mout.web.de ([212.227.15.14]:65459 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751324AbdFNEGL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 00:06:11 -0400
Received: from [192.168.88.159] ([194.47.243.242]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MAMTy-1dWVsd20Xy-00BaD9; Wed, 14
 Jun 2017 06:06:05 +0200
Subject: Re: [PATCH v3] doc: do not use `rm .git/index` when normalizing line
 endings
To:     Andreas Heiduk <asheiduk@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20170610090719.8429-1-asheiduk@gmail.com>
 <20170613221506.32732-1-asheiduk@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <dc2070f9-f76f-d569-69f0-61edb7a80610@web.de>
Date:   Wed, 14 Jun 2017 06:06:49 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170613221506.32732-1-asheiduk@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:lD4rM/+N/vv/BSa/D9XW140dwvvnKpLeil9Bzm+74rba+mVArlD
 ApKcnywJPC8dKhpihMtMApxFxK8M4Wkrn5nKBEm54Stzo2sDlCYkO8FgBeflbQAuo4afUMK
 aj1Vaa2bxRXqTuAKX2uKqf366bbY/ngKBsD2EZnxOEga6o6Y53rreeOHwzIrNC+lMXMCwZN
 HGAxIz2b/zp0UcwAz1ZWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W0vK4YMODyU=:+HioirS7T8LrBh4AuJ7cqL
 43Jg/xEfHXpQA+xj9VLLPESc0hGWu9aFJ1N0ZZsjy7KrBO/86nMLasrPJaI/GvY0Kn/+uLTaS
 oVploHC/mfh1GZXEtpLLO3R/H2/+lDHkxscIYcAhLOWiNicpvY7GRmrO5bFx8x9+KYfeqHZu2
 kooO0As5qGLAxBrSV/X6mSOqIIr6bh6gxdDi2jHVnUGmIkrKKPl5ZrVTZyuGzJ/j/MdhzNiYr
 LgQ6gPTA/VIJtNEDyCChcL7DX8XeyDpIQKJDkDvPMBgA9ZdpYFS1Ttf9hMAi8X8GjLdmkTyfd
 eacgPM6wwazGRpmneV1wa0Tg5MZVEdHyJQWjeba2vnpKNNybsx/7MURijCbrcL50k46/4Jlvy
 hYzvVhPd5+sUn9jRq2OdiGKKTsW/wNlryfSP/llTUy/8rhsu/jZLTRMF8G/etFDO5JjZW9ihl
 iJMS8v0TlaPJWRUlopRq8nn+or5xtyMUU4Lkoq6XqqOTE1giUxnGeMgqxMMW4VsgzR1fNGKu6
 VEbWeGVBj4FmWETtFwv7P5/aAvFmGVxIZBS088ls0kVPgp/pdqPdR0ut2pQ12P/uQ8IhzOcBM
 W2rEJMY2fHwmHLxty4kguKsM/eEqjyvLFgQv4A/H1lF/9UX2FdFScWIj5BERi8NH+pLBf4ok6
 mkK4Yo8WBmnsJXcdyGQF8X9we9y224XdfHJZbGgIZ/JB36CfOUrqD7Al3g7qUJiiV6Xk+Y82X
 bAKHjk2jkkGC+mGTS33pnj+kP2z9SF7QPkDyRg5whQfe6cKE5tStGakkt5OYIi7EQ5IX+knpl
 PJPLhLX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/06/17 00:15, Andreas Heiduk wrote:
Looks good to me, one minor typo below

> When illustrating how to normalize the line endings, the
> documentation in gitattributes tells the user to `rm .git/index`.
> 
> This is incorrect for two reasons:
> 
>   - Users shouldn't be instructed to mess around with the internal
>     implementation of Git using raw file system tools like `rm`.
> 
>   - Within a submodule or an additional working tree `.git` is just a
>     file containing a `gitdir: <path>` pointer into the real `.git`
>     directory.  Therefore `rm .git/index` does not work.
> 
> The purpose or `rm .git/index` instruction is to remove all entries
               ^^
> from the index without touching the working tree.  The way to do this
> with Git is to use `read-tree --empty`.
[]
