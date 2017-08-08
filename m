Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0680C20899
	for <e@80x24.org>; Tue,  8 Aug 2017 13:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbdHHNOJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 09:14:09 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37518 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbdHHNOH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 09:14:07 -0400
Received: by mail-wm0-f51.google.com with SMTP id t201so6875550wmt.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 06:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=azbmC6laUiRgFBnJjqoBT6LPwBT4IYXQ6SvuvT8DKc0=;
        b=nbb5jAV857FBLCzRMhMj7thNzXJ1AuPO7fkoDl5eoP8SyjTgf0/36+1bU1WXn1XBLB
         kb8x8uFPlPoO3TwqPTO5/rfKJq1O7pRRzQUCjQfqEYV0OkIkUqmr7+Z2Ws3wy9nWrCHw
         4cTbw6fngLotEy5w9pTSA2Aa1/jNqXDSRfNYO3kaDYpa7xnIHt113/88jUwqRiQtBXZF
         0QcuyIemezKSGHRyC39x+qwN+TqXqvz2HAx1QnFdDGgl1LUO0DWfMc2ikO7/uQyVIbFR
         BVLnWov2LPb3VrjDO6uBfwusF7l7h12bpGRAIdGI18OSUmuhAsDzhhunaXbxMrK3Tyw5
         F4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=azbmC6laUiRgFBnJjqoBT6LPwBT4IYXQ6SvuvT8DKc0=;
        b=hk2E4ajj5MkTbPgmM34xzG77v6oyT04hrl9fIaTBkwg5X8ujkpLgbmpQxVZF1ujEgw
         rzsefkHivNJMSuQEqBGhHkqiFrGUI6hg4aCO/oXSOYqnIeK+BIMuiDMeCNgzSVl+bpXH
         pEN8UatmAM89RRsJDK/QV1L23QFVa+4RelCe/JA7Ldl0IaIFBKNoWJoRsAeKPdBgUWax
         NcK1cFIrhlqVyI/1mO3HkjmPlJ0jff8U/qots1ay4Dl4oOJDZHuBkYzWiWAa+trzO44O
         4uIsjjoQSRT75rXpVygQhbF/w1B71PXRUR7jQQ4ex+42TWeBeEt10ZjZDZmKN+91ZOlo
         nH9Q==
X-Gm-Message-State: AHYfb5iM487dMO6kXyKHqMXQmxSYffK6gQ18eKRYYC3jo+nVgDjUSEsK
        P0+zmp0BDHHnPQ==
X-Received: by 10.80.225.196 with SMTP id m4mr4508937edl.222.1502198046052;
        Tue, 08 Aug 2017 06:14:06 -0700 (PDT)
Received: from snth (157-157-140-194.dsl.dynamic.simnet.is. [157.157.140.194])
        by smtp.gmail.com with ESMTPSA id e34sm782373edb.9.2017.08.08.06.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2017 06:14:04 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1df4Kg-00047u-VT; Tue, 08 Aug 2017 15:14:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sahil Dua <sahildua2305@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2017, #09; Mon, 31)
References: <xmqqfudcgryb.fsf@gitster.mtv.corp.google.com> <232547ab-3b87-debc-36a4-d2285ec10a06@ramsayjones.plus.com> <CALiud+nm9wu4rBY6zBXmenJj_0Mn7xeU_FAvSdn4fdH+q--Jag@mail.gmail.com> <xmqqd18cweak.fsf@gitster.mtv.corp.google.com> <87shh57nzs.fsf@gmail.com> <xmqqpoc9sksg.fsf@gitster.mtv.corp.google.com> <873794zbls.fsf@gmail.com> <e5564e40-702f-390b-69e2-2ed6e45610c8@gmail.com> <db848b3e-e4cc-ddf4-9e4c-7b47b2f5d7a7@gmail.com>
User-agent: Debian GNU/Linux 8.9 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <db848b3e-e4cc-ddf4-9e4c-7b47b2f5d7a7@gmail.com>
Date:   Tue, 08 Aug 2017 15:14:02 +0200
Message-ID: <874ltigq1x.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 07 2017, Igor Djordjevic jotted:

