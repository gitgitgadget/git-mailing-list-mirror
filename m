Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA45AC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 09:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149C120809
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 09:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Uq5IKNvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgIJJRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:17:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42025 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730184AbgIJJRg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 05:17:36 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 4BnCvn6BVMz9sTq; Thu, 10 Sep 2020 19:17:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1599729445; bh=2PLSdG7avDRsOoObIGT8yNKY60eBU8X8o6oXVoqEQpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uq5IKNvOfVJdllkgnu+UoTU/VVM7J9qUSUL/P7w6vwZgsxCvGEu4T4GI5sHTalFbJ
         g6z65GrtxUx3TGicF7E4sMwMsz4mh06KMHjnqU9oR7SiXN0HvjiS7vtFFtk+ZwQa/i
         H0UWxD45izuI1fCTP6Cfu9DASwA39Q4KRKl7OUobMKSHGx7kl5RvnrhqJc1eZ6SINs
         Yd1kK067d8ZP6cuJm6pWa4dySLpm/oD0srnSF1/a3spS6fl/6jLzHW9JO0TFpXL8Wm
         SeO70/vaV5rYXBVaWv5UBWsWN2PpHF4ub/obQefeZGASyVvoYsmcQbN0BGzBURspwH
         KcJqTqMcEccqA==
Date:   Thu, 10 Sep 2020 19:17:19 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] gitk: fix mix of tabs and spaces in indentation
Message-ID: <20200910091719.GB2537966@thinks.paulus.ozlabs.org>
References: <cover.1599726439.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1599726439.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 10, 2020 at 01:27:40AM -0700, Denton Liu wrote:
> The source code of gitk has some funny indentation. It uses four spaces
> per level indent but uses tabs every other level (eight spaces).
> Reindent gitk to just use tabs instead.

I don't think I want to do this.  I would accept changing all the
indentation to use just spaces - at least that's going to look OK
regardless of the tab width setting.

Paul.
