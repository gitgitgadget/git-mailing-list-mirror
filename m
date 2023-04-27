Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113DDC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 08:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242886AbjD0IL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 04:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbjD0ILZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 04:11:25 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2309B2D71
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 01:11:24 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id BDC8824196;
        Thu, 27 Apr 2023 04:11:22 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1prwio-sbB-00; Thu, 27 Apr 2023 10:11:22 +0200
Date:   Thu, 27 Apr 2023 10:11:22 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: add --description-file option
Message-ID: <ZEouKn2uPP5FAqj7@ugly>
Mail-Followup-To: git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20230323162234.995420-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230323162234.995420-1-oswald.buddenhagen@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ping!

On Thu, Mar 23, 2023 at 05:22:34PM +0100, Oswald Buddenhagen wrote:
>When formatting patches from a detached HEAD, there is no branch
>description to derive the cover letter from. While with format-patch
>one could post-process the generated file (which would be ugly enough),
>scripting that with send-email would be *really* ugly. So add an option
>to feed a description directly.
>
