Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25631C6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 21:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCWV1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 17:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjCWV1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 17:27:25 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800302E834
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 14:27:16 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 4E3AE20309
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:27:15 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfSSp-gQF-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 22:27:15 +0100
Date:   Thu, 23 Mar 2023 22:27:15 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: [PATCH 3/8] sequencer: pass around rebase action explicitly
Message-ID: <ZBzEMwQ6p+ca6wdD@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-4-oswald.buddenhagen@gmx.de>
 <fa584725-52a5-ab7f-3f7b-2fc70fa8fbe1@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fa584725-52a5-ab7f-3f7b-2fc70fa8fbe1@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 07:27:25PM +0000, Phillip Wood wrote:
>I appreciate the sentiment  behind this patch, but it looks like an 
>awful lot of churn just to clean up a couple of lines in 
>append_todo_help() and edit_todo_list().
>
as much as i dislike churn, i dislike fragile "magic" code even more.
