Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1819A20248
	for <e@80x24.org>; Sat, 16 Mar 2019 12:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfCPMPd (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 08:15:33 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:45768 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfCPMPd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 08:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9UI8HjSSsplUqeUJa76Y5IjUWZNksKkZyFEMqB6SfiU=; b=kprFsfLPArj8h0LlZnEZbCgZB
        6rwbeVDPUopUp+kKJwj4NkuyEF18A/88bKo1waij0KRIQMK0Va0fqMNTepteWMnC6a6bC1ROsiUF2
        Vni7DrZRSSe50kMnim/QbMgTQNeQZAmGyuOBhtfTbNPMCzw2sNO37nYx1GcJJtym3+S+zs9FO3FS5
        3Ub6hOO+NXB2wlXNooub2diMWZZ/nFHUPfto3IXYbLoNcspFpZhEMPOyXSv9RN8K0gUPHCuxhuK8R
        cYNVet91n4b+dk4WWcCiTGXCiPTMpOZwfhaCLwlKxCHTNeypmenK96PPN3JoHYpD+5430KixSjRTl
        i+EtmPETA==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:43366 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h58Dr-00Av9x-1H; Sat, 16 Mar 2019 08:15:31 -0400
Date:   Sat, 16 Mar 2019 08:15:18 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "git clone --shallow-exclude ...", fatal: the remote end hung
 up unexpectedly
In-Reply-To: <CACsJy8AxBr1AUwsPb6FZkJ5Pn9AfooW04Gz4fsdjF6VcP87g3w@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1903160814460.10672@localhost.localdomain>
References: <alpine.LFD.2.21.1903150809070.26709@localhost.localdomain> <CACsJy8DVRJ4DG6PEkFuzytOQJ7RX6GMaHd4BRQTR9N7Y9V6fqQ@mail.gmail.com> <alpine.LFD.2.21.1903150917360.27423@localhost.localdomain> <CACsJy8CspqxDhOZFF7ac_63TQXvsHjTBicEPtZaUSOmaQnzs4A@mail.gmail.com>
 <alpine.LFD.2.21.1903151027580.29322@localhost.localdomain> <CACsJy8AxBr1AUwsPb6FZkJ5Pn9AfooW04Gz4fsdjF6VcP87g3w@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 16 Mar 2019, Duy Nguyen wrote:

> On Fri, Mar 15, 2019 at 9:31 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >   also, i think "man git-clone" could really use a set of examples for
> > shallow cloning. i'd offer to write it but i'm still figuring it out.
>
> Cool. I'll give you a quick introduction to help with those examples
> :D

  ... snip ...

  i can see today is going to be busy ... thanks for all that, will
start reading shortly.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
