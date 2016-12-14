Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94E551FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 23:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933077AbcLNXLd (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 18:11:33 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33185 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752959AbcLNXLb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 18:11:31 -0500
Received: by mail-pg0-f54.google.com with SMTP id 3so12768262pgd.0
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 15:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=109nBg6Bz7CPcKZoyvYwp29cSVyi3aMWJt4Dysza9b8=;
        b=TSJ958VMEqKglH+Iaj4eoVqHqhuvjTQn2TU9ed95S2md7q5CPDAlJfARZjjaqPdcqf
         RTbwUkiduoiMHVUmeC2gvfcxtsv3s/oLbCLGr81lo5DNLvwoxZg0VkNVHUYdr07RXNMX
         kS4RI2vDs5bYAb1QbWIJNiIdsAuvmaLG7PRYoHO/koWTdrneSaAdWxVZ1CinjfzJ2pfF
         9w4YO8mmIammDBbx1r1tsQ4eQt+jmpNm0xX5UMDAHJRTagQ15s9tfQYny0H3ckYUpCm6
         kjz+TfmrZ3aSdqs+XqOvpOjYF0sclca+/1qZChKic12bWEKE0CWesI0W2uhPbWyd1t1K
         PFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=109nBg6Bz7CPcKZoyvYwp29cSVyi3aMWJt4Dysza9b8=;
        b=Swh0FCzuZagHGytwkxOPizV2hSQ2zdtIgeMg9yQCfo/oI6tPCyd2vzyBrY/lAvOwJL
         qJFW7rzWs51SjDo3J3KwiR2qT/NJX4bCC02FgfHYw7ssNNIWWXOP3gLAHtlUnCD53O3s
         KtKSCFFsXrctzm/qAqqSDRAAEy8aj+EDeLkOlDU2/jk8BksXwXqWJ+R/sHi7dg6wTp/Z
         wdTWxzrWIAVPiVErN8bsYhqt4aNU3NvI6VEruv9gTqMePYPcmZRyxaAoMjYFr7UBoOiS
         5OMCLMXUbVW+rJ4ySKPNPGKkbiEOaWwHl2uOIUYBL0QTIx53s+wAAcAtX9oiS0EM7XbE
         /Ujg==
X-Gm-Message-State: AKaTC02aYeTCa+KNbEvW1diUNNWWE/JlSXDlmiSXTe9QvsvmYEueBNL9svM/ILqRZwNWUdDe
X-Received: by 10.99.226.3 with SMTP id q3mr190355374pgh.37.1481757035394;
        Wed, 14 Dec 2016 15:10:35 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a0bd:b7d6:4331:46ad])
        by smtp.gmail.com with ESMTPSA id 64sm89727977pfu.17.2016.12.14.15.10.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 15:10:34 -0800 (PST)
Date:   Wed, 14 Dec 2016 15:10:32 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, David.Turner@twosigma.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCHv3 3/4] submodule: add flags to ok_to_remove_submodule
Message-ID: <20161214231032.GA174925@google.com>
References: <20161214224101.6211-1-sbeller@google.com>
 <20161214224101.6211-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161214224101.6211-4-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/14, Stefan Beller wrote:
> In different contexts the question whether deleting a submodule is ok
> to remove may be answered differently.

This sentence is oddly worded.  Maybe this:

  In different context the question "Is it ok to delete a submodule?"
  may be answered differently.

-- 
Brandon Williams