> On 07/08/2017 23:25, Igor Djordjevic wrote:
>> On 06/08/2017 22:26, Ævar Arnfjörð Bjarmason wrote:
>>> On Sat, Aug 05 2017, Junio C. Hamano jotted:
>>>> I actually consider "branch" to *never* invoking a checkout.  Even
>>>> when "git branch -m A B" happens to be done when your checked out
>>>> branch is A and you end up being on B.  That is not a "checkout".
>>>
>>> I think we just have a different mental model of what "checkout"
>>> means. In my mind any operation that updates the HEAD to point to a new
>>> branch is a checkout of that branch.
>>
>> If I may, from a side-viewer`s point of view, it seems you`re
>> thinking in low-level implementation details, where what Junio
>> describes seems more as a high-level, conceptual/end-user`s point of
>> view.

Yeah, I think that's a fair summary. Also I didn't mean to de-rail this
whole thread on what "checkout" really means, just explain what I meant
with previous comments, since there seemed to be confusion about that.

>> Needing to update HEAD reference once we "rename" a branch, too, what
>> you consider a "checkout", seems to be required only because branch
>> name _is_ the branch reference in Git, so we need to update HEAD to
>> point to a new/renamed branch reference -- but it`s still the same
>> branch, conceptually.

It's not *required* we could do one of three things:

 1) Do what we do now, i.e. rename the branch/reflog & check out the new
    name.

 2) Rename the branch/reflog and checkout HEAD^0, i.e. say "the branch
    is now elsewhere, but we haven't moved your commit".

 3) Just not run replace_each_worktree_head_symref() which would end up
 on a branch with no commits, i.e. an orphan branch.

Now, I think 2 & 3 are pretty nonsensical and wouldn't ever propose we
should do that, but it's illustrative that #1 is not some required
inevitability in terms of explaining what's happening with the new name
being checked out (i.e. HEAD being updated).

>> Documentation for "git-checkout" states that it is used to "*Switch
>> branches*...[snip]", and that is not what happens here.

That's just the summary at the top but not the full story of what
git-checkout does. E.g. you can checkout a bare SHA1 which is not
switching branches, or a tag or whatever.

>> Implementation-wise it does because we can`t do it differently at the
>> moment, but in user`s eyes it`s still the same branch, so no switch
>> is made as far as the user is concerned.

Kind of, it's also worthwhile to think about that in some sense no
switch would be performed as far as the user is concerned by taking
option #2, i.e. we'd be in the same working tree / you could still make
commits.

You just couldn't make new commits on your "master" which is now called
"topic" and get new commits on "topic". I think it makes sense to do
that, but again, it's illustrative that it's not inevitable for
discussing the implementation.

>> In a different implementation, where branches would have permanent
>> references other than their names, no HEAD update would be needed as
>> the reference would still be the same, no matter the name change,
>> making the `git branch -m` situation clear even from your standpoint,
>> I`d say.
>>
>>>> Really from the end-user's point of view that is not a checkout.
>>>> The user renamed the branch A and the same conceptual entity, which
>>>> is a branch, is now called B.  If that branch was what was checked
>>>> out (IOW, if that branch was what would be grown by one commit if
>>>> the user did "git commit"), then now that branch's name is B.  It is
>>>> natural if you ask "symbolic-ref HEAD" what branch is checked out
>>>> after renaming A to B (and A happened to be what was checked out),
>>>> the answer chould be B.
>>>>
>>>> It's like the city you live in changed the name of the street your
>>>> house is on.  You do not call movers, you do not do anything, but
>>>> your address changes.
>>>
>>> Yeah I see what you mean, although this analogy rapidly breaks down when
>>> you poke at it as shown above. My house (a sha1) can be on any number of
>>> streets and new ones can be added/removed all the time without changing
>>> where my house is at.
>>
>> I may be missing something, but I find the house/address analogy a
>> good one, actually, as I understood that "house" resembles a branch
>> reference HEAD is pointing to, not a sha1.
>>
>> Even further, and that might be the point of confusion, "house" seems
>> to be more like a "permanent branch reference" I mentioned above,
>> where your address can change (branch being renamed), but you would
>> still be in the same house (HEAD would still point to the same
>> permanent branch reference).
>>
>> If you move to another house, only then would HEAD change to point to
>> another (permanent) branch reference (a different house), and that
>> would be a checkout.

