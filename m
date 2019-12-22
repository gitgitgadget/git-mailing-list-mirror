Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48DEC2D0C0
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 09:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB21A206CB
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 09:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLVJ73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 04:59:29 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:56331 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfLVJ72 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Dec 2019 04:59:28 -0500
X-Originating-IP: 157.36.67.128
Received: from localhost (unknown [157.36.67.128])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 82CCB1BF206;
        Sun, 22 Dec 2019 09:59:26 +0000 (UTC)
Date:   Sun, 22 Dec 2019 15:29:21 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     git@vger.kernel.org
Cc:     Vasili Novikov <vasilii.novikov@zivver.com>
Subject: Re: [PATCH v2] git-gui: allow closing console window with Escape
Message-ID: <20191222095921.drny6mg3h6y4l3zw@yadavpratyush.com>
References: <20191218195809.7658-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218195809.7658-1-me@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/12/19 01:28AM, Pratyush Yadav wrote:
> This gives users a quick shortcut to close the window. But since the
> window can also show commands in progress, closing the window on Escape
> can give the perception that the command has been cancelled even though
> it hasn't been. So, only enable this binding when the command is done.
> 
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>

Merged to 'master'.

-- 
Regards,
Pratyush Yadav
