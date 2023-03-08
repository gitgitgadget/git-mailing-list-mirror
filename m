Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B317C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 23:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCHXtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 18:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCHXs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 18:48:58 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36267E786
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 15:48:57 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 938941F47D;
        Wed,  8 Mar 2023 23:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1678319337;
        bh=CqHzefWpRFxa2bukpqTWT0YbuwNXaopPNgIzAZcvwTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0LXNawIbZ59QVRo2pbVSotsWNNcausnNbP/GKKM6qbvGxX1qFkWr9zs9TdG7yxWH
         rjZtAEptwLVB8sOvjw9SM312wP8Bx8BeCTYENp7lKjSP71pgcwND+NxXX3f1vevc0T
         tVibRmjJ1gW5JPAcc2oyKrYH81B5Dfo6xmU9+HFs=
Date:   Wed, 8 Mar 2023 23:48:57 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] fetch: pass --no-write-fetch-head to subprocesses
Message-ID: <20230308234857.M503278@dcvr>
References: <20230308100438.908471-1-e@80x24.org>
 <xmqqwn3rta2c.fsf@gitster.g>
 <20230308222205.M679514@dcvr>
 <xmqqttyurg4w.fsf@gitster.g>
 <xmqqjzzqrevv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzzqrevv.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I think we should instead enumerate submodule repositories, instead
> > of enumerating existing .git/FETCH_HEAD files.
> 
> Perhaps something along this line?

Sure, can you squash it into mine?  Thanks.
