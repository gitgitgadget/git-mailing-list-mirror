Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF85C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 10:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjHJK0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 06:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjHJK0H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 06:26:07 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3FC83
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 03:26:06 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 3DF5E202E9;
        Thu, 10 Aug 2023 06:26:05 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qU2rk-1JD-00; Thu, 10 Aug 2023 12:26:04 +0200
Date:   Thu, 10 Aug 2023 12:26:04 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t9001: fix/unify indentation regarding pipes somewhat
Message-ID: <ZNS7PJ0oyOQLeaZ7@ugly>
References: <20230809171531.2564769-1-oswald.buddenhagen@gmx.de>
 <xmqq350sm21v.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq350sm21v.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2023 at 12:46:36PM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>> -	grep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
>> +		grep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
>
>... I do not think we want this.  A long pipeline should be written
>without extra indentation like
>
>	A |
>		B |
>			C
>
... which is not how i would do it.

>but more like
>
>	A |
>	B |
>	C
>
i'd argue that this should be written as

	A |
		B |
		C

like other continued lines (no trailing backslashes are needed here, but 
it would be ok to add them, and there is in fact a commit that does just 
that in other places, and one might do the same here in a followup).

regards
