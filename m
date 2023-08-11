Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8C0EB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 18:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbjHKSRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 14:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbjHKSRB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 14:17:01 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A5E30DC
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 11:16:59 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id D9AB02420E;
        Fri, 11 Aug 2023 14:16:58 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qUWh0-gLw-00; Fri, 11 Aug 2023 20:16:58 +0200
Date:   Fri, 11 Aug 2023 20:16:58 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Arver <linusa@google.com>, git@vger.kernel.org
Subject: Re: Re* [PATCH v3 2/2] doc: revert: add discussion
Message-ID: <ZNZ7GhVkLuwYOPij@ugly>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
 <20230809171531.2564807-2-oswald.buddenhagen@gmx.de>
 <owly8raih8ho.fsf@fine.c.googlers.com>
 <xmqqsf8ptsqf.fsf@gitster.g>
 <xmqq5y5ltqwd.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq5y5ltqwd.fsf_-_@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2023 at 10:44:50AM -0700, Junio C Hamano wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>
>> Linus Arver <linusa@google.com> writes:
>>
>>> Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>>>
>>>> while thinking about what to write, i came up with an idea for another
>>>> improvement: with (implicit) --edit, the template message would end up
>>>> being:
>>>>
>>>>  This reverts commit <sha1>,
>>>>  because <PUT REASON HERE>.
>>>
>>> This sounds great to me.
>>
>> Oh, absolutely.  I rarely do a revert myself (other than reverting a
>> premature merge out of 'next'), but giving a better instruction in
>> the commit log editor buffer as template is a very good idea.
>
>It might be just the matter of doing something like the attached
>patch on top of Oswald's, reusing the existing code to instruct the
>user to describe the reversion.
>
hmm, this seems to be going down a too narrow road - my idea was to make 
this fully orthogonal to reverting reverts in particular (note that i 
attached it to the generic "discussion" patch rather than the "reverts 
of reverts" one).
i didn't think about the integration with existing options yet.

regards
