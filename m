Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D657C77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 19:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjEATKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 15:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEATKd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 15:10:33 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96671708
        for <git@vger.kernel.org>; Mon,  1 May 2023 12:10:31 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 2BD5623FF1;
        Mon,  1 May 2023 15:10:30 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1ptYur-OTI-00; Mon, 01 May 2023 21:10:29 +0200
Date:   Mon, 1 May 2023 21:10:29 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
Message-ID: <ZFAOpRpoPWjn8s1B@ugly>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <xmqqcz3netxr.fsf@gitster.g>
 <ZEwafQmat347la3/@ugly>
 <xmqq4jow6lyh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq4jow6lyh.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 01, 2023 at 09:44:06AM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> but i don't get the argument anyway. i think the docu is pretty
>> pointless except to emphasize that the generated subject is a default
>> that should be edited when circumstances recommend it. in fact, i
>> wouldn't mind writing just that, with a notice that the default
>> attempts to be somewhat natural for repeated reverts.
>
>I think it is very well known that the user gets the default message
>to be edited in the editor.  I would understand if the instruction
>is "do not edit this line, because ...", but otherwise it is pretty
>up to the user to do whatever they like to the log message, no?
>
well, yeah. but not everybody seems to get that editing the title 
specifically is actually an acceptable thing to do - see my earlier 
messages in the other sub-thread. so i'd go with something like:

   Git attempts to make the subject of reverts of reverts somewhat 
   natural, but will inevitably fail at greater depths. Editing these 
   subjects is recommended.

also, this should be probably a note near the bottom, rather than being 
so close to the top. in fact, it's probably a good idea to add a 
DISCUSSION section with some basic guidelines, like git-commit has.

-- ossi

