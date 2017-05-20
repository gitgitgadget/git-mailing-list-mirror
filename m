Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57315201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756180AbdETViB (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:38:01 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36643 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755988AbdETViA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:38:00 -0400
Received: by mail-pf0-f173.google.com with SMTP id m17so54539933pfg.3
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=90ToygSz0eioYvfEjcHSgEyZkKWSkaxZ/EyPj19tJcE=;
        b=aL7h3SWT4fdMYMaW9i13rJKdjMrBKhsoT12rY7m1PHdT5f/f6nIOoxtJpMetA8DKag
         t6rd4cnjKaRxwxfcMRspA+UpBmoYe6sD9Gzv6OMgblxOx70Ur1rrGRceMMJ3FMKiQwch
         oCXt0rReV3J6jzLMi/v/lBP8vL2Luqp2K3o2XAfMWt7maFY0ewcFJD/IYT47H9aEAep7
         pKHBkEXaAQTZ/LdD5buJLkFBvPaNtKVuWFsMU80bH5b+964H0GQiyeo0AjkXyq/F1OGc
         KzAMjztjIky7+Tr5bJ2eT/koB/Q8sxXRs+e6Czk6u/5MeBOxSYzTMcMZ5LPWDCnUbOk5
         LCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=90ToygSz0eioYvfEjcHSgEyZkKWSkaxZ/EyPj19tJcE=;
        b=d1NECZzbnjwhdm4ie6Qc3KPglDC2PhXtJ4EZCZY9UTadBNU4bcrNPvETE5fekHPWJP
         jK3XX8m89SZWBdElsAIx5uc53jJ3gERfxhaYBZ8GJ/wsFY519k7AZugQH3O1lcKC6mqn
         brxCzTit3qCEhBBdbhC4Ya3UY4ovs3HUb6vZi+VlF9dELd9dLjHZuj+zZYunVc+u8qtl
         KuSgMCKPNKfThoT5Cr5a+8gWXljxprJXoyNVLDzrgqd5fgnFwpimDRezmFjZ3rHf5S3S
         N/r/ya7jPEbt+5pLqLHvUNedAxiG2u8+OoXoTabZ22KEM3kqqMAmP26RQRBfGE2b1e8n
         1zzQ==
X-Gm-Message-State: AODbwcDtXwPpKzmWSxDfNgfgTUqyejUzAmC8J5vtHY0pTydDDOfTfFKI
        FOt00Vi72hE4O49914WTpVuUVrbgG2aE
X-Received: by 10.84.228.207 with SMTP id y15mr19191530pli.172.1495316280169;
 Sat, 20 May 2017 14:38:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Sat, 20 May 2017 14:37:59 -0700 (PDT)
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 20 May 2017 14:37:59 -0700
Message-ID: <CAGZ79kbvhRzjbfiUNuc364tM8j1TpNEtGt6rtfG2h9Y=v4TVHw@mail.gmail.com>
Subject: Re: [WIP/RFC 00/23] repository object
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 4:21 PM, Brandon Williams <bmwill@google.com> wrote:

> This is still very much in a WIP state, though it does pass all tests.  What
> I'm hoping for here is to get a discussion started about the feasibility of a
> change like this and hopefully to get the ball rolling.  Is this a direction we
> want to move in?  Is it worth the pain?

I would be really happy to see this series land eventually.

The introduction of a repo object will deliver performance at a higher
level, such as
* (remarked by Ben): enabling of threading
* submodules do not need to spawn processes
* I would imagine that developer velocity will go up by having less global state
  in the long run.

Thanks for working on this.
Stefan
