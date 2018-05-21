Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DDD11F51C
	for <e@80x24.org>; Mon, 21 May 2018 18:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750930AbeEUSQa (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 14:16:30 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:51636 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbeEUSQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 14:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J271si+3VSBmJMc2RnHFZPrPihS63i7dO/unhyAwP7w=; b=nhSc8MvN1i0EwGM33FCj5Kn/P
        YFxY1p+X7uWi8/v+sNoEUbV2wEWBS9PrSb2QF7yBnc3+88ZiCzsl3rG+MHXLO7oESQ0A0w75+miBA
        VohyZbNf9i+nWoLUOdbQL+I7EE9msoqlyIV06SewmhlffKVZCA/D2py3p6YUBB82JXXSs925o9kFf
        tBqxHBHVARwP/MUDxj7TeX2NgseS7AmuOqwdj5l9HZAVSzdYsLg97aVW7V3BG6UR9HQd9qC4rrBmU
        AXDoTBqZ5d4OVzcdHY4OYWFvhU/jjX8/0zY39LaoRVSqJRU0S7bEaqOmAAc7ZdEyPE7D7Mk4oT0UW
        ffj+4Mozw==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:53600 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fKpMB-00GrSX-6D; Mon, 21 May 2018 14:16:28 -0400
Date:   Mon, 21 May 2018 14:14:56 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: which files are "known to git"?
In-Reply-To: <CABPp-BGsa+e_4XuK0xaKbcNxg5CS8UuAjYNP9XWpAhXOPs7iaQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1805211414010.22297@localhost.localdomain>
References: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain> <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com> <alpine.LFD.2.21.1805211335250.21160@localhost.localdomain>
 <CABPp-BGsa+e_4XuK0xaKbcNxg5CS8UuAjYNP9XWpAhXOPs7iaQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
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

On Mon, 21 May 2018, Elijah Newren wrote:

> > can anyone refresh my memory if that happened here, and whether
> > that was the consensus after the discussion was over?
>
> Perhaps this: https://public-inbox.org/git/EEC5BA1D5F274F02AE20FC269868FDEF@PhilipOakley/
> ?

  yup, that's it, thanks.

rday
