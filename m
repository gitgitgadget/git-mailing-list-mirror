Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC1BE1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 13:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390023AbfFJNf2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 09:35:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41729 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389373AbfFJNf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 09:35:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id s24so3667231plr.8
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 06:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=696IGBu8Orko2UaHxPRgqLq9BabfOA6Mt2nPEeSbUtI=;
        b=XBDu3ZJdLwZsEsIPLiHB318vGMuJrz8SxqkOyqVzIZ9IgUnHGqM38ImBVuyeMMI/VR
         4s+yry1b8kI0NbY9Gq3vTJ48dUwa8RzN6nKOAKETlzWjGd8IxkCySAI7pJCFoDDdoSVE
         cZsUepZ0dEr631FaooSVVwwQ1rGFnepOjOAtgDLVi1HviamAZsZv0kdD3aP92j/T9oT0
         X8shB/ehKa9pq65J8OpF6MsAlKl0izexu+2kfQYeAjKnWCvy/2ewcq9f3oSihvsqO3sb
         wKZ8Yy9kV25Vue2hQN8tWx288u9ilFuYKEQ4/Tff6+K7Q0to1RYRK+BTFM3zI0Tgu8Uu
         8lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=696IGBu8Orko2UaHxPRgqLq9BabfOA6Mt2nPEeSbUtI=;
        b=lBIgSBbZ/pa+3vIkDfJ4UMVjI8VAvFHTJ1scv8LvC00g4MD7SEQ5z4ZWB5li6NW1ea
         AN4IN6Gkn8m8jMim3LA4cho27pdSH2Mm03B+/CPRjyI2/vjBVtmLkBwIGp0trc/H3gir
         pBpQRLtnkdsUI5cB14d1RftS7+dhUYVOh+TZuaMPRO09dCpPnzVCKHDskhy6gwLDHVKM
         6tzSXGmNGEXU/XpEvHweCvhug3WyfdPDCqHvsLKaSE30KhecC1GPtHLGotxWhVrDLWRa
         o2pO05oiNpLLOuZ3R89Kb/gbbc8lU+gJGD3OZkZ0i32UVZhgUqMweeSCprG2Iyoqru1c
         hw8w==
X-Gm-Message-State: APjAAAWuS3pU1DKiGLRiM2DWdphF79vQNcGopsoB0nJBDVx78JaToEtl
        cv1QfptRefqwI3gERvkaRK4=
X-Google-Smtp-Source: APXvYqxuRjq3hC8QjynN6T9+LOtf22IeO/eBIBDvEA7VrgMGKtrlumatSG70mKf6xJyLy+GTKebh8A==
X-Received: by 2002:a17:902:e582:: with SMTP id cl2mr55664637plb.60.1560173727564;
        Mon, 10 Jun 2019 06:35:27 -0700 (PDT)
Received: from ar135.iitr.local ([223.188.98.146])
        by smtp.gmail.com with ESMTPSA id g2sm24557193pfb.95.2019.06.10.06.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 06:35:26 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     phillip.wood123@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH 3/3] cherry-pick/revert: update hints
Date:   Mon, 10 Jun 2019 19:03:21 +0530
Message-Id: <20190610133321.7901-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <72b44513-1182-8172-94aa-ca69730d9a22@gmail.com>
References: <72b44513-1182-8172-94aa-ca69730d9a22@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip

On 2019-06-10 10:40 UTC Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Rohit
>
> On 10/06/2019 06:28, Rohit Ashiwal wrote:
>> Hey Phillip
>>
>> On Sun, 9 Jun 2019 19:03:02 +0100 Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>
>>> Hi Rohit
>> [...]
>> I think it is more about suggesting what are all the possibilities
>> you can try and not about intelligently suggesting what you should
>> do.
>
> Previously all the suggested options were viable, --skip is not
> applicable if the user has committed a conflict resolution. The idea of
> the advice is to help the user, suggesting options that wont work is not
> going to help them.

Now that I know what I should do, I'll make the change and submit a
better patch.

>> ofc, we can not use `revert --<option>` while cherry-picking.(
>
> As I suggested in patch 1 we should tailor the error message to the command.

Yes, I'll tailor the messages based on which command was ran.

>> we should not be able to do so in ideal conditions, but the world
>> does not work as we think it should). Still we are suggesting so
>> here.
>
> Yes because you have the power to easily make that change. It is normal
> to try and improve the code base when we make related changes.

:)

>> Also, I think it is more reasonable to make "this" a part of patch
>> which will cover "tailored" advice messages which is also a topic
>> of discussion as I described here[1].
>
> That might make sense, but it is a pretty self contained change as part
> of this patch.

Yes, this patch is the place where all changes should be made.

Thanks
Rohit

