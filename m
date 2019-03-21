Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6418620248
	for <e@80x24.org>; Thu, 21 Mar 2019 14:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfCUOs3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 10:48:29 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:54066 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfCUOs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 10:48:29 -0400
Received: from [192.168.1.12] ([2.101.244.128])
        by smtp.talktalk.net with SMTP
        id 6yzahBorhp7QX6yzahvkcW; Thu, 21 Mar 2019 14:48:27 +0000
X-Originating-IP: [2.101.244.128]
X-Spam: 0
X-OAuthority: v=2.3 cv=drql9Go4 c=1 sm=1 tr=0 a=8nsoD1t2XaTH5iSUU4dp1Q==:117
 a=8nsoD1t2XaTH5iSUU4dp1Q==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=ybZZDoGAAAAA:8 a=vZxbLtyPAAAA:8
 a=d4kOJ1WucjTr_wY9FwYA:9 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=YIznc7gRMHvxYRuyG5Sm:22
Subject: Re: [PATCH v3] glossary: add definition for overlay
To:     Thomas Gummerer <t.gummerer@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
 <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
 <f6052ac6-60c4-1e70-b3f4-571885ba9e8d@iee.org>
 <CACsJy8D48YiWYkuLW8BbeYvRz=yMmb=XWoMJroPXFAcSV2VjHw@mail.gmail.com>
 <20190309172733.GC31533@hank.intra.tgummerer.com>
 <20190312233040.GE16414@hank.intra.tgummerer.com>
 <20190317201956.GB1216@hank.intra.tgummerer.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <3d2ad13b-b5de-7e8f-9647-983e964c6303@iee.org>
Date:   Thu, 21 Mar 2019 14:48:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190317201956.GB1216@hank.intra.tgummerer.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfEf46Qp3T3UYveg+VL+29ehQ+wj5+4GAif8b2lnE8u63SkPjIUDR1GKNjmNFVPd91lB2D9bO5gbGFqKhBCjLefjrYOn3yuziHk7rIpUN8eY6XTjB97PI
 N4bYzbj+hAn95GXIrkOT+aTsbF6zuuFIZ5cnMozV/DXcOzeZst3oK1BIhPmuyCIhzHMmFMoOSmkUJ+XcmtLUVX9dYDNUv7GlnVqUHd07oqM38LNE27BFPpq+
 xSn+7gXAw7AR8UZ7aawZ9sclA4jioxus1MKOI9DlmcFJYivhPrWTmAzv4Wi5h6hSnKpAhqwIikm/pRQ1VRiJbw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, sorry for the late response..

On 17/03/2019 20:19, Thomas Gummerer wrote:
> Add a definition for what overlay means in the context of git, to
> clarify the recently introduced overlay-mode in git checkout.
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
> v3 incorporates Junios suggestions from [*1*], and clarifies that this
> only applies to checking out from the index or a tree-ish, and
> clarifies that the files are updated like in the destination directory
> of 'cp -R'.  I thought of making the same clarification for 'rsync
> --delete' as well, however I think with it being explicitly specified
> for 'cp -R', readers should be able to deduce that we are talking
> about the destination directory there as well.
As a historically Windows user, we should ensure that the meaning is 
clear to all without the otherwise helpful *nix command examples.
>
> *1*: <xmqq5zsnh7my.fsf@gitster-ct.c.googlers.com>
>
>   Documentation/glossary-content.txt | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 023ca95e7c..0f29075551 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -287,6 +287,15 @@ This commit is referred to as a "merge commit", or sometimes just a
>   	origin/name-of-upstream-branch, which you can see using
>   	`git branch -r`.
>   
> +[[def_overlay]]overlay::
> +	Only update and add files to the working directory, but don't
> +	delete them, similar to how 'cp -R' would update the contents
perhaps  s/them/any files/
> +	in the destination directory.  This is the default mode in a
> +	<<def_checkout,checkout>> when checking out files from the
> +	<<def_index,index>> or a <<def_tree-ish,tree-ish>>.  In
> +	contrast, no-overlay mode also deletes tracked files not

understanding the past/future distinction is tricky here. Maybe 'deletes 
previously tracked files that are no longer present in the new source'.

It's tricky talking about deleting things that are not there.

> +	present in the source, similar to 'rsync --delete'.
> +
>   [[def_pack]]pack::
>   	A set of objects which have been compressed into one file (to save space
>   	or to transmit them efficiently).

--

Philip

