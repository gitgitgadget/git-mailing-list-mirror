Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA39E1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 15:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbdHCPf1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 11:35:27 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33309 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751010AbdHCPf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 11:35:27 -0400
Received: by mail-pf0-f195.google.com with SMTP id c65so1829718pfl.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=wAOGbzKxwlvAwNYaIpCWrTVMN3CobdB2l5tdYJ4Z6zA=;
        b=HWza0W/5bw//1XmH4eci8yYG8//0fXvksptthaIwKCyvQTwCh+ORzGAuTAIGCiHht9
         u4O3r3WLuPGel9Ocb7PUZ2+n0HbtGYsHZY/iQq3s/s6N4/j+KlDticCKaBHpSznrPPu4
         Cxbp89zVQ7/LRgavPfrWH/MI5Y3VZ/A9pnnTKymGb9aaU1DyvxwlkuRmmcjXMWDbDz5m
         aGZaobcpYn/XjfFDuoO9Er83lY9gF59MSE9Q/gV3CQR5Wc8GfaCuETA8dkUrXKk1S20z
         ulB0l3iDoUcFOJclsw+nCf62aYZgOKGc4HIW6fI9fs+iM1OQh1/Oa0H7LeOdqyoiiNuy
         TFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=wAOGbzKxwlvAwNYaIpCWrTVMN3CobdB2l5tdYJ4Z6zA=;
        b=YfGdJGv9F/xBOqYw0WwOlA9Dua6VnvbcSsZvTbYerjiKWm8V4XUTah2o+uZqqYoJD1
         QTq9Qc424hpiC4bpEfl/ntPsb9eQvnN7iP5lqiwMy7AfnpEGT53xP19sOQrvZPxmSm+y
         NvCza8Qad1tcJ4O/a6mivZ+3HJ+dC1NhbJoyxpxPl0qdTIvvHK1b0s4ARhpi0fuet3eJ
         zoKRdyT5ZpofANiuuPzVr6Pp08WPtwAzTHBSRlAenCB2oZNihVm7z+/F6aWI3FRvDuAS
         eF4OuPRrNk1npxNgVSiRhSWe8fRXL8MYOwxQgWkKTqQ4otXpa1hcGmZzGmaN5lExYLXN
         oSmQ==
X-Gm-Message-State: AIVw113q362C7LX1uBXdXu0MhoIr9prAB0C+2lm+aCTpY0nMr4uCupJx
        RdK8nCHPSmZgDQ==
X-Received: by 10.99.97.194 with SMTP id v185mr1908817pgb.165.1501774526556;
        Thu, 03 Aug 2017 08:35:26 -0700 (PDT)
Received: from unique-pc ([117.249.241.161])
        by smtp.googlemail.com with ESMTPSA id 66sm23569580pfb.149.2017.08.03.08.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Aug 2017 08:35:25 -0700 (PDT)
Message-ID: <1501774553.9604.1.camel@gmail.com>
Subject: Re: [RFC] The correct and consistent alternative to quote a
 command ?
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CAGZ79kbCg+xdVE1U0dv8MJ6vUuWvraWQCMSzKOTBsOvtdSvkGg@mail.gmail.com>
References: <8256C530C7DE43D7BC72BFB327DF4726@PhilipOakley>
         <20170730161816.2412-1-kaarticsivaraam91196@gmail.com>
         <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
         <1501603171.1671.8.camel@gmail.com>
         <CAGZ79kY_NdBe1QjJWrLUkfDOk8Zrnopa945F1xBq=WFDNpRWMg@mail.gmail.com>
         <1501676577.1957.4.camel@gmail.com>
         <CAGZ79kbCg+xdVE1U0dv8MJ6vUuWvraWQCMSzKOTBsOvtdSvkGg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Thu, 03 Aug 2017 21:05:53 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-08-02 at 10:32 -0700, Stefan Beller wrote:
> Thanks for checking.
You're welcome. :)

-- 
Kaartic
