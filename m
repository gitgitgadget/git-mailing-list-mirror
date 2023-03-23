Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54A0C6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 21:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCWVxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 17:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCWVxu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 17:53:50 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E16F773
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 14:53:48 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 44BAB20386
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:53:47 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfSsU-grA-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 22:53:46 +0100
Date:   Thu, 23 Mar 2023 22:53:46 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] sequencer: actually translate report in do_exec()
Message-ID: <ZBzKauthEiqNS0nc@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
 <20230323162234.995485-2-oswald.buddenhagen@gmx.de>
 <xmqqpm8z6vxk.fsf@gitster.g>
 <ZBzCoZ0MuysnVj9t@ugly>
 <xmqqcz4z6tzj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqcz4z6tzj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 02:25:04PM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> yeah, but unless this is on someone's shortlist, i don't think it
>> makes sense to hold up my fix.
>
>My point was that your "fix" is not really a "fix" that is worth the
>code churn.  Or did I mis-read your patches?
>
they all fix actual (minor) bugs: missing i18n, bad grammar (the missing 
periods between sentences actaully threw me off, which is how i got 
started on the series at all), and arguably bad capitalization (though 
obviously, for my own sake i couldn't care less about *that*).
