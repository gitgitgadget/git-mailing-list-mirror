Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 496A11F404
	for <e@80x24.org>; Thu, 16 Aug 2018 07:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389474AbeHPKnd (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 06:43:33 -0400
Received: from server65.mylittledatacenter.com ([78.46.58.69]:51626 "EHLO
        server65.mylittledatacenter.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388005AbeHPKnd (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Aug 2018 06:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=hadisafari.ir; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+gdiEG+q/ELVNi/erjKngCAtI5teLkjjdWDZCbOSa7s=; b=rotFqYckpc2mCUOIU0OgrzrA74
        B5EgOPwode+vUlRstTFxZyfl9YmN/UdIKR8J2UVr11eePzz7sExYsaOKX7Y9F98YsugNsvaIJPim5
        iaubMasFf5iN5ipfjUER3ky6UkLaV2dKPCQhfOs+QntBewDTMPVwlBialmUNHz/kqGh9pVgdiJIbl
        As26lyIlKk+447LqjyKMKSnAAAFrPNr9v3zBGuxBt1eol1yR5GZ87qIhzEE87+Euzy5wNdDAtYg36
        XYTjAMeN2XsoXiSYY+xHKtWGZwUVgBxdislwuAKxt+LH5V1HR7JPzpZigdixYm6O22pbI5uX4gpgU
        fC+G50Lw==;
Received: from [5.113.21.147] (port=19467 helo=Hadi.local)
        by server65.mylittledatacenter.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <hadi@hadisafari.ir>)
        id 1fqCze-00BiaX-7P
        for git@vger.kernel.org; Thu, 16 Aug 2018 12:16:54 +0430
To:     Git Users <git@vger.kernel.org>
From:   Hadi Safari <hadi@hadisafari.ir>
Subject: Incomplete bash completion on git commit: --allow-empty-message and
 --allow-empty
Message-ID: <69624916-f6ba-d4a4-e346-69498662905e@hadisafari.ir>
Date:   Thu, 16 Aug 2018 12:16:51 +0430
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server65.mylittledatacenter.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - hadisafari.ir
X-Get-Message-Sender-Via: server65.mylittledatacenter.com: authenticated_id: hadi@hadisafari.ir
X-Authenticated-Sender: server65.mylittledatacenter.com: hadi@hadisafari.ir
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I'm wondering why there isn't --allow-empty and --allow-empty-message in 
completeion list of git commit command. I'm getting only following flags 
from v2.18.0 on `git commit --`:

--ahead-behind      --include           --reedit-message=
--all               --interactive       --reset-author
--amend             --long              --reuse-message=
--author=           --message=          --short
--branch            --no-edit           --signoff
--cleanup=          --no-post-rewrite   --squash=
--date=             --no-verify         --status
--dry-run           --null              --template=
--edit              --only              --untracked-files
--file=             --patch             --verbose
--fixup=            --porcelain         --verify
--gpg-sign          --quiet

Besides, is there any way to allow empty commit message for a repo, e.g. 
by adding something to `.git/config`? I couldn't find any in docs.

-- 
Hadi
