Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B06001F453
	for <e@80x24.org>; Wed, 26 Sep 2018 19:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeI0BoY (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 21:44:24 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:37639 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeI0BoY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 21:44:24 -0400
Received: by mail-wm1-f48.google.com with SMTP id y26-v6so2965015wma.2
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p8WLhYHOYtXAikTmW9xOqCa8qz6VOeT6d9qEcb15E+s=;
        b=hvisRD7JRekSJ0YSynf1QCxtzoMiyC5HWQN+RzsIp5rE/ZsO9MjkSeeIOZhuakoGyp
         fRG0UB5UIbfVGl8t34ctZz0mP1odvJE16SE4esh8lV+kvk+ZM3SyTGKUtN9rEiKyWwac
         DJoxjrXnPRC+L6CdDH85YNsPqsdf9VL36vv6qkMrgMfeFDKg0rbTr/q1Gr0CG32AQjh+
         auH4jiRmLRDHdKoqKpAD0+pVQk5QWnnnz+2ErCIh4boIb6bVoPXb67ZVGxHJNm1WMp+x
         YrPZaAJ5j9ZNi9tuPhl/7JzZ31CFNUUc92KPrv033PMDLXhs2x6B/trAJKyP1f6bp3Eq
         2Jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p8WLhYHOYtXAikTmW9xOqCa8qz6VOeT6d9qEcb15E+s=;
        b=iJeT9/u6LMql2KPiCZtaifjHLFtr/Y4sD4CF+UZ0A0zQrqR4k38am/kTnIDDBiH3z1
         osGRVMwWSnIDSoppC12k1/oqbSW9Axd/bzZsO8Bn41BkxHaWBR98G4IOrQw36Kzcmuwz
         qjpO6DyF/ajlgHn6vev94oWs+PCGRUyKMRUjOiW3Kz5x5wY6xseNcTwzC5VZwO+qlKfX
         o+cRyHNwf/PlwNq/6OxxhImk8vddRmvL6apU+8kDq7++4rdeIdivSPmdPUHtYmLE96l5
         sv9l2icl0wW3sJY1JqC37o1OzQrBPru0Mp0zwDux5Ufz8ZmbPMR7Blc8C68Ohls/NnI2
         2pLg==
X-Gm-Message-State: ABuFfoiLSlWR8h5pRJAeGE7LM95i7KU7749Vf88KTPvhDbLylEdMpbNv
        MIsRYFxdvGROJ39rLLYDys/XFlbxW9E=
X-Google-Smtp-Source: ACcGV63aI8+Yzi1d5kuoNyvlQEcPY3osysZbGt4mi0Sv6SqLlGQ3LsKLEguY99XRe7orBRFLba9t/w==
X-Received: by 2002:a1c:87ca:: with SMTP id j193-v6mr5659172wmd.76.1537990194396;
        Wed, 26 Sep 2018 12:29:54 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id d6-v6sm316566wmd.2.2018.09.26.12.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:29:53 -0700 (PDT)
Subject: Re: t7005-editor.sh failure
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Alexander Pyhalov <apyhalov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CALOYryFX4PPR+=1L+sjEqPsdmNh_+vNxGf0wwuAgoYzau=GShw@mail.gmail.com>
 <CAN0heSrhaaP0ds8K92g9w5DAnbwuq8mM6WLKrTQ7e_a8Fku9KA@mail.gmail.com>
 <CALOYryEMB5HoCXbVKnc49KLkk2ySZjn4DG9RbJjQAvPn1H5K6Q@mail.gmail.com>
 <CAN0heSpUhzbTjceVhBxk_jjE=vOAVTzXGFQ=UL9Y+muJHe0S6w@mail.gmail.com>
 <20180926121107.GH27036@localhost>
 <xmqqlg7oktto.fsf@gitster-ct.c.googlers.com>
 <xmqq36twkr27.fsf@gitster-ct.c.googlers.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <8ae32a61-f5b8-bbd0-6500-5292b8887b2d@gmail.com>
Date:   Wed, 26 Sep 2018 21:29:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqq36twkr27.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-09-26 21:16, Junio C Hamano wrote:
> While at it, update the way to creatd these scripts to use the

s/creatd/create/

Or rewording as "... update the way these scripts are created ..."

> write_script wrapper, so that we do not have to worry about writing
> the she-bang line and making the result executable.
