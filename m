Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C259F1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 19:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754328AbeFLTQV (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 15:16:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40156 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932483AbeFLTQU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 15:16:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8928E602FC; Tue, 12 Jun 2018 19:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528830980;
        bh=KXINKWlVDBhQE49fmWN0t/cP1R+AWc8zApy5oWJQ1ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIRwyfvjAZhSn+XXhi+P8PvwlTFryiDWXPpfXwecZK/Snmk24T1/98neK3wNBIpgd
         fSPKgyxSEry+RTYjDOP9jtYfoaZcJDeWHneAAfwYFCC407rnZO6Z1wYAsZ6M8Quwk4
         X4M5fKxmgsCqe5Spia3cYyeih6nV0bFZ4eFbQMd8=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2374D602BD;
        Tue, 12 Jun 2018 19:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528830980;
        bh=KXINKWlVDBhQE49fmWN0t/cP1R+AWc8zApy5oWJQ1ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIRwyfvjAZhSn+XXhi+P8PvwlTFryiDWXPpfXwecZK/Snmk24T1/98neK3wNBIpgd
         fSPKgyxSEry+RTYjDOP9jtYfoaZcJDeWHneAAfwYFCC407rnZO6Z1wYAsZ6M8Quwk4
         X4M5fKxmgsCqe5Spia3cYyeih6nV0bFZ4eFbQMd8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2374D602BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Peter Backes <rtc@helen.plasma.xg8.de>
Cc:     David Lang <david@lang.hm>, Philip Oakley <philipoakley@iee.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Date:   Tue, 12 Jun 2018 13:16:17 -0600
Message-ID: <5587534.o6tcmYBVvN@mfick-lnx>
User-Agent: KMail/4.13.3 (Linux/3.13.0-144-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <20180612191219.GA17935@helen.PLASMA.Xg8.DE>
References: <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley> <alpine.DEB.2.02.1806121152530.10486@nftneq.ynat.uz> <20180612191219.GA17935@helen.PLASMA.Xg8.DE>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, June 12, 2018 09:12:19 PM Peter Backes wrote:
> So? If a thousand lawyers claim 1+1=3, it becomes a
> mathematical truth?

No, but probably a legal "truth". :)

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

