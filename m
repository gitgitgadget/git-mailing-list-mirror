Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DFA31F89D
	for <e@80x24.org>; Fri, 28 Jul 2017 13:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbdG1Nky (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 09:40:54 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33176 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbdG1Nkx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 09:40:53 -0400
Received: by mail-qk0-f194.google.com with SMTP id d145so18557706qkc.0
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iBOPgYdSyZOR8aHrY7BJoT64a4n2GomIpcAuNAVGFDk=;
        b=Ky/UtVuLHNKZ2dq8/xlyZ0H320C+lZTiarLydkwNPTkRrtQSOkYjYYRN3cdjInQTII
         lbBE3+eyGlyENArSB4VjcpnVFIFbeWOXFBy+tcYa1kJP+RaKv/IH+U4fYQfMfj5kp6Wq
         wKkJfHx9MLrkEg3z8rBfzCHRd7rlL1IoKv0pNqMgdGwGlqLDdz4/5KSMFyfeBoPekP8D
         A2+Z869zj72bLa7Dlidhkazkkq5xNGhC3eIcpLy0tjIKu556p1XpDtoD05V2SSytrW/v
         TN7MIkZlFbhayKyolki1+1BzBhRwjtY5Bs9xo3jJzRPaPyfHefHSH3LNsfcQg+pr5FpJ
         J2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iBOPgYdSyZOR8aHrY7BJoT64a4n2GomIpcAuNAVGFDk=;
        b=VcEdElKHRbKZjqJWjEAMhSceC4CD9rsubEYzrvJgsNVi/nvqRD8MddQpWdt/lL6l9c
         Yx5uLreRCXpkaEOf1wh1NSUnIHEIuJ3VXI4G8Nj9B7z9lKqaAMCFjL6b1RQcii103Wqd
         OKr7O97cgUUxQ8PWLBWQfoR22BHxBOZ5xzQwegxSvE2cvDoCikL3hYhqGPt94C65Iwf4
         AzoUVzf5Wg4iPSIIPWC7oRx3+Q62PAxZtphUA7LJHRMIf7e7QeYLm4FMI+7CfES3TrQM
         B8dwW07/PSu97vULKhOD0CMw57StGGCWSnlwCTA38QIVhQ665QgXb9aK/IoLA80WHO1S
         k1Dg==
X-Gm-Message-State: AIVw113n3vZiZljVIpR6R8op0kbd7pLggfE8WNkd/9l6/EzGtzT1whFa
        JwNOk860y6V1Zw==
X-Received: by 10.233.239.1 with SMTP id d1mr10406791qkg.126.1501249252394;
        Fri, 28 Jul 2017 06:40:52 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id d17sm7746226qta.36.2017.07.28.06.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2017 06:40:51 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] Some patches for fsck for missing objects
To:     Jonathan Tan <jonathantanmy@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, christian.couder@gmail.com
References: <cover.1501111615.git.jonathantanmy@google.com>
 <20170726234238.2osugw2lheubmetw@genre.crustytoothpaste.net>
 <20170727102547.0c45a8db@twelve2.svl.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <8c2266ad-586b-109e-1f99-a2315aa94c75@gmail.com>
Date:   Fri, 28 Jul 2017 09:40:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170727102547.0c45a8db@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/27/2017 1:25 PM, Jonathan Tan wrote:
> On Wed, 26 Jul 2017 23:42:38 +0000
> "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> 
>> I looked at this and I like the direction it's going.  It's pretty
>> simple and straightforward, which I also like.
> 

ditto, simple is good!

> Thanks.
> 
>> What I'd recommend is that instead of making lazyObject a string, we
>> make it an integer representing a protocol version.  We then add a
>> different config setting that is the actual program to invoke, using the
>> given protocol version.  This lets us change the way we speak to the
>> tool without breaking backwards compatibility, and it also allows us to
>> simply check the lazyObject script for supported protocols up front.
> 
> That's possible too. As for version negotiation, I think we'll end up
> using a protocol similar to the clean/smudge long-running process
> protocol (as documented as gitattributes), so that does not need to be
> taken care of here, but making lazyObject be the version integer is fine
> too.
> 

I was also thinking the way to retrieve the missing objects be a 
versioned negotiation via the long-running process protocol.

That said, I'm a fan of including versions to make our life easier later 
if we decide to adopt an entirely different model for retrieving the 
missing objects.
