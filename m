Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2216C77B7D
	for <git@archiver.kernel.org>; Wed, 17 May 2023 17:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjEQRCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 13:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEQRCf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 13:02:35 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F2D9E
        for <git@vger.kernel.org>; Wed, 17 May 2023 10:02:34 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id E64FD23F67;
        Wed, 17 May 2023 13:02:32 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pzKXo-KbD-00; Wed, 17 May 2023 19:02:32 +0200
Date:   Wed, 17 May 2023 19:02:32 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
Message-ID: <ZGUIqBU0+Vr5LSBF@ugly>
Mail-Followup-To: phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <3f5e4116-54e6-9753-f925-ed4a9f6e3518@gmail.com>
 <ZGSlqAPwaLhgWm6v@ugly>
 <2d416834-ef3e-01a2-6be0-9e88bc0de25e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2d416834-ef3e-01a2-6be0-9e88bc0de25e@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023 at 12:20:03PM +0100, Phillip Wood wrote:
>I'm saying that reverting a commit with a subject line
>
>	Revert "Revert "Revert some subject""
>
>should result in the new commit having the subject
>
>	Revert "Revert "Revert "Revert some subject"""
>
>(i.e. at that point we stop trying to be clever) rather than
>
>	Revert "Reapply "Revert some subject""
>
right.
how about filing that under GIGO and extending the comment?
i mean, when you actually run into this situation, you should be 
re-thinking your life choices rather than stressing about git producing 
a somewhat suboptimal commit message template ...

regards,
ossi
