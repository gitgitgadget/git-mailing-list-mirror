Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A041D2023D
	for <e@80x24.org>; Thu,  2 Mar 2017 05:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbdCBFGs (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 00:06:48 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34133 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbdCBFGs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 00:06:48 -0500
Received: by mail-qk0-f194.google.com with SMTP id s186so16331031qkb.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 21:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=iFDFxXYZOv4wrHdInZWBd5qbu/jKz7S/nr5ENatY9SQ=;
        b=mgosPPZS6jlN2RZYB89CfiaiGsHt5ycHcMFFacMSlhAHURLim82BQC3fFOXG/Rg6a9
         5PKs7dMnjL2p8aCekYQDhYVztp6LqRdYeqVdvUritSZGPkILvZv+hf0w0YcgvGSakc6Q
         hkYXDrGi6y0jO44O4MFRI05nwYTVYWyNe4F5foy8wJUy4oNXTozXLs+UX92fsPD2j5nB
         Uaah91eWMv2IRoQQgaTw36Ujas7j6K3MpMtae/pxXu+JpDCvpQH85no6cfP3JO3D2WnH
         WJLBqlDF3vY1YZ4vwDvHFwCTFVWK9NModsH8VAhO5iyPaKs+ViUe+QqvmGk3vYDBSMVE
         39Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=iFDFxXYZOv4wrHdInZWBd5qbu/jKz7S/nr5ENatY9SQ=;
        b=Ci+aX+utp6oeApbcGJgctQvIi5BVUaDk5CDMizSHP/TBxNbSn6LU7/AE/YzK0MJVb+
         u3aYbITuu/kkKVZ2qIjkkWEZhrF1RQl4GojTppgVUoEdTJWfanjzsg+LK1yPd+1OyHDY
         V714Buqg++R8XO8IJBRPD8q8gsK2/vqvQqnv4g7fkRH5WxUlw4+5Dd2wW8DWUZ+mteio
         B6Uo5T8dU2npFv4jRL/6lyvHKf4Pvb+4KXCMiqbZChtxacxLympN4loYd07ThadZaAI2
         L1yHQM0MEmbCOuFnHHqvUqFBbVqA1bc/LQvYFfF7EZWGHMcUkHXAYR0VAm5p6D0/X4vC
         LWYw==
X-Gm-Message-State: AMke39nrH9G+vF03dDRxCIgQ3reK1AO8XXwCeD9udmPr1QggPx0WXCUbE/HWvEhUMIPOfmqZKN0fu5FmRPC9ug==
X-Received: by 10.200.55.152 with SMTP id d24mr14766575qtc.1.1488431206809;
 Wed, 01 Mar 2017 21:06:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.178.20 with HTTP; Wed, 1 Mar 2017 21:06:26 -0800 (PST)
In-Reply-To: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de>
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 1 Mar 2017 21:06:26 -0800
X-Google-Sender-Auth: 9t7H1lqsyNJr0alrEOrJairojig
Message-ID: <CAPc5daXQ72dmRv4zdqaOXs3eScgDgJ=P4PiQ00L7pnEa1d8=UA@mail.gmail.com>
Subject: Re: [PATCH] Travis: also test on 32-bit Linux
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 11:17 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> .... This patch
> asks Travis CI to install a Docker image with 32-bit libraries and then
> goes on to build and test Git using this 32-bit setup.
>
> A big thank you to Lars Schneider without whose help this patch would
> not have happened.

This has been in 'pu' for a few days, and
https://travis-ci.org/git/git/builds shows that we have
a new build job running successfully.

Good job ;-)

Thanks.
