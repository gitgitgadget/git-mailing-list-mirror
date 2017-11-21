Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DF152036D
	for <e@80x24.org>; Tue, 21 Nov 2017 17:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbdKURzH (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 12:55:07 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:34802 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbdKURzG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 12:55:06 -0500
Received: by mail-it0-f45.google.com with SMTP id m11so7702226iti.1
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 09:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HSRln3yRtC9rpk4ZCk2VdpWPU3u6GCXgzSK0vBei7n0=;
        b=X15NAXS01tPfrq8tUKUAg5g9qqQdEYBplnus4sqpVrlwPEWAwocFRr9GAI2CTF6Q1l
         BDfMMRHxsl8nSNIzCMEL8Zxqg/ZLgvUxSfxEJ0nhMjcQ9c/7Qh9pG8v5kS7+UPVA66VY
         v9hKtPToxBzgGPDWJgAd2ccqlDOfA1LBBg21XGEY+XhCCJkbLw/3TuI9stxgx64FmwX7
         bj4eFfUVmh+IVOIBPt+qzxZshnyWpTtIDk5wDQ4Hvjm8x6e8swOqe7TvzlvNRBqi/UbF
         jEWFKCqEngcRxjrnqoPoDZI+PWNIXhn5z78ilzkSkihxo3AjZCmAnKh318yJn0SYfgH2
         zkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HSRln3yRtC9rpk4ZCk2VdpWPU3u6GCXgzSK0vBei7n0=;
        b=BJv9Q/AkmatVwyWZ4bGUS+Ge5Ro1Zpe3HwJCo40so6LS7ePOpZrf79cwYK9hXiYK6O
         wtQKRxL6rGlKoRBLj6owsc3jFrJDGU6zQazC/5t3ZJZOu88TU3yN7DvKF15me66AgeHs
         Qzt+Rx8lLsRtviRgPhU36kPYFdezfu5LE+uSZ7hBNfo+GAfjm/ceLXqvmdhs816goKbx
         LVJF6V9hLOUkQ/v0ogdXsZrf012N8OK0Jb6XCjFKZOlsb3S8tBrAgKKNMqaSbp/uLBqC
         c/2oWqG3NJZTo/GZEFvnYwpgG0TrNU4MyJebl+Y4J3ZOermPIYtlKkBXZqQVBCpnWsb1
         ODpg==
X-Gm-Message-State: AJaThX4OOuaXcCQmIJ0JGnwLSNn0p0Nsq59KyLdGt87pP9qvDlOepoLo
        epG4WMoxHUtiK77WfwDlC70=
X-Google-Smtp-Source: AGs4zMafHgOQ8yXKCVsgmohix9LHvOVq57BFWjUWI82YZvHqGr8KmSRDGxPtwXaTpn53x94Z9r/oIQ==
X-Received: by 10.36.182.2 with SMTP id g2mr3201549itf.72.1511286905429;
        Tue, 21 Nov 2017 09:55:05 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i133sm3752596itf.1.2017.11.21.09.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 09:55:05 -0800 (PST)
Date:   Tue, 21 Nov 2017 09:54:36 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: pedantry: is there a standard for what should be in the SYNOPSIS?
Message-ID: <20171121175436.GA27041@aiede.mtv.corp.google.com>
References: <alpine.LFD.2.21.1711210925530.6795@DESKTOP-1GPMCEJ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1711210925530.6795@DESKTOP-1GPMCEJ>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Robert P. J. Day wrote:

> following up on an earlier question of mine, is there a standard for
> what options should be listed in either the SYNOPSIS or the
> DESCRIPTION sections of a man page? i ask since i'm seeing some
> definite inconsistency.

No standard.  Seems worth starting a discussion on what you'd like the
standard to be.

Jonathan
