Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E750B202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 02:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbdJUCbt (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 22:31:49 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:51924 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbdJUCbs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 22:31:48 -0400
Received: by mail-pf0-f195.google.com with SMTP id n14so13356403pfh.8
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 19:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=V6DNeQTePQXmtGdwGXRnqpHG6v042aquBikenhYXTeo=;
        b=ergT1Omn2T8TMQ2rxq1VC+03/F36daCdp70wRw82C0luY62aQ2rArpT3eYSTO9uuBk
         g74dxNJyZDMFq0wj38reFJDRDn59hU1pG1dC3knCI6I58NidrPnfYJtD2CW3M6rc+Lme
         ig3WfpdkIettseEUhhLh+hOA1K2nCSQ35Ro1RX+VLMS59DPfF3vRvMy9s2qllo3ityz4
         ktyLSvm8uBda/n52Ak2cX+xkVG2LJdhkB8uWSChtsY7lyzo/G57OovWjiwXvfR+SjOHT
         pRnPAmpld7sa92pSszmXpNYhd5DMWlVJJcxOoCDiVy7LxRFrXP5rkrgFKHrIR7OKrauL
         28pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=V6DNeQTePQXmtGdwGXRnqpHG6v042aquBikenhYXTeo=;
        b=UyEcvNMAW91RVbPXAexSVoqvqPb2maRpVee9zGrssPZgVmYcfKw3hPowqpcvV7YxpD
         aGHDh7Gd5Zw5DbGspCaj9o409u6hctot/Z1bEboVYTYce+Asv7zCicQEXZWxz58/KvnA
         8w6a6pEpRzZDOcbFhHPw5GQrrYnGes1q+1xgE4NyMBuIAlZq0OBAknUbS0H68OyHt/o6
         xUKoAxdKlJrFFxfqSQ3PngdrZthBTK9rEIzEdQrHDC6iuq7by2m3dj970M9nyR9VtoRF
         hOfq7smGViGdRuxEXdNPm/tvybu9syMtDOJx+wvYVwtt15NoZMS6yaCVYSxn047wfO1a
         0O0g==
X-Gm-Message-State: AMCzsaXKwUOstbHhVI9s7DNwXXkSNzZEi3BAbEifPrZTjGj5IveWEGN3
        1UokAD7Ea4bY4DqqMOYHOrs=
X-Google-Smtp-Source: ABhQp+Qs91f0jWLUBedPs9kVqdHsIRkr0gOT+lUSHvmdM3AVCQgMR9b2xsaJGEhlhMbdtsQ/oTHQng==
X-Received: by 10.98.211.220 with SMTP id z89mr6578066pfk.99.1508553108172;
        Fri, 20 Oct 2017 19:31:48 -0700 (PDT)
Received: from unique-pc ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id b19sm3507352pfd.182.2017.10.20.19.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Oct 2017 19:31:47 -0700 (PDT)
Message-ID: <1508553102.2516.2.camel@gmail.com>
Subject: Re: [RFC PATCH v2 1/5] branch: improve documentation and naming of
 certain parameters
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CAGZ79kaVUBuHVxaE0opXqiEwCr7MVFZHrt5ERQ0mF_deSHeOSQ@mail.gmail.com>
References: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
         <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
         <20170925082024.2691-2-kaarticsivaraam91196@gmail.com>
         <CAGZ79kaVUBuHVxaE0opXqiEwCr7MVFZHrt5ERQ0mF_deSHeOSQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 21 Oct 2017 08:01:42 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-10-20 at 14:33 -0700, Stefan Beller wrote:
> Up to here ( including the subject line), I have no idea you're talking about
> 'create_branch'. Maybe
> 

That's because I didn't want to be explicit.

>     branch: improve documentation and naming of parameters for create_branch
> 
>     The documentation for 'create_branch' was incomplete ...
> 

Sounds good, will use it.

-- 
Kaartic
