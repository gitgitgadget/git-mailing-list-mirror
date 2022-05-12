Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468F8C433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 22:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359330AbiELWxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 18:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356737AbiELWxd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 18:53:33 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E8A2685F7
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:53:32 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id k8so5900721qki.8
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TUswqpDSt9pgVoBBortEPVwGrcP1WhVubNTSxFDdULA=;
        b=ETq4w2SfkZCG6DP93OvzpoaiPoMdMd1/Cgb0xkCUC8PEGYgZgl5+kPl5t95HT81sYx
         OCEB28lcGnzYMzrDtzfdH07DMte622xEWcAG8AdChmdz7LssGEwWwYugp4qnqpVDTwgf
         B4o5En1YWRmH1ezLqelxZWzImN9F0GCNeCkNvO+YiyVCxcoI3WQ9QCQW+Bv1uPCNZGrJ
         0XDeAtB1PqpAXDbLJeq7G8agNPVYuOrp74n8ur07YmSOnDyXg1M5RIH2D/PDOSGkZaa2
         4pdKirjKOTcsp5pxO7iuDsmPiIsXS/bAhmbjngydx8bUtbakiOQlr2Q6kSFEoMVg2n1K
         8Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TUswqpDSt9pgVoBBortEPVwGrcP1WhVubNTSxFDdULA=;
        b=b0M2Cz70zXpbHWhoBG2FSLt1IDqdxLUAl/66fap9b4cDcbD0aNw4bzuaART/ln4mV0
         iZLWnauJk8YLhscNKEv28+XGygRhGhwbExJgGsWFHWT/GKjjmmtYSESy+OIVUwdLmpGx
         ZnJMpl6HvFQiJaO+NEuX9YO9H+5WTymKf1NlTGGMIFcnIV1StH/o9AIzbdDcKQh8LWT3
         noySgCUXZaJt09kFgi8sTWyw11fPeG4QQ7zZ+Zh7ywWWhgZkcxiFu17Em6F3KbBPkAvY
         6nP4OX3IdzwtasUlQlJ631888JFs9NmfaRpyUptSE3VbHXKVsb8Ty0avZGllUt0BQGK/
         BiSQ==
X-Gm-Message-State: AOAM5302NxJw55oNLRknAACfy6olZb6KUkJi0gA8yyQ2NCuNbkSKCWRP
        RNjok/5PZoS26wQTxuIBwz0=
X-Google-Smtp-Source: ABdhPJy34/XLfhlpeAKJ9dEC30gMzK8/wEK098zRG6EyOX7ef5GC/yykarsISHXTolaJJYCMMSOl9g==
X-Received: by 2002:a05:620a:2552:b0:67b:32e2:2400 with SMTP id s18-20020a05620a255200b0067b32e22400mr1662296qko.768.1652396011391;
        Thu, 12 May 2022 15:53:31 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id g18-20020a05620a13d200b0069fd9de088esm377323qkl.93.2022.05.12.15.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 15:53:30 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] MyFirstContribution: add "Anatomy of a Patch
 Series" section
To:     Philip Oakley <philipoakley@iee.email>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
 <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
 <59af7e5e5ad84103b39ac9511791eb06b88df3c6.1652233654.git.gitgitgadget@gmail.com>
 <a901e47d-79cd-8d23-8c6c-de6299716eca@iee.email>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <bc0e05b4-f185-5aa2-ee3a-cb7278fa6ab9@gmail.com>
Date:   Thu, 12 May 2022 18:53:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a901e47d-79cd-8d23-8c6c-de6299716eca@iee.email>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

Le 2022-05-12 à 08:11, Philip Oakley a écrit :
> On 11/05/2022 02:47, Philippe Blain via GitGitGadget wrote:
>> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
>> index 63a2ef54493..22848f84bec 100644
>> --- a/Documentation/MyFirstContribution.txt
>> +++ b/Documentation/MyFirstContribution.txt
>> @@ -710,13 +710,61 @@ dependencies. `prove` also makes the output nicer.
>>   Go ahead and commit this change, as well.
>>     [[ready-to-share]]
>> -== Getting Ready to Share
>> +== Getting Ready to Share: Anatomy of a Patch Series
> Shouldn't the title also include the magic word 'Contribution'? Otherwise the change below may look inconsistent.

I don't think so. This section is to introduce "what is a patch series"
to readers that might be reading the word "patch" in a software development context
for the very first time. Patch series are how Git is developped, so the title here should
include these words, I think.

> 
>>   You may have noticed already that the Git project performs its code reviews via
>>   emailed patches, which are then applied by the maintainer when they are ready
>> -and approved by the community. The Git project does not accept patches from
>> +and approved by the community. The Git project does not accept contributions from

the next two words of this sentence are "from pull requests". People that are familiar
with GitHub will probably have heard "contributions" in the context of GitHub "pull requests",
but maybe not "patches". So that's why I changed the wording here.

Thank you for your comments,

Philippe.
