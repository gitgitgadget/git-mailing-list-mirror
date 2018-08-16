Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25551F404
	for <e@80x24.org>; Thu, 16 Aug 2018 03:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeHPGAA (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 02:00:00 -0400
Received: from server65.mylittledatacenter.com ([78.46.58.69]:48775 "EHLO
        server65.mylittledatacenter.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727457AbeHPGAA (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Aug 2018 02:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=hadisafari.ir; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DxZ4dfTtM9RTSYyRLJyVCuxk10X1Bjaf3TljdXaG9y0=; b=qobBtUJ+XCz8lqTnn/IyKYa+jg
        14vYoOTInNZXCGLD2qbSYay91CQcIrE/JPSMiuXswVMCiWqdxoXnfXz4yNpF9ElL6kTdeIFZInMEg
        R7Izhtd/2HZPgzdRFoPBLBUPVCR9RnsCNO6qxaAi4eYEWCO1/09xzYF1Ed4ZPhvNIfFrSV2j0foPp
        +K80O4e8gDPXS4n98D2sAATjh1f+LArrXJ8uYmDxzxNQNSAwZVJxrpPyB+KAZToyf7ldNr67J0ks6
        /BEJtTIf0Qmbd3+q84FAxUbMj8u9LZuLhQ1732d+1gsumqwJzlRNqcSeo3XWyAt9U18D7gP7Qborm
        91Ueh1qQ==;
Received: from [46.164.97.26] (port=49449 helo=Hadi.local)
        by server65.mylittledatacenter.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <hadi@hadisafari.ir>)
        id 1fq8aZ-009fn9-EB; Thu, 16 Aug 2018 07:34:43 +0430
Subject: Re: "Changes not staged for commit" after cloning a repo on macOS
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
References: <6022fbe8-0e07-f561-5e66-eeb4bc92704d@hadisafari.ir>
 <CAGyf7-EKCznDksZ6jovmtoA94Tj2V95zkMkS3PJrYfEYsO9U3w@mail.gmail.com>
From:   Hadi Safari <hadi@hadisafari.ir>
Message-ID: <3e0d7bd4-003e-60ea-ce1a-323ac49b4f71@hadisafari.ir>
Date:   Thu, 16 Aug 2018 07:34:37 +0430
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGyf7-EKCznDksZ6jovmtoA94Tj2V95zkMkS3PJrYfEYsO9U3w@mail.gmail.com>
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

I checked line-ending but didn't think to file names.

Thank you so much.

On 25/5/1397 AP 1:36 AM, Bryan Turner wrote:
> Taking a look at the repository's file list on GitHub[1], it shows
> that this is because HFS and APFS by default are case-insensitive.
> 
> The file listing shows that there is a "nanoc.gitignore" and
> "Nanoc.gitignore". On APFS and HFS, those are the same file. As a
> result, one overwrites the other. This is discussed pretty regularly
> on the list[2], so you can find more details there.
> 
> [1]: https://github.com/kevinxucs/Sublime-Gitignore/tree/master/boilerplates
> [2]: https://public-inbox.org/git/24A09B73-B4D4-4C22-BC1B-41B22CB59FE6@gmail.com/
> is a fairly recent (fairly long) thread about this behavior.
> 

-- 
Hadi Safari
