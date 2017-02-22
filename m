Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30642023D
	for <e@80x24.org>; Wed, 22 Feb 2017 21:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934033AbdBVVLw (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 16:11:52 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34892 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754838AbdBVVKm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 16:10:42 -0500
Received: by mail-wr0-f194.google.com with SMTP id q39so1861154wrb.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 13:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=IB+2ZUuR7IfSs2ZaANItCb6J3241++LmcHBQOnuWLTM=;
        b=FKa+4B7L0wFNloYHBx2Y8Bxh+PnYLp74f4jIzmpK37Y0e1jGeCjkQYu75qeErcKYlP
         JBj9eSdhu8y1U5+Ycb+1OO3rSIo3LcBlaqr4zZWdZknR0J6kgUlYO5NJYywZuRffeRga
         d9fgxxlWAQJMLJUiQaOaxLVBwyxMWVs4abvF1jX1e4Q63TpxaByL6MUVkeyLmMVYlei7
         qIbnt+T/du7p9vkdvZg/M2WhZZ8y52E141g1UNd6UYFKdLDGq89elv+Sgin8f870lxIJ
         4M5USwiytqFmYuBpmeZ7zxucS7C6HpnNzemZUtRkQ10sueNUCvCJoCJP3tIvfKJTKhjO
         DOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=IB+2ZUuR7IfSs2ZaANItCb6J3241++LmcHBQOnuWLTM=;
        b=tSij21cZvGlEitsT6LZK/M+Zh9FP5o4rvCBjq2MNkhPiQFwDFkRPREZpSQ87ukgNK9
         wvy8B2uq2f4TfMf2vz5QfFsXY+ol9H2+j8pRaIJyeleGTq3vx5hyT5/iKzrHD1vAf1ji
         ccmJmCy14lRLhS6cChgeF8noerwOqO19eAgha8zeABmt2PTTx9hyyLCdL7guw7RN+5pO
         8r7l9WPrA5rhe3zFHze+Bw6weBHQ1KLGsT3QRSBC7UQ1PSP07jrqkFRkb0eXLE0HUfW7
         1JfQubfKrxhfiP1pE0Rx8/+LjFizRQ6u41TIFWV9GOoaYaK1kbQApoCf4yi3CmOojWQ0
         9rWw==
X-Gm-Message-State: AMke39nx6amXOheRZyowZHQ68a16AhxfKYyVfp8bvZa+1sv3MRy4ZN8Sv+m3RLQBOC9H5g==
X-Received: by 10.223.136.123 with SMTP id e56mr26257627wre.28.1487797728628;
        Wed, 22 Feb 2017 13:08:48 -0800 (PST)
Received: from ?IPv6:2001:a61:100e:ec01:5d44:1c25:e25a:95ac? ([2001:a61:100e:ec01:5d44:1c25:e25a:95ac])
        by smtp.googlemail.com with ESMTPSA id o50sm3191880wrc.56.2017.02.22.13.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 13:08:47 -0800 (PST)
Subject: Re: [PATCH] Documentation: Link git-ls-files to core.quotePath
 variable.
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
References: <2b0ce702-60de-534b-8a86-5c7ae84060de@gmail.com>
 <xmqqh93nfeyj.fsf@gitster.mtv.corp.google.com>
 <e55b3cb7-65bf-1609-2e8d-823b4336e07a@gmail.com>
 <F71515D0E29940CA9C421D18480AD726@PhilipOakley>
 <xmqqh93maqgw.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <3c801e54-28c7-52d0-6915-ee7aaf1d89c9@gmail.com>
Date:   Wed, 22 Feb 2017 22:08:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqh93maqgw.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


@Phillip: Thanks.

@Junio: Don't bother, I'm about to fix other man-pages with the text
from ls-files. I will include that typo-fix and prepare a new patch
based on maint.


Am 22.02.2017 um 22:02 schrieb Junio C Hamano:
> "Philip Oakley" <philipoakley@iee.org> writes:
>> s/option pathnamens/option, pathnames/    # comma and spelling.
> 
> Thanks.  Will squash it in while queuing (I need to discard the new
> text added in the previous attempt in the preimage to make it apply,
> too).
>
