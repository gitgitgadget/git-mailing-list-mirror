Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BFCCA0FE6
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 11:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349072AbjIALAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 07:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjIALAP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 07:00:15 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633FD10D7
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 04:00:11 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 5219B2407A;
        Fri,  1 Sep 2023 07:00:09 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qc1sn-Y2X-00; Fri, 01 Sep 2023 13:00:09 +0200
Date:   Fri, 1 Sep 2023 13:00:09 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     =?iso-8859-1?B?Vu10?= Ondruch <vondruch@redhat.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Is there a way to get the "format-patch" formatted file name?
Message-ID: <ZPHEOYyyX+l3AGP1@ugly>
References: <aa35fbdb-cca4-ae04-4124-9498d682ec06@redhat.com>
 <xmqqo7inw2na.fsf@gitster.g>
 <24e10903-29a0-497a-c8d8-b26c02de7336@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24e10903-29a0-497a-c8d8-b26c02de7336@redhat.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 01, 2023 at 10:56:28AM +0200, Vít Ondruch wrote:
>If this was provided as a some convenient script,
>
well, that's the key here: to be actually useful, it needs to be 
integrated into a highly specialized tool. the poor discoverability of 
that in conjunction with its somewhat minor utility is probably a 
sufficient argument for not going that route (beyond personal tool 
collections).
github & co. providing a sensible content-disposition otoh is a 
(somewhat) well-known, generic solution to this problem.

but i wouldn't be opposed to for example git-mailinfo learning to 
understand the --pretty argument, if the implementation doesn't turn out 
to be completely out of proportion.

regards
