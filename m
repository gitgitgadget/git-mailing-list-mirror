Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D29DB1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 22:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJCFb5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 01:31:57 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:44686 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeJCFb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 01:31:56 -0400
Received: by mail-pl1-f176.google.com with SMTP id p25-v6so2444543pli.11
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 15:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l42Rhdndx3HjJlbtCTCVsqw+6QsLVqQ96/PTI8xjgbM=;
        b=H0HSDFSm5NPcGGElSRHli6Drdjtu7s7f8PpcShj0eK4rB4dvGCMiHISE/mk8eNEOmC
         12J2GNvq4tk/LBxZPzvAZs7FiZAMKc4YQnnuej4XYvDWJNDDsPtFjQZRYk47Yc416k8Q
         Fqiy4k6y5PvQ+Bmh5B6EXINvPyNW+OgL8StmLa52VX+M/RfxZTAWL1V+8pD667eVaU9u
         no5wCPw6tFvDG5Bp44cr65BIJnNHi6SFflaQyPxSiBKrViJN2KlwSKYdwenS5RXRcHGP
         gXJH2mfUKvgKrjgSSW6w1Darl6UlOcSAr7HZeCJnCLo5JzNifxii6+JKfcudgWRUthh7
         MqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l42Rhdndx3HjJlbtCTCVsqw+6QsLVqQ96/PTI8xjgbM=;
        b=DRGSuuu5+inwSIHpgN97oVqvyp7AaVv6vzsLv1FjgA8wKZZGyiw+AnPNv55BSEwzmS
         iLfDCDNddKNz0/S2/dPmF7yLmS8Aj6RcRw9OfRe111gHT6Z1pEPLJJup3qO3HY5RL9gS
         +KqzGxvdR47exxDEGXJjxVqQwTg+jgjEJ25wlDI+w196RNpVrBnKDW5HVdpKEMcdVWB/
         TSWnPLBp2cMgX6xZxqmquXaoVTpG1UQBvpVM5nT7jxIaJxrIn4YIos2HULoTNwfXlsyH
         xqj8Nw2biuOueLFDXu34oL25PrB8UPEDh/HEBYbSuAqCCgaFPMBAfnzdx7yXWTPNdoHa
         vtkA==
X-Gm-Message-State: ABuFfoiNzNL3ayQcVjuugD/i3XHv+a2pQ0FYDfuoAzNhQrG+Qd5+2eRr
        xT1NepYGukQY8sjrIujlRik2cTu1R/4T7g==
X-Google-Smtp-Source: ACcGV63pOvaoEyPE1uTXslMUyru6N/gQDPyqIhKTjxbehcpau2VDZLPiykYh5TJZjsIxZd7bghnMyw==
X-Received: by 2002:a17:902:7c05:: with SMTP id x5-v6mr13572482pll.305.1538520375736;
        Tue, 02 Oct 2018 15:46:15 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e958:2ad1:68d0:890f])
        by smtp.gmail.com with ESMTPSA id r73-v6sm15204577pfk.157.2018.10.02.15.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 15:46:14 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 2 Oct 2018 15:46:13 -0700
To:     WEB0 - Helmut <pd_web0@body-piercing.com>
Cc:     git@vger.kernel.org
Subject: Re: cannot dowload from your amazon server a windows git distro
Message-ID: <20181002224613.GA18063@syl>
References: <e7f885a203122612b8dd343212c4e0a9.squirrel@192.168.80.240>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f885a203122612b8dd343212c4e0a9.squirrel@192.168.80.240>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Oct 02, 2018 at 01:59:51PM +0700, WEB0 - Helmut wrote:
> hi,
> you amazon download is not working.
> do you have some free location to download please?

I was able to download both 32- and 64-bit copies of the non-portable
Windows installer for version 2.19.0. I used the link at [1] to do so.

Can you try again and see if it is a reproducible failure? If so, either
the website is sending you to the wrong place, or there is a problem
with GitHub (in which case you should contact support@github.com, which
will route it to the right place.)

Thanks,
Taylor

[1]: https://git-scm.com/download/win