I've yet to see a good real-world analogy of "DAG with labels", which is
all git really is, that doesn't break down at some point. Trees are
probably the best comparison, but even that breaks down in the face of
branch merges or even merges of entirely unrelated trees.

So it's probably pointless to discuss this tangent any further, I don't
think it helps with deciding what to do about this new -c construct.

>> Yes, it`s not really how it works from the inside, but I think that`s
>> irrelevant for the end-user experience :)
>>
>>> So it's just a way to get something exactly like -m except the "move &&
>>> checkout" logic is changed to "copy && checkout".
>>
>> Again, it seems the "checkout" part of "move && checkout" you`re
>> talking about is a user-wise unnecessary implementation detail. For
>> the user, it`s just a simple "move", staying on the same, but renamed
>> branch, thus no branch switching occurred (no "checkout", as per
>> documentation).

Yes I agree that this has little to no impact on what's happening for
the user, I've merely been discussing "checkout" in the terms of what's
happening under the hood here.

> All this said, having you mentioning the two argument version:
>
>>     $ git checkout master
>>     $ git branch -m topic avar/topic
>
> ... exactly proves the point that "git branch -m" is not expected to
> involve a checkout, even from implementation perspective. It`s just a
> consequence of needing to update the (now obsolete) reference HEAD
> points to (only) when the branch we`re renaming (moving) is the one
> that is currently checked-out.

Hrm, I think you're confused about what this example does. For the sake
of avoiding confusion let's stop talking about checkout and just talk
about updating the HEAD.

The point of that example is to show that the HEAD is only updated by
git branch [-m|-c] if the branch being moved/copied is the branch you're
currently on.

Here the user just checked out master and then moved an unrelated topic
to avar/topic, that just manipulates the ref store & config, and won't
touch the HEAD.

The reason I'm mentioning that example (and talking about a "subset") is
that amending git-checkout to do some of what this new "git-branch -c"
option would do would only cover a subset of what it does, since both -m
and -c are two-mode options in the sense that some of the time they
manipulate the refstore and the HEAD, and some of the time only the
refstore.

>> Yeah it's not something I'm interested in or have a use-case for,
>> although I think in the same way we have -t for checkout it might be
>> sensible to have e.g.:
>>
>>     $ git checkout -b topic-2 -c topic -t origin/master
>>
>> Where the new -c or --config-from would mean "...and get the config from
>> 'topic'". Such a name would probably be less confusing than
>> --super-b[branch?] which to be implies some ongoing hierarchical
>> relationship.
>
> This, on the other hand, sounds sensible, staying true to the
> existing logic. In the same manner you can do either:

To continue the explanation above, yeah it's sensible, but I'm pointing
out that it's *also* sensible, i.e. whatever mode git-checkout has for
"let's create a branch with the same start point & config as [some other
branch]" it's always going to be complimentary but not a replacement for
git branch [-m|-c], since [-m|-c] has a mode for doing that without
doing any checkout whatsoever, just manipulating the refstore.

>     $ git branch topic -t origin/master
>     $ git checkout topic
>
> ... or shorter equivalent:
>
>     $ git checkout -b topic -t origin/master
>
> ..., you should be able to do:
>
>     $ git branch -c topic topic-2
>     $ git checkout topic-2
>
> ..., or equivalent:
>
>     $ git checkout -b topic-2 -c topic
>
> ..., where "-c" would follow the same (or similar) logic as "-t" does
> now, as you already pointed out :)
>
> p.s. That said, is `git checkout -b topic-2 --move topic` being
> missed now...? :P That one would/could/should actually be expected to
> move (rename) the branch *and* check it out, no matter if HEAD
> currently points to it or not.
>
> Regards,
> Buga
