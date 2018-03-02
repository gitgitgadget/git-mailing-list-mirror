Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 695001F404
	for <e@80x24.org>; Fri,  2 Mar 2018 05:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935893AbeCBFk4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 00:40:56 -0500
Received: from mail.javad.com ([54.86.164.124]:49795 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935890AbeCBFkz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 00:40:55 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id D4F283E966;
        Fri,  2 Mar 2018 05:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519969254;
        bh=Bp0zBdEyDk4swziqINz3dxrKpn0i5Ehc61lP/hfLLLQ=; l=3284;
        h=Received:From:To:Subject;
        b=j4dz6VvFrMggshjNnDwiyk9NHykJUAi4uQMrjD3+Q9FRD3XygAX0XDPTu48mIC648
         DXt59uIal8Fv2HfpR3R33iY7J+TvYTC3DwiI/ywMbrvdNA6yscfImkEpmK6f2qQywg
         MLMf1875gWuUis5q3Ql1MSVAlQmAb/Fjj9UfXt/s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519969254;
        bh=Bp0zBdEyDk4swziqINz3dxrKpn0i5Ehc61lP/hfLLLQ=; l=3284;
        h=Received:From:To:Subject;
        b=j4dz6VvFrMggshjNnDwiyk9NHykJUAi4uQMrjD3+Q9FRD3XygAX0XDPTu48mIC648
         DXt59uIal8Fv2HfpR3R33iY7J+TvYTC3DwiI/ywMbrvdNA6yscfImkEpmK6f2qQywg
         MLMf1875gWuUis5q3Ql1MSVAlQmAb/Fjj9UfXt/s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519969254;
        bh=Bp0zBdEyDk4swziqINz3dxrKpn0i5Ehc61lP/hfLLLQ=; l=3284;
        h=Received:From:To:Subject;
        b=j4dz6VvFrMggshjNnDwiyk9NHykJUAi4uQMrjD3+Q9FRD3XygAX0XDPTu48mIC648
         DXt59uIal8Fv2HfpR3R33iY7J+TvYTC3DwiI/ywMbrvdNA6yscfImkEpmK6f2qQywg
         MLMf1875gWuUis5q3Ql1MSVAlQmAb/Fjj9UfXt/s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519969254;
        bh=Bp0zBdEyDk4swziqINz3dxrKpn0i5Ehc61lP/hfLLLQ=; l=3284;
        h=Received:From:To:Subject;
        b=j4dz6VvFrMggshjNnDwiyk9NHykJUAi4uQMrjD3+Q9FRD3XygAX0XDPTu48mIC648
         DXt59uIal8Fv2HfpR3R33iY7J+TvYTC3DwiI/ywMbrvdNA6yscfImkEpmK6f2qQywg
         MLMf1875gWuUis5q3Ql1MSVAlQmAb/Fjj9UfXt/s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519969254;
        bh=Bp0zBdEyDk4swziqINz3dxrKpn0i5Ehc61lP/hfLLLQ=; l=3284;
        h=Received:From:To:Subject;
        b=j4dz6VvFrMggshjNnDwiyk9NHykJUAi4uQMrjD3+Q9FRD3XygAX0XDPTu48mIC648
         DXt59uIal8Fv2HfpR3R33iY7J+TvYTC3DwiI/ywMbrvdNA6yscfImkEpmK6f2qQywg
         MLMf1875gWuUis5q3Ql1MSVAlQmAb/Fjj9UfXt/s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519969254;
        bh=Bp0zBdEyDk4swziqINz3dxrKpn0i5Ehc61lP/hfLLLQ=; l=3284;
        h=Received:From:To:Subject;
        b=j4dz6VvFrMggshjNnDwiyk9NHykJUAi4uQMrjD3+Q9FRD3XygAX0XDPTu48mIC648
         DXt59uIal8Fv2HfpR3R33iY7J+TvYTC3DwiI/ywMbrvdNA6yscfImkEpmK6f2qQywg
         MLMf1875gWuUis5q3Ql1MSVAlQmAb/Fjj9UfXt/s=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1erdR6-00018y-7J; Fri, 02 Mar 2018 08:40:52 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
Date:   Fri, 02 Mar 2018 08:40:52 +0300
In-Reply-To: <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com> (Igor
        Djordjevic's message of "Fri, 2 Mar 2018 02:16:05 +0100")
Message-ID: <87606fox0b.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Igor,

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> Hi Sergey,
>
> On 01/03/2018 06:39, Sergey Organov wrote:

[...]

>> 
>> Yeah, I now see it myself. I'm sorry for being lazy and not inspecting
>> this more carefully in the first place.
>
> No problem, that`s why we`re discussing it, and I`m glad we`re 
> aligned now, so we can move forward :)
>
>> > So while your original proposal currently seems like it could be 
>> > working nicely for non-interactive rebase (and might be some simpler 
>> > interactive ones), now hitting/acknowledging its first real use 
>> > limit, my additional quick attempt[1] just tries to aid pretty 
>> > interesting case of complicated interactive rebase, too, where we 
>> > might be able to do better as well, still using you original proposal 
>> > as a base idea :)
>> 
>> Yes, thank you for pushing me back to reality! :-) The work and thoughts
>> you are putting into solving the puzzle are greatly appreciated!
>
> You`re welcome, and I am enjoying it :)
>
>> Thinking about it overnight, I now suspect that original proposal had a
>> mistake in the final merge step. I think that what you did is a way to
>> fix it, and I want to try to figure what exactly was wrong in the
>> original proposal and to find simpler way of doing it right.
>> 
>> The likely solution is to use original UM as a merge-base for final
>> 3-way merge of U1' and U2', but I'm not sure yet. Sounds pretty natural
>> though, as that's exactly UM from which both U1' and U2' have diverged
>> due to rebasing and other history editing.
>
> Yes, this might be it...! ;)
>
> To prove myself it works, I`ve assembled a pretty crazy `-s ours`  
> merge interactive rebase scenario, and it seems this passes the test, 
> ticking all the check boxes (I could think of) :P

I must admit it's quite a relief to hear this. What we now have is so
simple and obvious that it'd be a huge disappointment if didn't work!

> Here, merge commit M is done with `-s ours` (obsoleting branch "B"), 
> plus amended to make it an "evil merge", where a commit B2 from 
> obsoleted branch "B" is cherry picked to "master".

[...]

> There, I hope I didn`t miss any expectation. And, it _seems_ to work 
> exactly as expected :D

That's very nice, to the level of being even suspect! :-)

To avoid falling into euphoria though, we need to keep in mind that
"expectations" is rather vague concept, and we likely still need to stop
for user amendment unless we absolutely sure nothing surprising happens.
I.e., we better require U1'==U2' test to succeed to proceed non-stop
automatically. Besides, it will be somewhat inline with what 'rerere'
does.

> In real life, except for usual possibility for conflicts during 
> commit rebasing, we might experience _three_ possible conflict 
> situations once "rebased" merge itself is to be created - two when 
> rebasing each of temporary merge helper commits, and one on the 
> "rebased" merge itself. This is something where we might think about 
> user experience, not introducing (too much) confusion...

Yeah, this is terribly important issue to take care of! Relative
simplicity of the concept itself raises the chances of finding a
suitable solution, I hope.

-- Sergey
