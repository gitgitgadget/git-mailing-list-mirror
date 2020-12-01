Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017B0C71155
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C508F206F9
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbgLATmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 14:42:01 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:32979 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLATmB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 14:42:01 -0500
X-Originating-IP: 103.82.80.86
Received: from localhost (unknown [103.82.80.86])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C958940003;
        Tue,  1 Dec 2020 19:41:18 +0000 (UTC)
Date:   Wed, 2 Dec 2020 01:11:16 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Miguel Boekhold <miguel.boekhold@osudio.com>,
        Efimov Vasily <laer.18@gmail.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-gui: ssh-askpass: add a checkbox to show the input
 text
Message-ID: <20201201194116.mvm7svakxzyruybx@yadavpratyush.com>
References: <20201107222039.13900-1-davvid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107222039.13900-1-davvid@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11/20 02:20PM, David Aguilar wrote:
> Hide the input text by default since the field is
> commonly used for sensative informations such as passwords.
> 
> Add a "Show input" checkbox to conditionally show the input.
> 
> Helped-by: Miguel Boekhold <miguel.boekhold@osudio.com>
> Signed-off-by: Efimov Vasily <laer.18@gmail.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>

Merged to git-gui/master. Thanks.

-- 
Regards,
Pratyush Yadav
