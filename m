Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E28FC04A6A
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 07:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjHLHTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Aug 2023 03:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLHTg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2023 03:19:36 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B42810C
        for <git@vger.kernel.org>; Sat, 12 Aug 2023 00:19:35 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id E4E6224207;
        Sat, 12 Aug 2023 03:19:33 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qUiuL-q16-00; Sat, 12 Aug 2023 09:19:33 +0200
Date:   Sat, 12 Aug 2023 09:19:33 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Linus Arver <linusa@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] doc: revert: add discussion
Message-ID: <ZNcyhUL89WVXOv3F@ugly>
References: <ZNYuUh27ByphTH04@ugly>
 <owly350pfal6.fsf@fine.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <owly350pfal6.fsf@fine.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2023 at 04:00:53PM -0700, Linus Arver wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> On Thu, Aug 10, 2023 at 02:50:59PM -0700, Linus Arver wrote:
>>>Nit: the "doc: revert: add discussion" subject line should probably be more
>>>like "revert doc: suggest adding the 'why' behind reverts".
>>>
>> this is counter to the prevalent "big endian" prefix style, and is in 
>> this case really easy to misread.
>
>I also learned recently that there should just be one colon ":" in the
>subject, which is why I suggested "revert doc" as the prefix instead of
>"doc: revert: ...".
>
in what context was this preference expressed?
because here, it's rather counter-productive: most commands are verbs 
for obvious reasons, so using that style sets the reader up for 
misparsing the subject on first try. this could be avoided by quoting 
the command, but that looks noisy in the subject.
so rather, i'd follow another precedent, 'git-revert.txt: ', which is 
unambiguous.

>> i also intentionally kept the subject generic, because the content 
>> covers two matters (the reasoning and the subjects, which is also the 
>> reason why this is a separate patch to start with).
>
>I think the phrase "add discussion" in "doc: revert: add discussion"
>doesn't add much value, because your patch's diff is very easy to read
>(in that it adds a new DISCUSSION section). I just wanted to replace it
>with something more useful that gives more information than

>just repeat
>(somewhat redundantly) what is obvious by looking at the patch.
>
but ... that's exactly what a subject is supposed to do!

>>>Please consider rewording such
>>>    subject lines to reflect the reason why the original commit is being
>>>    reapplied again.
>>>
>> the reasoning most likely wouldn't fit into the subject.
>
>Hence the language "to _reflect_ the reason", because the "reason"
>should belong in the commit message body text.
>
i don't think that's how most people would actually read this.
and i still don't see how that instruction could be meaningfully 
followed.

>> also, the original request to explain the reasoning applies 
>> transitively, so i don't think it's really necessary to point it out 
>> explicitly.
>
>It may be that a user will think only giving the revert reason in the
>body text is enough, while leaving the subject line as is. I wanted to
>break this line of thinking by providing additional instructions.
>
yes, that's the whole intention of this patch. but i don't see how 
making it more convoluted than my proposal helps in any way.

>This is definitely better. But others in this thread have already
>commented that my version looks good (after seeing your version also,
>presumably).
>
well, i'm also an "others" when it comes to your proposal, and i find it 
confusing.

regards
