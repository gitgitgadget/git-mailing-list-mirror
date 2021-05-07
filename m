Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A52C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 08:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA206141E
	for <git@archiver.kernel.org>; Fri,  7 May 2021 08:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbhEGIwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 04:52:46 -0400
Received: from mailrelay3-2.pub.mailoutpod1-cph3.one.com ([46.30.212.2]:58520
        "EHLO mailrelay3-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233079AbhEGIwp (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 May 2021 04:52:45 -0400
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 May 2021 04:52:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cecilia-data.se; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:to:subject:from;
        bh=9QbZezRE8YYAH7HBZQR7qF81dBf04OdoqJMZN+dv1g0=;
        b=n4faSFmvfsVsS0/iav0+1JCDE8eo4dhxVuEOamCvP//4+/t1dd4jCbzLhon9uPpZOXAH2sOzGxUWG
         DnSBYjX2iIKF9Kv1xuy4EQekoHXghztIoPHx7ayLs3GkyxGbpCxjXHsLeLbx0iOcIoTBixNqOzCwEf
         +rphkDodc8dSfLeQWs5FMef7IXW3jaaJl1ky1P33U7GOgfnFeAVqOnQ+0x2E2UNyuvgSZ3MK53HKCb
         EeB0yV23Fx23yJh75Ft2DPDiGcN8uqTWSRmvTf2IHk+ioX96J5Cp838XJPuqlg5s476e3J+EsysDmE
         bHCaecyIwB/Ytalq3gL6AwthOlpFOBA==
X-HalOne-Cookie: 2a91685ec70940b04a9a2e112a785c3989e982a9
X-HalOne-ID: 3474979e-af0f-11eb-8cd3-d0431ea8bb03
Received: from [192.168.69.20] (c-2097e253.014-439-73746f46.bbcust.telenor.se [83.226.151.32])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 3474979e-af0f-11eb-8cd3-d0431ea8bb03;
        Fri, 07 May 2021 08:35:41 +0000 (UTC)
Subject: Re: [PATCH] doc: attempt to clarify a blurry sentence.
To:     git@vger.kernel.org
References: <pull.1019.git.git.1620319023972.gitgitgadget@gmail.com>
From:   Lars Berntzon <lars.berntzon@cecilia-data.se>
Message-ID: <38c762aa-07b3-99c6-9fa7-8cbd667839bc@cecilia-data.se>
Date:   Fri, 7 May 2021 10:35:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <pull.1019.git.git.1620319023972.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, your text is clear. I realize now I miss-read the line as if it was:

   If git push [<repository>] without any <refspec> argument is set, to 
-update some ref at the destination with <src> with....

I mentally placed the comma there and then I could not get pass that 
(and for me there was no verb there to start with so I though it was the 
git-doc lingua).

But the main problem I have I guess is that the line refers to and , but 
those comes from the ref-spec, but the whole line is about when ref-spec 
is not specified so the placeholders and are not valid. Also your 
clarification contain <src> and <dst> but again without ref-spec that is 
not defined.

Regards, Lars

On 2021-05-06 18:37, Lars Berntzon via GitGitGadget wrote:
> From: Lars Berntzon <lars.berntzon@external.atlascopco.com>
>
> Signed-off-by: Lars Berntzon <lars.berntzon@cecilia-data.se>
> ---
>      Attempt to clarify a blurry sentence.
>      
>      Signed-off-by: Lars Berntzon lars.berntzon@cecilia-data.se
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1019%2Flboclboc%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1019/lboclboc/master-v1
> Pull-Request: https://github.com/git/git/pull/1019
>
>   Documentation/git-push.txt | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index a953c7c38790..bbb30c52395e 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -66,10 +66,10 @@ it can be any arbitrary "SHA-1 expression", such as `master~4` or
>   The <dst> tells which ref on the remote side is updated with this
>   push. Arbitrary expressions cannot be used here, an actual ref must
>   be named.
> -If `git push [<repository>]` without any `<refspec>` argument is set to
> -update some ref at the destination with `<src>` with
> -`remote.<repository>.push` configuration variable, `:<dst>` part can
> -be omitted--such a push will update a ref that `<src>` normally updates
> +If `git push [<repository>]` without any `<refspec>` argument then
> +git will update the remote ref as defined by `remote.<repository>.push` configuration
> +and it will be updated from HEAD.
> +`:<dst>` part can be omitted--such a push will update a ref that `<src>` normally updates
>   without any `<refspec>` on the command line.  Otherwise, missing
>   `:<dst>` means to update the same ref as the `<src>`.
>   +
>
> base-commit: 7e391989789db82983665667013a46eabc6fc570
