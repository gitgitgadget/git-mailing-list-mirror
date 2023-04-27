Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC3DC77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 07:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbjD0Htx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 03:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243068AbjD0Htv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 03:49:51 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AA9DD
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 00:49:50 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 6906924196;
        Thu, 27 Apr 2023 03:49:48 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1prwNw-sLt-00; Thu, 27 Apr 2023 09:49:48 +0200
Date:   Thu, 27 Apr 2023 09:49:48 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf_stripspace(): rename skip_comments arg to
 strip_comments
Message-ID: <ZEopHDNl69ZBcpps@ugly>
Mail-Followup-To: git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <20230323162234.995405-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230323162234.995405-1-oswald.buddenhagen@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ping!

On Thu, Mar 23, 2023 at 05:22:34PM +0100, Oswald Buddenhagen wrote:
>That makes its function much clearer and more consistent with the
>context.
>
