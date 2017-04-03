Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 263061FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 14:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbdDCOqK (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 10:46:10 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:59854 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751431AbdDCOqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 10:46:09 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MWONS-1cacyG3B5m-00XeLi; Mon, 03 Apr 2017 16:46:02 +0200
Subject: Re: [PATCH v3 3/4] name-rev: provide debug output
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
 <cover.1490967948.git.git@grubix.eu>
 <21cf9d6f55d17463ab6eccdd78d57cf4a1b8e9e1.1490967948.git.git@grubix.eu>
 <xmqqtw69z8vz.fsf@gitster.mtv.corp.google.com>
 <14D0E7F4-0DC7-42ED-8DEE-B0338ECBA80D@grubix.eu>
 <xmqqd1cxz5gb.fsf@gitster.mtv.corp.google.com>
 <xmqqzig1xpm6.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <c85bc2a1-56d8-8a02-6089-2b8cb3d39e99@grubix.eu>
Date:   Mon, 3 Apr 2017 16:46:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqzig1xpm6.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:WKRXP4lBNhNVhPKu5bAHCk1LdnGNtcsdV5SGVyyeink7H58pDt/
 9ho/Lg5k+VT44uBFT+7T1yQxhiPGnm3je5re6F5shlpClyH7BvLfVe0jsCdtFGtDYerR2kI
 5TrkkeYmdawkmzAB0ArX1pX9qkf+1DVz+bo+llKW/9WPSiG4Td+Cene5JhTDJ3bBpvitkC6
 oJ6I9BDg7f8IUO4Xsm7/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7xW5tfTzL/c=:hbZMM79twFEH+DYXFzGitO
 3utJxKIxAFtdZLXUy+ofHdNpzJ/fT+CLSs8nzOGR5TnuRtwuKoLDDrwcbOuonazMP39Aby+Rg
 ZEa1RugEtpmGMFgnBCiupXs/zDRMa25hkh6TfvJPLF1VbBgo25KJFxYN3YSOM1TG14NcIkneN
 a/D3SpkUmAqi+FeduxZKDN/h4D4PxhlJ5ixBTfWs4GmvZaRe0xy4ccwIybf/vc1feBhY5F5kM
 SlhpSCrffV5FottQ62TC6YiftQAtXd+N//nEDGAleSKc7nqmWlrndHAG/Zpk97aTF7FEb7+A2
 fgl41qujwIT521fkYciNPVeUfxwmF+m0pj/0kjJ2cxtkZfhqR41XgMwuQtoN58WTCemEv2QTe
 ukGI3R51SRi2ruQKVL+mFmGrqmfkyy+Rtq7Z4aaT22GgFWSn1qCqsT/V9Vfq5E43ZV4hxbSz6
 ZnRi+BtAI47rrMrzx3zEZBnpFDudR2AmJJ4P6uHc4ySPaBr1ZyNdzcCkKwbvBnSwFXuS8/fXl
 zQy9yWOvL+efdSDUOKplJmgoPCDmlMkL9G0sApWGc/lOTsF35IoLMCiiPywFAIS9JCM4zYFPd
 c1IgddbVYwBLjNd0Hg6zEwXJSrz4oTVnOktFaFnxW5/Q0pPbjV2+Ydufq5yDNhZrlXIpqL8C/
 LmQAlONmobKl612a6ODm0DpyalYFbxELClh2LZm6zKSEB1/TAPrlLxeStHu5qjiGJ59VVsjMw
 vz+yMjVH0ukZmivz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 31.03.2017 20:33:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Michael J Gruber <git@grubix.eu> writes:
>>
>>>> The only case that this change may make a difference I can think of
>>>> is when you have a tag object pointed at from outside refs/tags
>>>> (e.g. refs/heads/foo is a tag object); if you are trying to change
>>>> the definition of "from_tag" from the current "Is the tip inside
>>>> refs/tags/?" to "Is the tip either inside refs/tags/ or is it a tag
>>>> object anywhere?", that may be a good change (I didn't think things
>>>> through, though), but that shouldn't be hidden inside a commit that
>>>> claims to only add support for debugging.
>>>>
>>>> What problem are you solving?  
>>>
>>> Sorry, I forgot about that change and failed to mention it.
>>>
>>> It makes no difference in the non-debug case which cares about the
>>> Boolean only. In the debug case, I want to distinguish between
>>> annotated and lightweight tags, just like describe --debug does. By
>>> adding 1 via deref and passing this down, I know that an annotated tag
>>> gets the value 2, a lightweight tag 1 and everything else 0, just like
>>> describe --tags.
>>
>> So it sounds like you meant to do something else, and the
>> implementation is wrong for that something else (i.e. it wouldn't do
>> the right thing for a tag object outside refs/tags/, with or without
>> the "--debug" option passed).
> 
> The damage seems worse, but I may be misreading the code.
> 
> is_better_name() compares name->from_tag and from_tag numerically,
> because it was designed to take a boolean view of that variable.
> Now, an artificially bumped 2 gets compared with name->from_tag that
> may be 1 and gets different priority.  That artificially inflated
> value may be propagated to name->from_tag when the current tip is
> judged as a better basis for naming the object.

No, I checked not to change the existing behaviour.

If you look at the comment above that then you see that one of the sides
of the comparison is a non-tag, so we compare 0 to 1 or 2, the boolean
outcome being the same.

> If this change is only for debugging, perhaps inside if(data->debug)
> you added, instead of looking at from_tag, you can look at both
> from_tag and deref to choose which prio-nmes to show, without
> butchering the value in from_tag variable to affect the existing
> code that is exercised with or without --debug?

What I did overlook, though, was that name-rev uses the notion "under
refs/tags" for "being a tag".

In fact, it's puzzling how different describe and name-rev proceed and
weigh the alternatives. I didn't mean to change that.

In retrospect, displaying the "same" debug information for the two
commands doesn't make too much sense as long as they use different
information. name-rev does-not distinguish between tag types, so why
even display it?

I think I should change 3/4 to display exactly those bits that name-rev
actually uses for weighing different possible descriptions; they are
differents from the "describe-bits". So please withhold 3/4 and 4/4.

Michael
