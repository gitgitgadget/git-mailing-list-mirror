Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4563EE14D8
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 10:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242231AbjIJKSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 06:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjIJKSh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 06:18:37 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04876CCC
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 03:18:33 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 02BEB20391;
        Sun, 10 Sep 2023 06:18:30 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qfHWQ-YHg-00; Sun, 10 Sep 2023 12:18:30 +0200
Date:   Sun, 10 Sep 2023 12:18:30 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
Message-ID: <ZP2X9roiaeEjzf24@ugly>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 09, 2023 at 11:14:20PM +0200, René Scharfe wrote:
>Convert the offending OPT_CMDMODE users and use the typed value_int
>point in the macro's definition to enforce that type for future ones.
>
that defeats -Wswitch[-enum], though.

the pedantically correct solution would be using setter callbacks.

regards
