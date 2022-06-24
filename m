Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C80C433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 21:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiFXVRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 17:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiFXVRc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 17:17:32 -0400
X-Greylist: delayed 1438 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Jun 2022 14:17:26 PDT
Received: from gateway13.unifiedlayer.com (gateway13.unifiedlayer.com [74.220.211.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8234F86ACE
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 14:17:26 -0700 (PDT)
Received: from cm1.websitewelcome.com (unknown [192.185.0.102])
        by gateway13.unifiedlayer.com (Postfix) with ESMTP id 3257320141E71
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 15:53:28 -0500 (CDT)
Received: from uscentral455.accountservergroup.com ([174.136.13.174])
        by cmsmtp with ESMTP
        id 4qIyoUZ3lKPTU4qIyoiHnT; Fri, 24 Jun 2022 15:53:28 -0500
X-Authority-Reason: nr=8
Received: from 76-222-220-222.lightspeed.rcsntx.sbcglobal.net ([76.222.220.222]:29593 helo=bigbox.attlocal.net)
        by uscentral455.accountservergroup.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <git@tim.thechases.com>)
        id 1o4qIx-0031ib-UV
        for git@vger.kernel.org; Fri, 24 Jun 2022 15:53:27 -0500
Date:   Fri, 24 Jun 2022 15:53:26 -0500
From:   Tim Chase <git@tim.thechases.com>
To:     git@vger.kernel.org
Subject: Re: stashing only unstaged changes?
Message-ID: <20220624155326.1a0494ea@bigbox.attlocal.net>
In-Reply-To: <20220624081615.zhurjajwuvtvzs2y@feather>
References: <20220621142618.239b02cd@bigbox.attlocal.net>
        <20220624081615.zhurjajwuvtvzs2y@feather>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; amd64-portbld-freebsd13.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - uscentral455.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-BWhitelist: no
X-Source-IP: 76.222.220.222
X-Source-L: No
X-Exim-ID: 1o4qIx-0031ib-UV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 76-222-220-222.lightspeed.rcsntx.sbcglobal.net (bigbox.attlocal.net) [76.222.220.222]:29593
X-Source-Auth: tim@thechases.com
X-Email-Count: 3
X-Source-Cap: dGhlY2hhc2U7dGhlY2hhc2U7dXNjZW50cmFsNDU1LmFjY291bnRzZXJ2ZXJncm91cC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-06-24 10:16, Reto wrote:
> https://lore.kernel.org/git/xmqq5ylior3l.fsf@gitster.g/
>   
> > The intended use of "stash" is to clear the deck as quickly as
> > possible to deal with "emergencies"    

Understandable.  Just in my case, the deck I wanted to clear to
quickly was the contents of the index, not the HEAD commit.

-Tim

