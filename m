Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A367B2095B
	for <e@80x24.org>; Sun, 19 Mar 2017 00:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbdCSA6E (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 20:58:04 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33007 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdCSA6E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 20:58:04 -0400
Received: by mail-lf0-f67.google.com with SMTP id r36so7784639lfi.0
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 17:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/NXy3DDOssW0/c+t8sJIXuG8mw6817qr5t7Gf65CIDk=;
        b=i2uX5tQ92k6uci/1TcNXiJPvqN/1CNGJfsGfQcifMDXoCJDCxNLV3G1tSPoGglxNvO
         epOEq5hss9BJUwsD3HnZT9OMxzaijMbePMuQQ7JLD2HhPg7pGjMhX1FvJO84vcSIdMWF
         EIhYDU+IxS6RKq8jb1pCktyzfnDS0xuQVw1NK2NwGvSsXsQkT7b1zTNEy2akL5Ggb5T8
         SFJUo2LH7zUwny85yCsBQV4NwPflp/XR5F4+Gsmh0dFcP4TTYhOYU/4LHr0rnd59cnMZ
         zARFHaTALtPJMKFFzKC1sKDwI5hcv1uN05wSWIcwgE5ftIz3B22L1nW4PyPETANtbB1U
         VLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/NXy3DDOssW0/c+t8sJIXuG8mw6817qr5t7Gf65CIDk=;
        b=UjEZBbkc4a7jvSWL6UT2hW+pENTcK2eUbOZvnyfaTicOijN3yJr67tkCu2YD/X9jeM
         C5XqocpEgRaV+48t+vOUUYp6XDQSFw4BDpZaSeiXCkXNtPN9x3YpcrGQF9QPA0ONoi1S
         RwSX8vUrtYzM4tEDbXObKSv7OmPwJgoJEUDsyD0UqGNr00mITcIfQLJrNXKzx10JgB9C
         73KVFn7c00CVCyd8DAt1b4Aw789SrbQMak/v7z0ThCxhhB2Szn5Oy8WA8GiU+WZ6VdCb
         ia+CfxRHCvmdGQNrCIBitZrFq95DlHcaJ4eXBfinANhgtY2ohkHj+LNJpCIg1ojyHSJS
         IQlQ==
X-Gm-Message-State: AFeK/H1W5pAMM6kzBwZ7PRlfnbDkpp5+zy0eyu8FlgNrVfYqipjQkEudM1uFnCp7p4chLQ==
X-Received: by 10.46.33.168 with SMTP id h40mr7374959lji.52.1489884513730;
        Sat, 18 Mar 2017 17:48:33 -0700 (PDT)
Received: from [192.168.1.26] (dbf73.neoplus.adsl.tpnet.pl. [83.23.31.73])
        by smtp.googlemail.com with ESMTPSA id x84sm2144559lfa.13.2017.03.18.17.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 17:48:32 -0700 (PDT)
Subject: Re: [PATCH 1/8] tag: Remove a TODO item from the test suite
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <20170318103256.27141-1-avarab@gmail.com>
 <20170318103256.27141-2-avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <0dda5b86-2f2b-8f46-98b7-476b6351442b@gmail.com>
Date:   Sun, 19 Mar 2017 01:48:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170318103256.27141-2-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 18.03.2017 o 11:32, Ævar Arnfjörð Bjarmason pisze:

> @@ -136,7 +135,6 @@ test_expect_success \
>  	'listing a tag using a matching pattern should output that tag' \
>  	'test $(git tag -l mytag) = mytag'
>  
> -# todo: git tag -l now returns always zero, when fixed, change this test
>  test_expect_success \
>  	'listing tags using a non-matching pattern should suceed' \
>  	'git tag -l xxx'

Could you fix s/suceed/succeed/ in the test description,
while at it?

-- 
Jakub Narębski

