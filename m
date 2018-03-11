Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 015921F404
	for <e@80x24.org>; Sun, 11 Mar 2018 12:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932144AbeCKM6u (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 08:58:50 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:36578 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932129AbeCKM6t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 08:58:49 -0400
Received: by mail-wr0-f182.google.com with SMTP id d10so587521wrf.3
        for <git@vger.kernel.org>; Sun, 11 Mar 2018 05:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wlpGIU/ogN89fCxljqJcivThV0Wc9QFjqWv7y/7C4gU=;
        b=q7AsRwx+Tg42Vzgfr9maevYTeS2ifClhHQUdUbS6O5Y2a1oD9zNc6XTza3RGyIJL1q
         iyynRnylNbQSePcPR11MjWc2GhXH3hyrN3+TRLfGrJ4Bi3r1mNQzTgMtLGfAPQDuOMaC
         2WEtd9STsBCcyzCJP8l1H+wDtU9z7YHRZpYA6W6/EQq8aHbqgPD/DBzOruuJDjyfGnRa
         9BLpWfPuG/HXhL4wR/7LdQZM3uQbFOml92y3jc71x0f2O4R+Bq959rnzQcA3xoxyaM7t
         /OBvo4F42/Ir8ugCVw+Op5yLP8ksOCm5WeWapmyC2PzXfN4rOvlV3NEtyHtDjt19OCc3
         3iGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wlpGIU/ogN89fCxljqJcivThV0Wc9QFjqWv7y/7C4gU=;
        b=WRhIu+mypFsnOLmc+QS5y1H+2OCRPZF8/Od6JhGSVUQ3oJJ9dTwEMuOojE9k0YZ1FG
         C7j56Sse2ZHp90TAarLpRhbf+0vS4Ski4sifWfmpbOHNZho3eVmnSTZUBXrlxIkoV4fU
         71PmI0J6QtO5ELgcxswrGSfbv/qZ/jG3JWdTy9A+dXdQVXJPCT4FitUb45mZdbmDBGRa
         kw7k6TBcer5Zjcl6+3oGY6T8VzvZvaATML3GJZVeqToWAsOqkihA2ZrQHm7H4MUSPhiA
         uybgraEwb2IQrRWfGXGWQn+w9gQuWh7IPUZyoSMXwSQV5gm+zkK6MOtgBlAtIt+TEOBh
         kuow==
X-Gm-Message-State: AElRT7FSe01S2vPFJWZXHC66AAItiPFDWS6yw+JU/MDUhSVBC9Ua/UfO
        7JCdiG8n8EInFCo1uneVl42JjRIp
X-Google-Smtp-Source: AG47ELuu7gH5+czeV9XDeF/rmKaZxIhlBaPhVSJLdq0cfXGCnweILL0SWnaYFHNaAJPh9SwwAYQwqQ==
X-Received: by 10.223.199.71 with SMTP id b7mr3995367wrh.228.1520773128470;
        Sun, 11 Mar 2018 05:58:48 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-24-146.w86-222.abo.wanadoo.fr. [86.222.23.146])
        by smtp.gmail.com with ESMTPSA id z3sm3824110wme.3.2018.03.11.05.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Mar 2018 05:58:47 -0700 (PDT)
Subject: Re: [GSoC] Questions about "convert interactive rebase to C"
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <43904e83-4ada-a550-430d-b70364bdc567@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>
Message-ID: <89d0b710-7dde-d77e-f9ce-1008cf5ea552@gmail.com>
Date:   Sun, 11 Mar 2018 13:58:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <43904e83-4ada-a550-430d-b70364bdc567@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 07/03/2018 à 22:56, Alban Gruin a écrit :
> Hi,
> 
> I was reading the email related to the "convert interactive rebase to C"
> idea[1], and I have a few questions about it:

Hi,

I’m writing to you again, in order to have some more information about
the "convert interactive rebase to C" project idea.

Regards, Alban.
