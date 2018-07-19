Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81A791F597
	for <e@80x24.org>; Thu, 19 Jul 2018 19:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbeGSTqD (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 15:46:03 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:40062 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbeGSTqD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 15:46:03 -0400
Received: by mail-lj1-f182.google.com with SMTP id j19-v6so8972701ljc.7
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 12:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e+dfGNQtgDkOrXbBO3mK7aPE1LGVWRKkHh+ed1RVhcc=;
        b=qesa0IUAGo6r5pOLMh2Uah9MNq98qbqzpx7dmBpMNiPcKE3Id9s1hDgB8PIV0Q7wIx
         2mi8ahoa3s9xCsjtwvz8VR/vOXIyVXppIlh0flKWyonjSrRY4tkNT1RNxZVTvV1XsmqH
         QhTdc3mgSWLal0wfnn/o8YArE2Cv2mRZdcajPUGwYQcS0F2HkWXxzKgNPcPPrDYkOq+1
         ywcrzRjjTA5WGjtS68zmLG4KwICxErEiWdCyRSBsZAe5Ci8+Ziy+B1PBxNuhdHPiz+as
         nN6Cgmk4QrplqWeKtllhIa0cNhkrj0kZcWdcNPK//eOfC1O3PhaKqnZo3+QM2osL8hjS
         xXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e+dfGNQtgDkOrXbBO3mK7aPE1LGVWRKkHh+ed1RVhcc=;
        b=a1HQv3o3lW+16EtkSy1lSJHwUbWmDR4YiBuNZ2FBbpe+9CKuYXXrAxG/rr4uAmBjql
         ms7EIK40OeWM7Q5rxUjdXPFQTacbx8FaelslzjXF/bfbM8kC3yRXm0D8KgfNoArXVFBf
         9CI1ChvADkL/crQ83d7GRtGMmvBYe8A0i5/qd6/W5Chrohn3J2h1axrJqlrVrbqagYHU
         +hJrSgC440MIYn5X/Tt7KCrr8kcFSdW+CTA4kWuUQhZyuYNBZ2VcNsMJGDfFzlHnzN6C
         mBE2KSl1Jfmwsq0Nbn+Qa0fyLJ+DWv4Z7VtSBJ+w5EZbO6eVU4dcmCHY/IIuGi5z6OBT
         sB9g==
X-Gm-Message-State: AOUpUlEVSrwDMH8/vR2zt4E15autvlsnhDGIo0+EBjIbOuLW0O1O0AS2
        bLTZnIRxvgqB87LAelAfQcG488oF
X-Google-Smtp-Source: AAOMgpdymF4H10yJfaFEMx468stGHpzxB22dPpyogw9FgIyLHRUerHN2erKEvUneq7sg1W0UNBX0MA==
X-Received: by 2002:a2e:83cf:: with SMTP id s15-v6mr9087130ljh.101.1532026892594;
        Thu, 19 Jul 2018 12:01:32 -0700 (PDT)
Received: from [192.168.2.2] ([213.21.46.206])
        by smtp.googlemail.com with ESMTPSA id g63-v6sm1218118lji.79.2018.07.19.12.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 12:01:31 -0700 (PDT)
Subject: Re: Use different ssh keys for different github repos (per-url
 sshCommand)
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <44d3c280-3fb2-2415-46b7-343983e76e0b@gmail.com>
 <20180719164251.GA4868@sigill.intra.peff.net>
From:   Basin Ilya <basinilya@gmail.com>
Message-ID: <966f577f-c4ca-46a4-d55d-817e84780324@gmail.com>
Date:   Thu, 19 Jul 2018 22:01:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719164251.GA4868@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: ru
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wow, thanks.

For me it was enough to configure just one rewrite, because my public github account is associated with my default key. Note that I added the missing slash and the username:

    git config --global \
      url.git@gh-org:theorganization/.insteadOf \
      git@github.com:theorganization/



19.07.2018 19:42, Jeff King пишет:
> On Thu, Jul 19, 2018 at 03:24:54PM +0300, Basin Ilya wrote:
> 
>> I have two github accounts, one is for my organization and I want git
>> to automatically choose the correct ssh `IdentityFile` based on the
>> clone URL:
>>
>>     git@github.com:other/publicrepo.git
>>        ~/.ssh/id_rsa
>>     git@github.com:theorganization/privaterepo.git
>>        ~/.ssh/id_rsa.theorganization
>>
>> Unfortunately, both URLs have same host name, therefore I can't
>> configure this in the ssh client config. I could create a host alias
>> there, but sometimes somebody else gives me the github URL and I want
>> it to work out of the box.
> 
> I think you can hack around this using Git's URL rewriting.
> 
> For example, try this:
> 
>   git config --global \
>     url.gh-other:other/.insteadOf \
>     git@github.com:other/
> 
>   git config --global \
>     url.gh-org:theorganization.insteadOf \
>     git@github.com:theorganization/
> 
> And then:
> 
>   git clone git@github.com:other/publicrepo.git
> 
> will hit gh-other, which you can configure using an ssh host alias.
> 
> -Peff
> 
