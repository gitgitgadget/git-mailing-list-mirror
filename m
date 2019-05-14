Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB5771F461
	for <e@80x24.org>; Tue, 14 May 2019 07:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfENHdK (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 03:33:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55704 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfENHdK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 03:33:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 177E713AC74;
        Tue, 14 May 2019 03:33:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PpwhBxVx/A6oWf/QeBCHYAd4JAw=; b=YxrbY6
        NvSKDityA4exxmjZbtG3Cg5hagcjtvgNhuU1V7lYBHhOEv8M/U5eDylkZieurcNl
        tCSuHSqXqvMvdcyx7BX+YQxKnVqJu2qpoGSydbvWHlop4gxF1pm+e1QcWZOALi4X
        gjhETj5Th0I/fSTvTu55KBMXZb79DUwrfEjPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yjrdE9m1OXB0xK22zaZwVKY7hl/dQRbP
        yvN2ZITxx5I5Yap9LiPnOI9/1p4LX2IPMIxHKKPke8vfzHZi7REp53Jb93cQ5hEG
        2pBbu8YRua43wrVMmNhOgaXdGQh9MujgeZEGFXePTxJje2j9L0KezE036wdLgQVH
        R2R2AKG/xYY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EEB713AC73;
        Tue, 14 May 2019 03:33:06 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 794ED13AC72;
        Tue, 14 May 2019 03:33:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>,
        Git <git@vger.kernel.org>, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] status: add an empty line when there is no hint
References: <20190430060210.79610-1-johnlinp@gmail.com>
        <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>
        <20190501234512.GD202237@genre.crustytoothpaste.net>
        <CAKO26MvXmOMHgqWSoVrmdwyDFyqDrChkMOHq6iuJAX8pvHzZoA@mail.gmail.com>
        <20190502231537.GE202237@genre.crustytoothpaste.net>
        <CAKO26MuisScMPp0SxRo896y7waEgR3HjU3A8+VM73eS0xgU8RQ@mail.gmail.com>
        <CAKO26Mtn+KDnkHWsKf8mAyTmeaCYK0gjdNad5bxJe-qxjKs=xw@mail.gmail.com>
        <xmqqh89ydhqu.fsf@gitster-ct.c.googlers.com>
        <20190514020416.GH7458@genre.crustytoothpaste.net>
Date:   Tue, 14 May 2019 16:33:04 +0900
In-Reply-To: <20190514020416.GH7458@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 14 May 2019 02:04:16 +0000")
Message-ID: <xmqqftpha3tb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 834557FA-761A-11E9-9C08-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Mon, May 13, 2019 at 02:51:37PM +0900, Junio C Hamano wrote:
>> If the difference between "status" and "commit" bothers you so much,
>> i.e.
>> 
>>     When typing "git status", there is an empty line between the
>>     "Changes not staged for commit:" block and the list of changed
>>     files. However, when typing "git commit" with no files added,
>>     there are no empty lines between them.
>> 
>> it may not be a bad idea to try making them consistent by removing
>> the blank line that is given after the advice messages, perhaps?
>
> I personally think the extra blank line aids readability, especially on
> screens with small text, but I'll defer to your decision on this.

Heh, now we established that this is primarily of personal tastes,
if you leave it up to me, my preference would be different from what
was said in the thread so far.

 - I do not mind having an extra blank line in the log message
   editor session "git commit" gives me, primarily because at that
   point I am in a full-screen editor that I can scroll up and down
   at ease.

 - "git status" output, on the other hand, is shown in the context
   where vertical screen real estate is more precious (I do not say
   "git -p status"); I'd probably be happier without these empty
   lines.

But following the above two would mean that the result will still
leave difference between the commands; the original justificaiton
will not apply to such a change.

At the same time, I think I've been happy enough with the current
output from both commands, so if you let me bikeshed freely, I'd
probably pick "let's not change anything then" ;-)
