Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E4AC433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 18:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiDHSOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 14:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiDHSOt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 14:14:49 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70C013E0D
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 11:12:43 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E253318C572;
        Fri,  8 Apr 2022 14:12:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q1hRteX8oYFsIZBP9tYtW+uw3ht7JNP9ojFsBR
        bIfHs=; b=CIW51g6SPuAEQgAQj9RKOJWWREH7xE6ZgvKmgFVcNu2LH5M9b7t8Nu
        8AmRXw/nkCNumdG1iGVqkOcfhnddBxF+AB1/xZlgbb/6nmKOtHnIdsjMmRc21/MB
        eXFNBEmtb5XVRkkh9xvwG4lZQ0ZtMObvNYFmvxSsDWtPrCHaY8DhI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB19D18C571;
        Fri,  8 Apr 2022 14:12:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 253BB18C56F;
        Fri,  8 Apr 2022 14:12:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <ttaylorr@github.com>, git <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] git-scm.com Heroku credits update
References: <YkcmtqcFaO7v1jW5@nand.local>
        <nycvar.QRO.7.76.6.2204072346410.347@tvgsbejvaqbjf.bet>
        <CAP8UFD2fN=c2JvvzH94Nu8yqt2MOOtXrn29eFxuie9aZ5YVjQw@mail.gmail.com>
Date:   Fri, 08 Apr 2022 11:12:37 -0700
In-Reply-To: <CAP8UFD2fN=c2JvvzH94Nu8yqt2MOOtXrn29eFxuie9aZ5YVjQw@mail.gmail.com>
        (Christian Couder's message of "Fri, 8 Apr 2022 10:10:08 +0200")
Message-ID: <xmqq35ino356.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 799FF692-B767-11EC-8939-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Apr 8, 2022 at 12:39 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>
>> On Fri, 1 Apr 2022, Taylor Blau wrote:
>
>> > To that end, we have a few options about what to do with the website in
>> > the future:
>> >
>> >   - Convert the Rails application into a static site that could be
>> >     hosted elsewhere for free. The non-static portions of the site would
>> >     have to become static in one way or another, and we'd have to come
>> >     up with an alternative search mechanism to replace the existing one.
>>
>> This is my preference (and I would love to contribute the time, but am
>> quite short on that resource to help much).
>
> I wonder if this could be an Outreachy (maybe next Winter) or a GSoC
> (2023) project.

Good suggestion.

It would take talent quite different from what our past GSoC
programs saw, from both mentors and "contributors" (we used to call
them "students").  If we have mentors who can give good experience
to mentees, I would welcome to see such a task for a change.

Thanks.


