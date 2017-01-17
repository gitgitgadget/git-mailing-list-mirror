Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E0E20756
	for <e@80x24.org>; Tue, 17 Jan 2017 22:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751071AbdAQWGd (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 17:06:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41216 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdAQWGb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 17:06:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1F51F601D1; Tue, 17 Jan 2017 22:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1484690734;
        bh=dRFQjAZgJvRrNLVSk8UTDOYvW2oLeJsCbaufQV7pSLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXCNJAoRXu4zevyMOxcH/YbKDHHP4vtzOaOzx/jAJwiV80V4nkNGRgmYlBGyoI1Pf
         4x4aOgJT+JejBZEnGcpvTQhuXxweWXB/ScSR+4UsNX17+Vx8lPAt9ZaUAAj6Ipgsj3
         XvSbkn7FCK77UdgR280ZVNACcmeOA1rc6rois8fM=
Received: from mfick1-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2293601D1;
        Tue, 17 Jan 2017 22:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1484690733;
        bh=dRFQjAZgJvRrNLVSk8UTDOYvW2oLeJsCbaufQV7pSLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iUsKmJAtSLHVqD/961BfTnPtr46QU2TmDc3owtoLa5R+LvuBG54yTdy6C2iEvo//5
         NqOzQPtxMQRqFKutPLEohyPHLoIErLTFMFeCt86gIR9dsNkHf3lqy2VuAEGBfBFfNY
         7bzI3uho2C+6J0rcepD5hm/gZqxyNSjcv3EPM4yo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2293601D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Ben Peart <peartben@gmail.com>
Cc:     'Shawn Pearce' <spearce@spearce.org>, 'git' <git@vger.kernel.org>,
        benpeart@microsoft.com
Subject: Re: [RFC] Add support for downloading blobs on demand
Date:   Tue, 17 Jan 2017 15:05:32 -0700
Message-ID: <2381666.1DSVtKRIH5@mfick1-lnx>
User-Agent: KMail/4.8.5 (Linux/3.2.0-106-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <002501d2710b$af74c4d0$0e5e4e70$@gmail.com>
References: <20170113155253.1644-1-benpeart@microsoft.com> <CAJo=hJumYXTRN_B3iZdmcpomp7wJ+UPcikxGb6rn9W=uJeYmfw@mail.gmail.com> <002501d2710b$af74c4d0$0e5e4e70$@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, January 17, 2017 04:50:13 PM Ben Peart wrote:
> While large files can be a real problem, our biggest issue
> today is having a lot (millions!) of source files when
> any individual developer only needs a small percentage of
> them.  Git with 3+ million local files just doesn't
> perform well.

Honestly, this sounds like a problem better dealt with by 
using git subtree or git submodules, have you considered 
that?

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

