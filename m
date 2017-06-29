Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41DE5202A7
	for <e@80x24.org>; Thu, 29 Jun 2017 23:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbdF2XlW (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 19:41:22 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34414 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbdF2XlW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 19:41:22 -0400
Received: by mail-pf0-f174.google.com with SMTP id s66so57756456pfs.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 16:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZgBaBQH0ivDg1ot/TWHCPW3pQ9ocvCDfqU/KFr74ClY=;
        b=usV/berhjcAcEb32wTz91mFZ1eIDk7P718XDY7k/UgYh+6v415leHZzs+jXFk8FZEX
         76xtyV5yCrDFACE0S66fGhUkzJHKOABF14J1kyax/4kO5e6/0TpZBC/zUg4EsDNADZ+1
         lVDTihzOEae3+z+tC/BA8vGoqC8ZjrD2OOoERwaqAG2zN86SVGJ2bQCE3owyUyQYipLW
         fkblxqXY3pXIlDL3cbsgGH4VibUbNxUh1fOXlYX6vIs4LZbcZPDwJDpFAYEb2Qd4U16U
         ++Z1PvdJl5Qiae4XDIIgZcsZTbSkv5ktY20lLzHIZXncpHMXb4uYG/lIA7ei5/Ncw9Ld
         +gVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZgBaBQH0ivDg1ot/TWHCPW3pQ9ocvCDfqU/KFr74ClY=;
        b=Dy08cEBJ2s/OKr/InrfFgNJgm1NIs0e2jTEmLrJb3Bekz3xtKHJLoufjAmmHkojJfS
         wjMQ9Uqd2U4kMv9lOIoqEX4AguMDBpx640N/aeKuJiWgZMarohdT81Ub0dhi3vAuQ3/X
         xtlu1HsqWZQGzvRNChLVZjRX/7fARcnkkgll+AqO1CsZ5G6m7/z7mBScQ90+buCIw0AE
         Hfuz4WoDEV+TJm9hKR5pcJYMXP57e5E6kfXM8xLhpk5lCclXoM2pbolwAUJ5LJ6tRZh0
         w7xt99ISJRGkOCmEUcSOczUEWpSDJ71zE10Hy1iqzT64wNg7YZUq9PBPqoxn+6e6p9rV
         CxyA==
X-Gm-Message-State: AKS2vOwrCvScPjPE7useVUX6et68DSrwH6AeL7YhWeaKtdXLMxyE3R3m
        4n4LgGCJhEIq80hQEpK4XQGfq+ibGC5Zfeg=
X-Received: by 10.98.69.76 with SMTP id s73mr18802200pfa.94.1498779681191;
 Thu, 29 Jun 2017 16:41:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Thu, 29 Jun 2017 16:41:20 -0700 (PDT)
In-Reply-To: <20170629211832.GB68015@aiede.mtv.corp.google.com>
References: <20170629011334.11173-1-sbeller@google.com> <20170629011334.11173-3-sbeller@google.com>
 <20170629211832.GB68015@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 29 Jun 2017 16:41:20 -0700
Message-ID: <CAGZ79kb8PJpEu+Wq_+JG208xXcJpoPMJe26xXN-Gck3L0G2yrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hashmap: migrate documentation from
 Documentation/technical into header
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Took all suggestions so far, but the last one:

>
> Probably worth mentioning this is a convenience wrapper for iter_init
> + iter_next, like the Documentation/technical/ text did.

No. The code to observe that this is a convenience wrapper
IS RIGHT THERE (it's a header file), and I find this header a
bit bloated already. So I'll keep it as a one liner.
