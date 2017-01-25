Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E481F794
	for <e@80x24.org>; Wed, 25 Jan 2017 18:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbdAYSif (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 13:38:35 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:35098 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751513AbdAYSid (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 13:38:33 -0500
Received: by mail-it0-f41.google.com with SMTP id 203so115056074ith.0
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 10:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hR8GpfhATQX+fM6NKGbvkebDdpwRd+dYNsL/Ti6yErg=;
        b=VJ3qVlZdmJeJxJEx0EtQm0bHZaMiI12Q7P3UxkRb+q3KdZb4s8Ke10I4k3RERmiAJh
         GqdIcGCrv9EXWNLqXhvc7XufFW3cV8g7s6XL9HbF4fQYoNfL/V0gV8TGHJNngCjLfLtq
         Lp5+Z9ad5LH8Hne+gD6JYPtMT95qkALo/rkVpzhlpo/T5AgEwZ0AX8QVL/hYcZudHscE
         9MZorKuCtfjXDl7IrnxHYNq0gDfoL1JU2j9LtaCn1L+GCL2BC+3G0WeGDqiL6xXoY9ir
         cwJU8yGKW385NAcu8DC3/5G4Vw/g0gpjLxdB8x+rspnQtA0T3UAiWoAjjCScESCbtNAi
         JQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hR8GpfhATQX+fM6NKGbvkebDdpwRd+dYNsL/Ti6yErg=;
        b=oK/kBy3u8OiXFelg8BkimOtkvC9tyz35Cssf1q8ICFm2oxtc1ERslfGSHy/VsWEoeQ
         XzbEhhZlUJ3BplRf5TEWhmhq12UOIsvpyGKzTDeOcobuBUJDBGkFJWilo+uTa4UDIQEJ
         3D+v5Hm6HaG+BMYBapxll3wL2eiE1GXf0lJGG4qc02irpBPAPg2B/aSoKO6Lg9+ozaOR
         bU46pFDxVwZAE/KOTW3iG93LwhlJWksjAAgVEctRv58EDAdhUQP/6re7wNtSRLxyb4DJ
         Um6tO7wYFHIveWhQT4xDI2oD9KRHpuoh4wZqLMSwFc+qyBzm8r4SPploZjj2fNthDfxt
         Ca2A==
X-Gm-Message-State: AIkVDXLcrrUYOWjae/7kdfCIJsQ8OV7FmtdXVopu8d+7rGfifySjPtNywZicF4yG1Jg0TbqRvEmqp6/213WYCxLQ
X-Received: by 10.36.169.12 with SMTP id r12mr25885728ite.69.1485369512971;
 Wed, 25 Jan 2017 10:38:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 25 Jan 2017 10:38:32 -0800 (PST)
In-Reply-To: <xmqqo9yxpaxk.fsf@gitster.mtv.corp.google.com>
References: <xmqqo9yxpaxk.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 25 Jan 2017 10:38:32 -0800
Message-ID: <CAGZ79kZKDyfP1SPsxAf8oMSU3763QiogLpUzFZHy+OTQQdJP6A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2017, #04; Mon, 23)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 23, 2017 at 4:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> * sb/unpack-trees-super-prefix (2017-01-12) 5 commits
>  - SQUASH
>  - unpack-trees: support super-prefix option
>  - t1001: modernize style
>  - t1000: modernize style
>  - read-tree: use OPT_BOOL instead of OPT_SET_INT
>
>  "git read-tree" and its underlying unpack_trees() machinery learned
>  to report problematic paths prefixed with the --super-prefix option.
>
>  Expecting a reroll.
>  The first three are in good shape.  The last one needs a better
>  explanation and possibly an update to its test.
>  cf. <CAGZ79kaHDnVLQr8WLoaD5KKs7EqeW=KbkptF=iHpU5t054Xcdw@mail.gmail.com>
>

Please see
https://public-inbox.org/git/20170118010520.8804-1-sbeller@google.com/


>
> * sb/submodule-doc (2017-01-12) 3 commits
>  - submodules: add a background story
>  - submodule update documentation: don't repeat ourselves
>  - submodule documentation: add options to the subcommand
>
>  Needs review.

The first 2 commit are asking for the standard review, whereas the last patch
(submodules: add a background story), needs more of a design review/opinion
if such a patch is a good idea actually.

Thanks,
Stefan
