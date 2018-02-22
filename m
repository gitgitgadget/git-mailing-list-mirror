Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6337D1F576
	for <e@80x24.org>; Thu, 22 Feb 2018 07:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752969AbeBVHsB (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 02:48:01 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:50791 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbeBVHr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 02:47:59 -0500
Received: by mail-wm0-f47.google.com with SMTP id k87so2018278wmi.0
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 23:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K8BcWMLSews8kTdN2ntDTANcgGe8GIGjAGqS3JAuQ7k=;
        b=lBbIV7wiwwOeg8IqO2efgdDD5VpAB3B7bEf3AHwS2ZxCzKn9gu2DoQzQEcdAr0UT6J
         EFJIl69I98RtrIGP2mv0Ytxda8QcePyt2y5PXkbUHgEjIwFCljzXRI3Z8lWgZ44M66N8
         CwmVHW8IBlLa/cWhh8hRirlxzIZsuYubS9lMM6Hg4Z/d0BT/kVVug5DIoSGDjstaaSZW
         kwZ04c9I7ghDmBTHNOeBUeRs6Eh081ku2z8NF+arLHMsA9fgcrgkLDe7+X5RvZECcOMG
         0Jdk+2yGc09VIGB/YBzoYtX/5f+HAyQrazr7qEv1nth2w68JZQEzbJHrye4I3XVZ4sxD
         OYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K8BcWMLSews8kTdN2ntDTANcgGe8GIGjAGqS3JAuQ7k=;
        b=YErWf//kdlBOoFP8ANT6nCZJSH4qrdwLovR/iVTF9MDmdcuEeiIcXBakyZCrQyAeK+
         xK/qKTeRqFM3KimgSKDGxJxcgstbUZUkPZHVh0htJnZ78tg3pnLa/6C6aDz93AskEpmZ
         YVlz8K2c02j8RJrTXJB8SEtvm3AZL/c5jfa+PUNPXikjfbRaMXSAlwLYZLwNjT36Rezw
         xvDs1haxed5X1dTbBESOu0bv87V7J3nvNsioRo/3q3HPEue0JjmwB0Szc/0/4DdZTXKw
         NWCQj88ufJL52PfPpiZh8E+BCQ1Pnsy528dd09YAVFVYjKHG1vcVbw2O4kfo6O29US5v
         QoYw==
X-Gm-Message-State: APf1xPAbc6aNcoxrmE8RyMtz7h3VPBwtK5PeRyP4/aAKudH7JSChCGut
        5VS6rA8aMvkAdk9yjmzWY9PYYQ==
X-Google-Smtp-Source: AH8x224aSOpe6eI7kdtsv55n6i0g4vJHBaynyIqWNWBbzKDfbK8fLCe1HsH3sVD8n1tGl4hmcRuw3g==
X-Received: by 10.80.246.143 with SMTP id d15mr8238471edn.93.1519285677774;
        Wed, 21 Feb 2018 23:47:57 -0800 (PST)
Received: from [74.125.206.16] (gate.reksoft.ru. [188.64.144.36])
        by smtp.googlemail.com with ESMTPSA id y58sm9553826edd.81.2018.02.21.23.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2018 23:47:57 -0800 (PST)
Subject: Re: test bare repository for unit tests
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <b8afa3d7-dc65-1abf-062a-a503f0c0f38d@gmail.com>
 <878tbmeyz2.fsf@evledraar.gmail.com>
From:   Basin Ilya <basinilya@gmail.com>
Message-ID: <2d901963-b66b-8f7a-a6ac-76a334aeb1da@gmail.com>
Date:   Thu, 22 Feb 2018 10:47:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <878tbmeyz2.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.
git-fast-export would work too, but it creates an additional step. I don't commit to the model repo during tests, but I do commit when I want to modify the tests.
So far, I configured core.compression=0 and gc.auto=0, created the .gitattributes inside the bare repo dir containing one line: * binary
I also created two empty .gitignore files inside refs/ and objects/

I still haven't found a way to force prune without pack after each push.

On 22.02.2018 1:53, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Feb 21 2018, Basin Ilya jotted:
> 
>> Hi.
>> I want to the test-repo-git under https://github.com/apache/maven-wagon/tree/master/wagon-providers/wagon-scm/src/test/resources/
>> just like test-repo-cvs and test-repo-svn
>>
>> Which configuation options would suit that?
>> I think core.compression 0 for human readable diffs.
>> also, I need to force loose, gc after each push.
> 
> It looks like you have unit tests that are going to do integration tests
> of some SVN/CVS repos as used by some other tool, and want to add git to
> that.
> 
> Since you have git already, the most straightforward thing to do would
> be to ship the output of git-fast-export in the repo, and have the test
> setup code create a repo locally out of that, then test it.
> 
> Or do you really need to commit the raw repo files as-is for some reason
> I've missed?
> 
