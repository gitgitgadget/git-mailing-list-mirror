Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 922C8200B9
	for <e@80x24.org>; Fri, 18 May 2018 15:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbeERPpT (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 11:45:19 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:48618 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeERPpS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 11:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rFkUbp6NWvOTzs0gDzvasAX7yi659bGvjMAsH2dIRbg=; b=pzCT5sGcyVhG84BCgiQ3gMh/4
        9Obe0amF+viYE79QQFBhOgjKQF07dNTrChjZm4rXStx8p2Oqt9sBVp7tk0ZSp4It+Zkq6Nj+fW2GI
        miSyTbUSsvZORKiEBX1jj9+PJ/RhpY1Uc/5KWdz3H0YV8KQqEfjVVxesRIi/7ZoUkDvFvOXlgoyl3
        J0wCIzdowhaIg5yzdQ+QrwtDQ3qvDQDFAXB3RGGxEslWwf0gqjKiExMcW2Rg+G/VUG3monhe164Yt
        mWdEt/tbrTS4R9rwTS+PiHN0TAqcC8gIbA5MBI75hQJE0k/+XvGK+I5ijl10z3P+MJfIRwy3rQYUu
        S3H4ivSJg==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:35726 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fJhZE-00FeeU-JL; Fri, 18 May 2018 11:45:17 -0400
Date:   Fri, 18 May 2018 11:43:48 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Sybille Peters <sypets@gmx.de>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: error(?) in "man git-stash" regarding "--keep-index"
In-Reply-To: <96486abe-cf13-ef10-7513-2d6c20a9dc1e@gmx.de>
Message-ID: <alpine.LFD.2.21.1805181141030.10462@localhost.localdomain>
References: <alpine.LFD.2.21.1805180534170.6786@localhost.localdomain> <CAN0heSrJMFij9xt6RstLD16+2CxJ_HALer4iRL74AZQvH0VWRQ@mail.gmail.com> <alpine.LFD.2.21.1805180648020.10270@localhost.localdomain> <CAN0heSpVKd=-Dpdk09LVtTd0vC2dLUwg0=hbxhKskM3RencsYA@mail.gmail.com>
 <96486abe-cf13-ef10-7513-2d6c20a9dc1e@gmx.de>
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

On Fri, 18 May 2018, Sybille Peters wrote:

> My 2c on this:
>
> 1) "If the --keep-index option is used, all changes already added to
>    the index are left intact" (manpage git stash)
>
> That appears to be correct and clear

  yup, that's not the issue.

> 2) "$ git stash push --keep-index # save *all other* changes to the
>    stash"  (manpage git stash)
>
> That is either not correct or misleading. "All other" implies in my
> opinion all changes except the ones that were already added. *"All
> changes including already staged changes"* might be a better choice.

  yup, that is *exactly* the point i was trying to make.

rday
