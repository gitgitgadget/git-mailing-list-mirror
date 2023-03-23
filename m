Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A691C6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 21:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjCWVLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 17:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjCWVLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 17:11:16 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B340C2822D
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 14:10:48 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 908C420300
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:10:44 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfSCq-fpi-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 22:10:44 +0100
Date:   Thu, 23 Mar 2023 22:10:44 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] Capitalization and punctuation fixes to some user
 visible messages
Message-ID: <ZBzAVMCOadgE1sa8@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
 <xmqqttyb6w3j.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqttyb6w3j.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 01:39:28PM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>>  			require_clean_work_tree(the_repository,
>>  				N_("pull with rebase"),
>> -				_("please commit or stash them."), 1, 0);
>> +				_("Please commit or stash them."), 1, 0);
>
>Our friendly CodingGuidelines is fairly clear on what to do to a
>single sentence error message like this one: [...]
>
i know. that's why the commit message makes a point of stating that it's 
making an exception.

the reasoning is basically that it's not *really* an error message, it's 
just abusing the machinery. you obviously noticed that yourself, 
suggesting to turn these strings into advice messages. but that kinda 
feels like overkill to me.

