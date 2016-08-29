Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2C41F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 11:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756705AbcH2LYc (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 07:24:32 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33459 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756125AbcH2LYb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 29 Aug 2016 07:24:31 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AC9E720372;
        Mon, 29 Aug 2016 07:24:30 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 29 Aug 2016 07:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=NtNuGVkGAN+IN8Na6JgQ3crqB2w=; b=QfNIwz
        MhE1pPZrvCwpKacwXkYnzyaOL9Xv4JECBbA7qaGef1erKD3JPc1vsb5LYm2kMk68
        EqrLRAEiY72ZtZQxulDWu40CVTrP6nQ6O4k8s747AjTrvFcZ81/ILeAH6Lyq5mjs
        E8mljC3cvVA2w9y2ftmaVnFQAfiVKxPvPguxc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=NtNuGVkGAN+IN8N
        a6JgQ3crqB2w=; b=iL1ADBi5R9pyqojAv7N+F96mHhp4WZujWujOxmCgFisJU82
        McEKrwMy5Foi4OjI1zi67QJ+vZMk+1r7iRDGVTqvPgmo8KK3zJs7yZOelD3k3Z3g
        4tgm6jcDoPT3GJlt5N6wzVVsZng+dQW411rnNGKWijiFud9WeAn0m+mSykDc=
X-Sasl-enc: tjj53/v0AdIJYLCG8MbjJxhg1P2Uzm/ioajbYZO7+3Ss 1472469870
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id EC34CCCE7C;
        Mon, 29 Aug 2016 07:24:29 -0400 (EDT)
Subject: Re: [PATCH] Documentation/SubmittingPatches: add quotes to advised
 commit reference
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20160826222714.31459-1-sbeller@google.com>
 <xmqqk2f3duf2.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net, dev+git@drbeat.li
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <389d314d-5f68-b195-3268-4234440ca4ba@drmicha.warpmail.net>
Date:   Mon, 29 Aug 2016 13:24:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqk2f3duf2.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 27.08.2016 00:42:
> Stefan Beller <sbeller@google.com> writes:
> 
>> Junio finds it is easier to read text when the commit subject is quoted.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  Documentation/SubmittingPatches | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
>> index 500230c..a591229 100644
>> --- a/Documentation/SubmittingPatches
>> +++ b/Documentation/SubmittingPatches
>> @@ -123,7 +123,7 @@ archive, summarize the relevant points of the discussion.
>>  
>>  If you want to reference a previous commit in the history of a stable
>>  branch use the format "abbreviated sha1 (subject, date)". So for example
>> -like this: "Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
>> +like this: "Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
>>  noticed [...]".
> 
> Thanks, but it is not sufficient as you would not see the need for
> quoting without the example.
> 
> My preference is not a main deciding factor in this case anyway.  A
> more important reason why it makes sense to quote (aside from the
> fact that it makes more sense when reading) is because we already
> have a tool support for that.
> 
> Perhaps something like this instead?
> 
> -- >8 --
> From: Beat Bolli <dev+git@drbeat.li>
> Subject: SubmittingPatches: use gitk's "Copy commit summary" format
> Date: Fri, 26 Aug 2016 18:59:01 +0200
> 
> Update the suggestion in 175d38ca ("SubmittingPatches: document how
> to reference previous commits", 2016-07-28) on the format to refer
> to a commit to match what gitk has been giving since last year with
> its "Copy commit summary" command; also mention this as one of the
> ways to obtain a commit reference in this format.
> 
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  Documentation/SubmittingPatches | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 500230c..15adb86 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -122,9 +122,14 @@ without external resources. Instead of giving a URL to a mailing list
>  archive, summarize the relevant points of the discussion.
>  
>  If you want to reference a previous commit in the history of a stable
> -branch use the format "abbreviated sha1 (subject, date)". So for example
> -like this: "Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
> -noticed [...]".
> +branch, use the format "abbreviated sha1 (subject, date)",
> +with the subject enclosed in a pair of double-quotes, like this:
> +
> +    Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
> +    noticed that ...
> +
> +The "Copy commit summary" command of gitk can be used to obtain this
> +format.

or (an alias for) the command

git show -s --date=format:%F --pretty='tformat:%h ("%s", %ad)'

>  
>  (3) Generate your patch using Git tools out of your commits.
> 

