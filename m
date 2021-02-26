Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C446C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 00:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF0D864F1B
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 00:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhBZAal (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 19:30:41 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:53348 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhBZAaj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 19:30:39 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1lFR12-005RgC-C8; Thu, 25 Feb 2021 17:29:56 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1lFR11-00Dg1N-HQ; Thu, 25 Feb 2021 17:29:55 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 5E01E501889;
        Thu, 25 Feb 2021 17:29:55 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7d1yQGu2oUJA; Thu, 25 Feb 2021 17:29:55 -0700 (MST)
Received: from ellen.lan (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id A9A045018A3;
        Thu, 25 Feb 2021 17:29:54 -0700 (MST)
Date:   Thu, 25 Feb 2021 17:29:52 -0700
From:   Seth House <seth@eseth.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, pudinha <rogi@skylittlesystem.org>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <YDhBAPbU/T8BldrS@ellen.lan>
References: <20210214022840.849312-1-seth@eseth.com>
 <b3467a47-dffd-154f-76f9-e09b8145a5e5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3467a47-dffd-154f-76f9-e09b8145a5e5@gmail.com>
X-XM-SPF: eid=1lFR11-00Dg1N-HQ;;;mid=<YDhBAPbU/T8BldrS@ellen.lan>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [PATCH 0/1] mergetools/vimdiff: add vimdiff1 merge tool variant
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 25, 2021 at 01:45:16PM -0500, Philippe Blain wrote:
> I think it would be good to add a short note about these variants somewhere
> in Documentation/git-mergetool.txt. Might be in this patch, or not if you don't
> feel like it...
> 
> Going further, we could even add a short (few words) description of each tool
> and have that description show up in the output of  'git mergetool --tool-help',
> something like this:
> 
> $ git mergetool --tool-help
> 'git mergetool --tool=<tool>' may be set to one of the following:
> 		emerge		Emacs (Emerge)
> 		opendiff	Apple FileMerge
> 		vimdiff		Vim (??)
> 		vimdiff2	Vim (3 panes)
> 		vimdiff3	Vim (4 panes)

Great suggestions, thanks. A little explanation would be very helpful --
I've been confused by those variants too and wondered why I might want
to use one over another.

I'll roll those into this patch.

