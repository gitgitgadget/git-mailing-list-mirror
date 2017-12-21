Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1390D1F424
	for <e@80x24.org>; Thu, 21 Dec 2017 17:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753752AbdLUROT (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 12:14:19 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33140 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751766AbdLUROS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 12:14:18 -0500
Received: by mail-pf0-f171.google.com with SMTP id y89so14206300pfk.0
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 09:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=O+FxQJb+4dqlIfgNhDNNIHLHDh1wUO3aeeV6Y/40Hvw=;
        b=i6SPv31kyZjTyftTEgQrvUKZ72ebVEPeu/jkUqVoozMLdnHvr0tXawu0YbCbjE5pCv
         1u1oUcNhl37rW4TDR4qTqa+fCTRZatICqt2x1Xk5WEOB1+rV6VwJWgpvcVRvbSBuJR5t
         FDDVngA6pHcayb2TLneH+/aqrWj91XJyruXjzbihVNn4uGijIJNVoUPrnuf0RNeV5DU1
         ivRifyleWtz9cFvSbzeLFm+E8oowEFupcWFpDcdLVl28YaQ0nIlza78gOZwlPHshqs/Z
         Cs9C+G+3TLX7D6bvYbJD1CW4B4NNJxuWV0fvaQcxMRpLEEHeuTIHBEqcHb/WywiGviRV
         NTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=O+FxQJb+4dqlIfgNhDNNIHLHDh1wUO3aeeV6Y/40Hvw=;
        b=gqhbW6Mu3u2EMWDauttVshXBPqM8W08qXwjpNz8AwM+APKMoacKKZee0En1dQTsnFc
         kl4Qk4wf3K8xPzMeuYgAilkBDF9gvInIVt06hCpL7y8IB7Oie7Rxhva+dmVO3oDYtXwj
         /IMHu9ODA6A1C0K+bD8/AoMzATSsTFMpyFlGg0hpqPPdJI9XObAqnLOJrX6X5BDEe0qS
         e5C/oeji4gVQ9+euVtQ0p8CbDtZBlEkPuwKflXOPv5SM3aoioo3iuA5CIk8ijeDcJuMA
         XMuBO0w1XQEdzRe3HXyWsa+GxrYu/q0X71SW2tJdwvCsUWIq3x/d7gEDt6Ai4NzArate
         ndSA==
X-Gm-Message-State: AKGB3mIzy/MyMuju3Bl8wTzOpkHjgInXxVklQu+tvTiF3GfPLtPy4XNQ
        Ku4TdoGknj+gsSmQvvZNikA=
X-Google-Smtp-Source: ACJfBov58jl9FLf3gunGsjwIToBxy9wSdc9tZkMfNryfv/Dw60MwyN7E5CK88MD8qzjgoqMWdL7aeQ==
X-Received: by 10.99.64.68 with SMTP id n65mr10132441pga.312.1513876458263;
        Thu, 21 Dec 2017 09:14:18 -0800 (PST)
Received: from unique-pc ([117.246.179.102])
        by smtp.gmail.com with ESMTPSA id i186sm37635913pfg.178.2017.12.21.09.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Dec 2017 09:14:17 -0800 (PST)
Message-ID: <1513876450.9646.6.camel@gmail.com>
Subject: Re: Error in `git': free(): invalid pointer (was Re: [PATCH]
 sequencer: improve config handling)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     "phillip.wood@talktalk.net" <phillip.wood@talktalk.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <25620501.1048091513875229038.JavaMail.defaultUser@defaultHost>
References: <xmqq8te84yo6.fsf@gitster.mtv.corp.google.com>
         <20171213114621.30250-1-phillip.wood@talktalk.net>
         <1513794792.9785.2.camel@gmail.com>
         <25620501.1048091513875229038.JavaMail.defaultUser@defaultHost>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Thu, 21 Dec 2017 22:44:10 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-12-21 at 16:53 +0000, phillip.wood@talktalk.net wrote:
> Hm, There is a problem with sequencer_remove_state() which does 
> 
> free(opts->gpg_sign)
> 
> however unless a gpg key was given on the commandline, opts->gpg is 
> initialized to "" which is statically allocated. 
> 
> This untested diff should fix that,

It did seem to. I don't get that error any more.


>  but I'm not sure if you're problem 
> is related to it

As the fix you suggested did work, I think the problem is related. Did
you have anything else in mind when you said you're not sure whether or
not it's related?


> also I'm on webmail so apologies if the patch is 
> mangled)
> 

No issues. The patch seems quite small :)


Thanks,
Kaartic
