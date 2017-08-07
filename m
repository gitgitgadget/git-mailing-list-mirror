Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8396F2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 22:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbdHGWUd (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 18:20:33 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36030 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbdHGWUc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 18:20:32 -0400
Received: by mail-wr0-f195.google.com with SMTP id y67so1199122wrb.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 15:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7DlBxaOHoSurOW5JR4K26qu8u+SdltXq7LO0xMO3/Cc=;
        b=M1CHsjuAb6glS+2zZZI3VILPxWh4QHERyeVNNjFR/of4Q5nn9xcJRv4pmDCYhJlWpR
         w4b6p1TetLmN17aR05awRxgVyS4yIlU0T8HWGYOKI1reQiozvudALgYf937tKmDTlIRV
         4gMy8P7nSh/Tbi3x1G5Jp13+gens7LjzMneIzR7P13l6FIZZCQXOT1SH6Z/F/WNoIwoE
         aeQirXgmbfMXrRuQRLC7F+NABq+0/F5kIa/J7r3UV2JesQ5tOFG43JTi9QWxUbRGMf8b
         SuGpQGlC5AO5RMamhYfIxXpTABE+4K+H68mliGmPPAfZ695jUAv6rFSx1GzWqfjG9as9
         VFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7DlBxaOHoSurOW5JR4K26qu8u+SdltXq7LO0xMO3/Cc=;
        b=a1TQwWmXes1F6HaVlAYdVkzPV/203hjNDK7XM8l2tfUyHNNlfv3B5RGpkQ72UtrD6I
         YRBjzWrIywsSqv/w57rWupC01BNsuCdJL+uxzJ3nGbSATq/Vs+QpZP/LvuUcZ6ciO/Aj
         WbUyP4AqvKbpEVLn3wTRsEgaFrijfOvl80V4VyOAsVxmM2R9Y6hZQsJ8FgeGaokkc0Kt
         8hJUz+FZNYTozQ3oB4X2TCBK/OPCe7kbTFVNMUgKm612CHtzflV/d2qqmokYb45bUxk3
         QZ+K6LCOP0HfN50c9Wq/WzEEl5ocrPGU9xmvdOd32b1R+1mNW8gDrgrOiMFUIBbZIWa6
         m2lQ==
X-Gm-Message-State: AHYfb5j6um3cUTNyNhqmS46ZxKTnwELmvBy0+yMCScBmQkDIRY3qrn6x
        vxzl/7M8BG+GPPRTCc/p3A==
X-Received: by 10.223.172.232 with SMTP id o95mr1319475wrc.276.1502144430341;
        Mon, 07 Aug 2017 15:20:30 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-63-71.dynamic.sbb.rs. [24.135.63.71])
        by smtp.gmail.com with ESMTPSA id h16sm9529892wrc.89.2017.08.07.15.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Aug 2017 15:20:29 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jul 2017, #09; Mon, 31)
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Sahil Dua <sahildua2305@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git Mailing List <git@vger.kernel.org>
References: <xmqqfudcgryb.fsf@gitster.mtv.corp.google.com>
 <232547ab-3b87-debc-36a4-d2285ec10a06@ramsayjones.plus.com>
 <CALiud+nm9wu4rBY6zBXmenJj_0Mn7xeU_FAvSdn4fdH+q--Jag@mail.gmail.com>
 <xmqqd18cweak.fsf@gitster.mtv.corp.google.com> <87shh57nzs.fsf@gmail.com>
 <xmqqpoc9sksg.fsf@gitster.mtv.corp.google.com> <873794zbls.fsf@gmail.com>
 <e5564e40-702f-390b-69e2-2ed6e45610c8@gmail.com>
