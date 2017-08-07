Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7BD22047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbdHGV0E (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:26:04 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36312 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbdHGV0D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:26:03 -0400
Received: by mail-wr0-f195.google.com with SMTP id y67so1127094wrb.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qewlG95D96lhPQLzvWYWPxJ/3jhLgOVQXAPGbUDxXTA=;
        b=Ds8GnAhdg3GMthuDRNLtkJ9E2wLdzLYcqK/fcoEsYWxrq96oUMBrLsCaX0F4Chw4D7
         Q+SDOhzkSC7JUX63uIKTfDxJUqgeEO1nWWyNmybp4O+E5xkJ3bXCrPBdYtKNzbmLc3bs
         xR4PyqOXcjUA3F+b9QJWCaKTDgYVWGhzgHw+oCNzS9F7r7uFszO6vvswR8g1nR9QE8jR
         0DuNzG4zIdop1w+Bn0HqFC4dz1GbZG3rTgHXVq+BYMFqWtmKTFGp7yUcCnSQieFx3G/x
         Pbz26llC7XMFUhUfCKJiOiWNeNu3mJDXT72IPokEd/oPDu5QpdRxtGtGNn4+30OHK/px
         Zw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qewlG95D96lhPQLzvWYWPxJ/3jhLgOVQXAPGbUDxXTA=;
        b=pAcbq+necAjl9Od33Z972DSfNyQ8STyVhwDXBi5/8h0ardPKnDP1F3NpKJYto9fc/N
         a2ktaWXxDDhkSk4LS3Ur8Ntkxb0sQsEnOhMI4S25wuwpJAhCHP/sTrA4S7QgJzN5Y6Cz
         xXv+Wo/kcK33/c/wE/yHGZ8NgahKCqI3oG2NQpbCzIeY9ME0dxPma+xMIrwbwtd8qx5i
         201fADPVcdSLFJoOqLreln++Soyn6A/jlAJJQrbp0A+0Nd+SE09/LZpeh7B5Ma7Dhy5Y
         jbxNaJ/NdkL67LQONhLBmw4PixcfdCh5OA2YN/r2K1HW/LjGoyEjARelUQ8n7n6SWBzE
         swDg==
X-Gm-Message-State: AHYfb5iZx/knYPVih8b9scsiw+tbNNN8nRYaBla21FNi6VOVunqsSkAE
        qWRQOO94oeEo70axwrI=
X-Received: by 10.223.164.79 with SMTP id e15mr1195401wra.101.1502141161800;
        Mon, 07 Aug 2017 14:26:01 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-63-71.dynamic.sbb.rs. [24.135.63.71])
        by smtp.gmail.com with ESMTPSA id m127sm21324wmm.46.2017.08.07.14.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Aug 2017 14:26:00 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jul 2017, #09; Mon, 31)
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
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <e5564e40-702f-390b-69e2-2ed6e45610c8@gmail.com>
Date:   Mon, 7 Aug 2017 23:25:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <873794zbls.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/08/2017 22:26, Ævar Arnfjörð Bjarmason wrote:
> On Sat, Aug 05 2017, Junio C. Hamano jotted:
>> I actually consider "branch" to *never* invoking a checkout.  Even
>> when "git branch -m A B" happens to be done when your checked out
>> branch is A and you end up being on B.  That is not a "checkout".
> 
> I think we just have a different mental model of what "checkout"
> means. In my mind any operation that updates the HEAD to point to a new
> branch is a checkout of that branch.

If I may, from a side-viewer`s point of view, it seems you`re 
thinking in low-level implementation details, where what Junio 
describes seems more as a high-level, conceptual/end-user`s point of 
view.

Needing to update HEAD reference once we "rename" a branch, too, what 
you consider a "checkout", seems to be required only because branch 
name _is_ the branch reference in Git, so we need to update HEAD to 
point to a new/renamed branch reference -- but it`s still the same 
branch, conceptually.

Documentation for "git-checkout" states that it is used to "*Switch 
branches*...[snip]", and that is not what happens here. 
Implementation-wise it does because we can`t do it differently at the 
moment, but in user`s eyes it`s still the same branch, so no switch 
is made as far as the user is concerned.

In a different implementation, where branches would have permanent 
references other than their names, no HEAD update would be needed as 
the reference would still be the same, no matter the name change, 
making the `git branch -m` situation clear even from your standpoint, 
I`d say.

>> Really from the end-user's point of view that is not a checkout.
>> The user renamed the branch A and the same conceptual entity, which
>> is a branch, is now called B.  If that branch was what was checked
>> out (IOW, if that branch was what would be grown by one commit if
>> the user did "git commit"), then now that branch's name is B.  It is
>> natural if you ask "symbolic-ref HEAD" what branch is checked out
>> after renaming A to B (and A happened to be what was checked out),
>> the answer chould be B.
>>
>> It's like the city you live in changed the name of the street your
>> house is on.  You do not call movers, you do not do anything, but
>> your address changes.
> 
> Yeah I see what you mean, although this analogy rapidly breaks down when
> you poke at it as shown above. My house (a sha1) can be on any number of
> streets and new ones can be added/removed all the time without changing
> where my house is at.

I may be missing something, but I find the house/address analogy a 
good one, actually, as I understood that "house" resembles a branch 
reference HEAD is pointing to, not a sha1.

Even further, and that might be the point of confusion, "house" seems 
to be more like a "permanent branch reference" I mentioned above, 
where your address can change (branch being renamed), but you would 
still be in the same house (HEAD would still point to the same 
permanent branch reference).

If you move to another house, only then would HEAD change to point to 
another (permanent) branch reference (a different house), and that 
would be a checkout.

Yes, it`s not really how it works from the inside, but I think that`s 
irrelevant for the end-user experience :)

> So it's just a way to get something exactly like -m except the "move &&
> checkout" logic is changed to "copy && checkout".
Again, it seems the "checkout" part of "move && checkout" you`re 
talking about is a user-wise unnecessary implementation detail. For 
the user, it`s just a simple "move", staying on the same, but renamed 
branch, thus no branch switching occurred (no "checkout", as per 
documentation).

Regards,
Buga
