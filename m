Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by archive.lwn.net (Postfix) with ESMTP id E37387D910
	for <lwn-git@archive.lwn.net>; Wed, 11 Mar 2020 16:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgCKQAS (ORCPT <rfc822;lwn-git@archive.lwn.net>);
        Wed, 11 Mar 2020 12:00:18 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:47864 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729841AbgCKQAS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Mar 2020 12:00:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583942418; h=Content-Type: Content-Transfer-Encoding:
 MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Cc:
 To: From: Sender; bh=tzI1QJVktGdYnw7yFraT5Nq+MPJHuc6YShC5yPSzoGM=; b=ITSO6lRD+o45yPa8Mr8rr3RnkZij5Wx/Tb4VW1m1VB7wffQsU4IGEn+wmk5pP6JdHe7Vm8f1
 +wcH+iSP0BfSPGHfSwlURuvTeMBaRWuf3zycpJCXmGGelgyLF7qj/EMFu2GupcZ6pg1ilgLO
 6mWAjkj5trK5arrPTCPyfyqO8WE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e690b06.7f2241b958f0-smtp-out-n03;
 Wed, 11 Mar 2020 16:00:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9A438C433D2; Wed, 11 Mar 2020 16:00:04 +0000 (UTC)
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 53E1EC433CB;
        Wed, 11 Mar 2020 16:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53E1EC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Christos Pappas <chrispappas99@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Feature request] Give non-unique names to commits for grouping
Date:   Wed, 11 Mar 2020 10:00:03 -0600
Message-ID: <2001043.V3P9HlvaID@mfick-lnx>
User-Agent: KMail/5.1.3 (Linux/4.4.0-154-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <CAGa6KtSgGOLVjHdubwRW=Bvnjnp2PoP7jJ5_NxNWGFLrVYT9SA@mail.gmail.com>
References: <CAGa6KtSgGOLVjHdubwRW=Bvnjnp2PoP7jJ5_NxNWGFLrVYT9SA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://archive.lwn.net:8080/git/2001043.V3P9HlvaID@mfick-lnx/>
List-Archive: <http://archive.lwn.net:8080/git/>
List-Post: <mailto:git@vger.kernel.org>

On Wednesday, March 11, 2020 1:16:09 AM MDT Christos Pappas wrote:
> I suggest that we should have the option to mark each commit with a
> category name, that is not necessarily unique (like 'tags') so we
> could have commit groups.
> For example we could:
> git mark {commit_id} {name}
> 
> Then we could give special functionality to some commands based on
> those "marks".
> For example if we had marked a few commits with the name 'fix_typo'
> git log --mark fix_typo. Show all the commits marked with 'fix_typo'
> git blame --mark fix_typo Run git blame but ignore commits with 'fix_typo'

Perhaps git notes could be used to do something like this?

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
