Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2178320A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 22:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbeLGWW3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 17:22:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41566 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeLGWW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 17:22:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so2570445pfi.8
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 14:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hrZ7pAU5FSQTAKfAxZrpuKGWX5pH+zr1Mk0WA62wEIs=;
        b=CBDbZ60a7J8/kuvlo0/r3qYT0ClWzE4oGFaZZc1DteJiRoNJ/R3Ta+OA0AJ+AJ5DTE
         SzwvsiffD8a8QHYaRVmHPACgov3SBM3ErIseY5UPNew/Bv7uCuaOKlsxtVhvFF2sKAXA
         36KQQEAs0/AsaGILlt8/zVEonnRIt/nbFg2tus7LM6t0zgLnh11g3brAVk51+5zgz9Ig
         j/B9QCd4T8MOYtMpT4O7YqJGFZ/SKSwsa/6yPFh4rHE5mddwE2Jx1fPIMBzif6zFBEPS
         A9H4w0NdUQQ3QTeG16T2WKpXjA9DRjLJzP68j6Np8Maqqhi5Wp3S8GViRIgZsHg3mkDo
         tCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hrZ7pAU5FSQTAKfAxZrpuKGWX5pH+zr1Mk0WA62wEIs=;
        b=GTUlnoBAuqV3oTy6B/c+qU7ltmtdpVCtzcG35NwTIWGCHgjrT63EHatiN8vbLwOmlJ
         YOxsphOZc6HGVewkiMTRDgxa8hp9kXkXaQLjPsZFLT6GkcS2819Lvy9L4KO72+yBQnOH
         199NP+Nrgtju+gwa1YonRZO1XRE1nvEADg6yt76WiTttr463cSA/7lblyihOA3EDaBcW
         ifq4zMtitsyur5sbZ2+6/IPGPSSi5l3Bd1XZTL00/ZbmUFMV5QpdjqFSrH1yv44Sn1ho
         moP7xfnqtW7Bxy3sJOVTxwi4lfgt+pxO79HYVyEAZgMirdpxEIZWPkAXvMDDjMNAKHBI
         yjmA==
X-Gm-Message-State: AA+aEWZ1t7BQYhSyCicXfV13XLEN449w/JOwHi/noaUMlhQvfq5iRdOV
        o16EeUR9DpGaCtLuGi+8Fa0EW74u
X-Google-Smtp-Source: AFSGD/WeeiikmpTyYyqRRtc9ihKQB7OlYIwBUse/pBdMdUddIQQP1fr9oczKes2ydeKwmSHSBlLzXA==
X-Received: by 2002:a62:da5a:: with SMTP id w26mr3986162pfl.106.1544221347917;
        Fri, 07 Dec 2018 14:22:27 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id v13sm7099381pff.20.2018.12.07.14.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 14:22:27 -0800 (PST)
Date:   Fri, 7 Dec 2018 14:22:25 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bwilliamseng@gmail.com, git <git@vger.kernel.org>,
        bwilliams.eng@gmail.com
Subject: Re: [PATCH] mailmap: update brandon williams's email address
Message-ID: <20181207222225.GC73340@google.com>
References: <20181207205621.49961-1-bwilliams.eng@gmail.com>
 <20181207214013.GA73340@google.com>
 <CAGZ79kYrgpZDqAhg8c11V_qJTCzzw4-qrVN2z_Y_OAeCbWU6dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYrgpZDqAhg8c11V_qJTCzzw4-qrVN2z_Y_OAeCbWU6dQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> What would be more of interest is why we'd be interested in this patch
> as there is no commit/patch sent by Brandon with this email in gits history.

I think there's an implicit assumption in this question that isn't
spelled out.  Do I understand correctly that you're saying the main
purpose of .mailmap is to figure out whether two commits are by the
same author?

My own uses of .mailmap primarily have a different purpose: to find
out the preferred contact address for the author of a given commit.

Thanks,
Jonathan
