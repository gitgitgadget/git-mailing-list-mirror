Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC12C2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 19:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751156AbdJCTOs (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 15:14:48 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33168 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdJCTOr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 15:14:47 -0400
Received: by mail-pg0-f67.google.com with SMTP id b11so1751308pgn.0
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 12:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=EokrYR/znmBMFnWQ+Vb7aA1tDV3TvPRPTBpeajztOPk=;
        b=ozHzRsEzbH2xaa0TVZAkmgFqJc68XXxNjeim+VzRRcX1IV8aY96oNC5GX3IOJSdBGD
         XXgvfm4mXxEbV3I4gFt49zEGFOtcVhVbOf9R4mEZ49U0ksRqLmYmhHugoDR9/SNH87M5
         un1FvvEN6/IaAbACew+BLLkAsquTqEUIHhehr8wkdifxOOYR2bySHTa3s2P/WcFxDx4i
         qnfJUTcP2q7XUkMz9gRIXHjYoAENgf4Qsp902VrnWuqac8VpD/WamxRUOCFH+uaArNzW
         3Nt4eaIgEX8HauQlRNYDJk+k2OtMVxSeJ6ILAi354TiRQKPGpK3sx7LapDd6Qr9ovJf3
         VkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=EokrYR/znmBMFnWQ+Vb7aA1tDV3TvPRPTBpeajztOPk=;
        b=I9XWCoyqfp4MUb6+IJdB6N4HPaEaYP4YP0H6pSd6bre87zf9Kv3w8punyy1TJD2wU0
         u+tXkOSDYMLd3UBBj3Boggf7mmsi7Jj4req8O7qKcjdSWCoGaQaJya9M46ujnMf501WZ
         uyzaRczye224NgkqLhgo7BSsNlCov3OqTD9ruog8lMwk2yfUDIf/QkUxh08+Uyv+zuLJ
         K3bRH5U2bMBntISy9JXMLNV5Hew+g5lPlfOcpliI7Rx3Lc+0jNtQnORukAVVOGdgRhd6
         SHPash436/2tLgwVOe0FMWPY3rMySit0l3XiAsUPChj2MEwCci/ZK4yF6P7Vv47gvEUz
         iCPQ==
X-Gm-Message-State: AHPjjUjikFILlJArJNh5FBKSLwVfiqB/o4lc93tl0++9isifjYdVyhKs
        43OcYsF1kn0FxWfkdkWdhI0=
X-Google-Smtp-Source: AOwi7QAzBo94Nd3ieZ6gjkKPTD4yAUcG+Y+jl4648z4B7IbYCrK/SIMpDDajdnOAlSWoifN9PMCuMg==
X-Received: by 10.84.193.131 with SMTP id f3mr17173633pld.90.1507058087062;
        Tue, 03 Oct 2017 12:14:47 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.googlemail.com with ESMTPSA id a19sm22993191pfa.25.2017.10.03.12.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 12:14:46 -0700 (PDT)
Message-ID: <1507058081.7360.5.camel@gmail.com>
Subject: Re: [PATCH v2] branch: change the error messages to be more
 meaningful
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqqbmlpm67l.fsf@gitster.mtv.corp.google.com>
References: <20170730115908.13841-1-kaarticsivaraam91196@gmail.com>
         <20170821133608.5652-1-kaarticsivaraam91196@gmail.com>
         <1506964786.3504.3.camel@gmail.com>
         <xmqqbmlpm67l.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Wed, 04 Oct 2017 00:44:41 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-10-03 at 09:21 +0900, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> 
> I do not even recall what the patches did and if I thought what they
> wanted to do made sense, 


I thought you did or may be I misinterpreted the following statement,


On Thursday 17 August 2017 12:58 AM, Junio C Hamano wrote:
> I do not find the s/branch/parameter/ too bad (although I would have
> said "arguments" instead).
>

I interpreted the "not .. too bad" as a "it makes little sense". So,
pinged the thread.

---
Kaartic