Message-ID: <db848b3e-e4cc-ddf4-9e4c-7b47b2f5d7a7@gmail.com>
Date:   Tue, 8 Aug 2017 00:20:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <e5564e40-702f-390b-69e2-2ed6e45610c8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/08/2017 23:25, Igor Djordjevic wrote:
> On 06/08/2017 22:26, Ævar Arnfjörð Bjarmason wrote:
>> On Sat, Aug 05 2017, Junio C. Hamano jotted:
>>> I actually consider "branch" to *never* invoking a checkout.  Even
>>> when "git branch -m A B" happens to be done when your checked out
>>> branch is A and you end up being on B.  That is not a "checkout".
>>
>> I think we just have a different mental model of what "checkout"
>> means. In my mind any operation that updates the HEAD to point to a new
>> branch is a checkout of that branch.
> 
> If I may, from a side-viewer`s point of view, it seems you`re 
> thinking in low-level implementation details, where what Junio 
> describes seems more as a high-level, conceptual/end-user`s point of 
> view.
> 
> Needing to update HEAD reference once we "rename" a branch, too, what 
> you consider a "checkout", seems to be required only because branch 
> name _is_ the branch reference in Git, so we need to update HEAD to 
> point to a new/renamed branch reference -- but it`s still the same 
> branch, conceptually.
> 
> Documentation for "git-checkout" states that it is used to "*Switch 
> branches*...[snip]", and that is not what happens here. 
> Implementation-wise it does because we can`t do it differently at the 
> moment, but in user`s eyes it`s still the same branch, so no switch 
> is made as far as the user is concerned.
> 
> In a different implementation, where branches would have permanent 
> references other than their names, no HEAD update would be needed as 
> the reference would still be the same, no matter the name change, 
> making the `git branch -m` situation clear even from your standpoint, 
> I`d say.
> 
>>> Really from the end-user's point of view that is not a checkout.
>>> The user renamed the branch A and the same conceptual entity, which
>>> is a branch, is now called B.  If that branch was what was checked
>>> out (IOW, if that branch was what would be grown by one commit if
>>> the user did "git commit"), then now that branch's name is B.  It is
>>> natural if you ask "symbolic-ref HEAD" what branch is checked out
>>> after renaming A to B (and A happened to be what was checked out),
>>> the answer chould be B.
>>>
>>> It's like the city you live in changed the name of the street your
>>> house is on.  You do not call movers, you do not do anything, but
>>> your address changes.
>>
>> Yeah I see what you mean, although this analogy rapidly breaks down when
>> you poke at it as shown above. My house (a sha1) can be on any number of
>> streets and new ones can be added/removed all the time without changing
>> where my house is at.
> 
> I may be missing something, but I find the house/address analogy a 
> good one, actually, as I understood that "house" resembles a branch 
> reference HEAD is pointing to, not a sha1.
> 
> Even further, and that might be the point of confusion, "house" seems 
> to be more like a "permanent branch reference" I mentioned above, 
> where your address can change (branch being renamed), but you would 
> still be in the same house (HEAD would still point to the same 
> permanent branch reference).
> 
> If you move to another house, only then would HEAD change to point to 
> another (permanent) branch reference (a different house), and that 
> would be a checkout.
> 
> Yes, it`s not really how it works from the inside, but I think that`s 
> irrelevant for the end-user experience :)
> 
>> So it's just a way to get something exactly like -m except the "move &&
>> checkout" logic is changed to "copy && checkout".
>
> Again, it seems the "checkout" part of "move && checkout" you`re 
> talking about is a user-wise unnecessary implementation detail. For 
> the user, it`s just a simple "move", staying on the same, but renamed 
> branch, thus no branch switching occurred (no "checkout", as per 
> documentation).

All this said, having you mentioning the two argument version:

>     $ git checkout master
>     $ git branch -m topic avar/topic

... exactly proves the point that "git branch -m" is not expected to 
involve a checkout, even from implementation perspective. It`s just a 
consequence of needing to update the (now obsolete) reference HEAD 
points to (only) when the branch we`re renaming (moving) is the one 
that is currently checked-out.

> Yeah it's not something I'm interested in or have a use-case for,
> although I think in the same way we have -t for checkout it might be
> sensible to have e.g.:
> 
>     $ git checkout -b topic-2 -c topic -t origin/master
> 
> Where the new -c or --config-from would mean "...and get the config from
> 'topic'". Such a name would probably be less confusing than
> --super-b[branch?] which to be implies some ongoing hierarchical
> relationship.

This, on the other hand, sounds sensible, staying true to the 
existing logic. In the same manner you can do either:

    $ git branch topic -t origin/master
    $ git checkout topic

... or shorter equivalent:

    $ git checkout -b topic -t origin/master

..., you should be able to do:

    $ git branch -c topic topic-2
    $ git checkout topic-2

..., or equivalent:

    $ git checkout -b topic-2 -c topic

..., where "-c" would follow the same (or similar) logic as "-t" does 
now, as you already pointed out :)

p.s. That said, is `git checkout -b topic-2 --move topic` being 
missed now...? :P That one would/could/should actually be expected to 
move (rename) the branch *and* check it out, no matter if HEAD 
currently points to it or not.

Regards,
Buga
