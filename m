Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F3B120899
	for <e@80x24.org>; Tue,  8 Aug 2017 18:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbdHHSzX (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 14:55:23 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34180 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbdHHSzW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 14:55:22 -0400
Received: by mail-wr0-f193.google.com with SMTP id o33so3058453wrb.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 11:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ueTqQ3Tl8lMoeZyQOLO/Cy5dHyBHT+Ktwm99vVWOJBc=;
        b=KJ6gxOP01gREcsFQufaXIBxzLk1dY1LYyyIEpM28ISx++zxX3LkqMMT8fWYLfDU1Vw
         PthFPqxQ19SqhKOyvzWUjrM8o/S7MNcizrJH/H7AIIoIj6NupezXFYlmPEN8vK7Envgy
         ab62LbLD38r66uMDco3pcO/9uJIuDzGXj+mWJqd5i5ko7b8Q5nPmqLwJBF1PnEIDWJQQ
         rasiF78CU5t0yalpPq9y1wqWY85s1CdTgdAd1INBVUNbZ0uWfG3ejwX438DOxMYakocR
         p0OVs/7/jg0agykKgWBWDfnjBAeEtVwuvFVfyee+B1rV/ZspHViupvh+8rp+pXyeONLg
         7YyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ueTqQ3Tl8lMoeZyQOLO/Cy5dHyBHT+Ktwm99vVWOJBc=;
        b=bQJUkxnVpfl43zp4GmtRmHk+xzX2t1XN785rHklWr0ea1RcBtn7OBptsnLOvG5Mqvs
         uBsXchSwhLmhE2wDpoUIop+Y6Op8Eu1a96lj7tYKOFAqIxO2yuR1c+tZTx5ao9VmkiAS
         hAjsjWN7SZjZeB5caPcahE5W4RSmFNLoas60uaZKxc1sfdtu/B30oh7Ql8ohycH+ggLe
         olYn8b95lqrpG6qQa6xewODtfjSo+tQzeei3a/1qPrW61upZEXpWZ6cE6NCzPzgmdTaV
         4DGjo2pFwtkA1pZhLLZ3iYEqPQkfKlz3bHHqvc8Bg+X8hVxOLEsSrV9XMYTrFkgK1pd/
         BXZQ==
X-Gm-Message-State: AHYfb5jlklf7sUiuTGG7ivKLTXP0FeriV6lgHnbwpMkLCBXYepUY6aOm
        aYCqTtgO7c6X6lKGCG5LJQ==
X-Received: by 10.223.154.3 with SMTP id z3mr4042625wrb.252.1502218521096;
        Tue, 08 Aug 2017 11:55:21 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-63-71.dynamic.sbb.rs. [24.135.63.71])
        by smtp.gmail.com with ESMTPSA id 39sm2289391wrc.84.2017.08.08.11.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2017 11:55:20 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jul 2017, #09; Mon, 31)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sahil Dua <sahildua2305@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git Mailing List <git@vger.kernel.org>
References: <xmqqfudcgryb.fsf@gitster.mtv.corp.google.com>
 <232547ab-3b87-debc-36a4-d2285ec10a06@ramsayjones.plus.com>
 <CALiud+nm9wu4rBY6zBXmenJj_0Mn7xeU_FAvSdn4fdH+q--Jag@mail.gmail.com>
 <xmqqd18cweak.fsf@gitster.mtv.corp.google.com> <87shh57nzs.fsf@gmail.com>
 <xmqqpoc9sksg.fsf@gitster.mtv.corp.google.com> <873794zbls.fsf@gmail.com>
 <e5564e40-702f-390b-69e2-2ed6e45610c8@gmail.com>
 <db848b3e-e4cc-ddf4-9e4c-7b47b2f5d7a7@gmail.com> <874ltigq1x.fsf@gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <2cd06f54-df42-087c-6a11-678f8ce9dd0d@gmail.com>
Date:   Tue, 8 Aug 2017 20:55:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <874ltigq1x.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08/2017 15:14, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Aug 07 2017, Igor Djordjevic jotted:
>> On 07/08/2017 23:25, Igor Djordjevic wrote:
>>> On 06/08/2017 22:26, Ævar Arnfjörð Bjarmason wrote:
>>>> On Sat, Aug 05 2017, Junio C. Hamano jotted:
>>>>> I actually consider "branch" to *never* invoking a checkout.  Even
>>>>> when "git branch -m A B" happens to be done when your checked out
>>>>> branch is A and you end up being on B.  That is not a "checkout".
>>>>
>>>> I think we just have a different mental model of what "checkout"
>>>> means. In my mind any operation that updates the HEAD to point to a new
>>>> branch is a checkout of that branch.
>>>
>>> If I may, from a side-viewer`s point of view, it seems you`re
>>> thinking in low-level implementation details, where what Junio
>>> describes seems more as a high-level, conceptual/end-user`s point of
>>> view.
> 
> Yeah, I think that's a fair summary. Also I didn't mean to de-rail this
> whole thread on what "checkout" really means, just explain what I meant
> with previous comments, since there seemed to be confusion about that.
> 
>>> Needing to update HEAD reference once we "rename" a branch, too, what
>>> you consider a "checkout", seems to be required only because branch
>>> name _is_ the branch reference in Git, so we need to update HEAD to
>>> point to a new/renamed branch reference -- but it`s still the same
>>> branch, conceptually.
> 
> It's not *required* we could do one of three things:
> 
>  1) Do what we do now, i.e. rename the branch/reflog & check out the new
>     name.
> 
>  2) Rename the branch/reflog and checkout HEAD^0, i.e. say "the branch
>     is now elsewhere, but we haven't moved your commit".
> 
>  3) Just not run replace_each_worktree_head_symref() which would end up
>  on a branch with no commits, i.e. an orphan branch.
> 
> Now, I think 2 & 3 are pretty nonsensical and wouldn't ever propose we
> should do that, but it's illustrative that #1 is not some required
> inevitability in terms of explaining what's happening with the new name
> being checked out (i.e. HEAD being updated).

I think we agree, but we`re talking from different standpoints again.

You say "it *can* be done *but* it doesn`t make sense", where I say 
"it *can`t* be done *because* it doesn`t make sense".

Implementation wise, of course it can be done differently, but 
conceptually it would be wrong (or confusing, at least), thus 
different implementation, while theoretically possible, may not be a 
sane option, thus it`s impractical (not to say "impossible").

By "required", I really meant "required in order to be conceptually 
sane".

>>> Documentation for "git-checkout" states that it is used to "*Switch
>>> branches*...[snip]", and that is not what happens here.
> 
> That's just the summary at the top but not the full story of what
> git-checkout does. E.g. you can checkout a bare SHA1 which is not
> switching branches, or a tag or whatever.

I disagree, by checking out a bare SHA1 (or tag or whatever) I`d say 
you *are* still switching branches - conceptually, at least.

When you move from a named branch to (yet) unnamed one, you are 
switching branches. Same goes for when you switch from one unnamed 
branch to another (named or unnamed).

Might be "detached HEAD" is not something we call an "unnamed 
branch", but that`s what it practically is.

>>> Implementation-wise it does because we can`t do it differently at the
>>> moment, but in user`s eyes it`s still the same branch, so no switch
>>> is made as far as the user is concerned.
> 
> Kind of, it's also worthwhile to think about that in some sense no
> switch would be performed as far as the user is concerned by taking
> option #2, i.e. we'd be in the same working tree / you could still make
> commits.
> 
> You just couldn't make new commits on your "master" which is now called
> "topic" and get new commits on "topic". I think it makes sense to do
> that, but again, it's illustrative that it's not inevitable for
> discussing the implementation.

But your second paragraph exactly explains why it`s not the same with 
option #2 (I guess you mean "no HEAD update to point to renamed 
branch" here) - if user renames branch "master" to "topic", it`s 
natural to expect that next commit is made on "topic" (which is now a 
new name for "master", conceptually still being the same, just 
renamed branch).

Ending up in limbo, in a detached HEAD state, or even worse, still 
being on a branch with an old name "master" (which conceptually 
shouldn`t exist anymore, being known as "topic" now), would be 
confusing, to say the least, and conceptually wrong, I would add.

>>> In a different implementation, where branches would have permanent
>>> references other than their names, no HEAD update would be needed as
>>> the reference would still be the same, no matter the name change,
>>> making the `git branch -m` situation clear even from your standpoint,
>>> I`d say.
>>>
>>>>> Really from the end-user's point of view that is not a checkout.
>>>>> The user renamed the branch A and the same conceptual entity, which
>>>>> is a branch, is now called B.  If that branch was what was checked
>>>>> out (IOW, if that branch was what would be grown by one commit if
>>>>> the user did "git commit"), then now that branch's name is B.  It is
>>>>> natural if you ask "symbolic-ref HEAD" what branch is checked out
>>>>> after renaming A to B (and A happened to be what was checked out),
>>>>> the answer chould be B.
>>>>>
>>>>> It's like the city you live in changed the name of the street your
>>>>> house is on.  You do not call movers, you do not do anything, but
>>>>> your address changes.
>>>>
>>>> Yeah I see what you mean, although this analogy rapidly breaks down when
>>>> you poke at it as shown above. My house (a sha1) can be on any number of
>>>> streets and new ones can be added/removed all the time without changing
>>>> where my house is at.
>>>
>>> I may be missing something, but I find the house/address analogy a
>>> good one, actually, as I understood that "house" resembles a branch
>>> reference HEAD is pointing to, not a sha1.
>>>
>>> Even further, and that might be the point of confusion, "house" seems
>>> to be more like a "permanent branch reference" I mentioned above,
>>> where your address can change (branch being renamed), but you would
>>> still be in the same house (HEAD would still point to the same
>>> permanent branch reference).
>>>
>>> If you move to another house, only then would HEAD change to point to
>>> another (permanent) branch reference (a different house), and that
>>> would be a checkout.
> 
> I've yet to see a good real-world analogy of "DAG with labels", which is
> all git really is, that doesn't break down at some point. Trees are
> probably the best comparison, but even that breaks down in the face of
> branch merges or even merges of entirely unrelated trees.
> 
> So it's probably pointless to discuss this tangent any further, I don't
> think it helps with deciding what to do about this new -c construct.
> 
>>> Yes, it`s not really how it works from the inside, but I think that`s
>>> irrelevant for the end-user experience :)
>>>
>>>> So it's just a way to get something exactly like -m except the "move &&
>>>> checkout" logic is changed to "copy && checkout".
>>>
>>> Again, it seems the "checkout" part of "move && checkout" you`re
>>> talking about is a user-wise unnecessary implementation detail. For
>>> the user, it`s just a simple "move", staying on the same, but renamed
>>> branch, thus no branch switching occurred (no "checkout", as per
>>> documentation).
> 
> Yes I agree that this has little to no impact on what's happening for
> the user, I've merely been discussing "checkout" in the terms of what's
> happening under the hood here.
> 
>> All this said, having you mentioning the two argument version:
>>
>>>     $ git checkout master
>>>     $ git branch -m topic avar/topic
>>
>> ... exactly proves the point that "git branch -m" is not expected to
>> involve a checkout, even from implementation perspective. It`s just a
>> consequence of needing to update the (now obsolete) reference HEAD
>> points to (only) when the branch we`re renaming (moving) is the one
>> that is currently checked-out.
> 
> Hrm, I think you're confused about what this example does. For the sake
> of avoiding confusion let's stop talking about checkout and just talk
> about updating the HEAD.
> 
> The point of that example is to show that the HEAD is only updated by
> git branch [-m|-c] if the branch being moved/copied is the branch you're
> currently on.
> 
> Here the user just checked out master and then moved an unrelated topic
> to avar/topic, that just manipulates the ref store & config, and won't
> touch the HEAD.
> 
> The reason I'm mentioning that example (and talking about a "subset") is
> that amending git-checkout to do some of what this new "git-branch -c"
> option would do would only cover a subset of what it does, since both -m
> and -c are two-mode options in the sense that some of the time they
> manipulate the refstore and the HEAD, and some of the time only the
> refstore.

I think we agree here, up to a point. I just wanted to take your 
example in a different direction, obviously not being successful 
enough with my goal :)

Implementation wise, we agree completely.

Conceptually, "branch" manipulates HEAD only to update an invalidated 
reference HEAD would otherwise still point to (being a dangling 
pointer now), updating it only as much as needed to still point to 
the same entity (branch), but having a different name now (thus a 
different reference, which is implementation detail). It doesn`t do 
checkout in terms of "switching branches".

On the other hand, "checkout" is expected to manipulate HEAD to 
"switch branches" (named or "unnamed", detached head etc., as argued 
above).

>>> Yeah it's not something I'm interested in or have a use-case for,
>>> although I think in the same way we have -t for checkout it might be
>>> sensible to have e.g.:
>>>
>>>     $ git checkout -b topic-2 -c topic -t origin/master
>>>
>>> Where the new -c or --config-from would mean "...and get the config from
>>> 'topic'". Such a name would probably be less confusing than
>>> --super-b[branch?] which to be implies some ongoing hierarchical
>>> relationship.
>>
>> This, on the other hand, sounds sensible, staying true to the
>> existing logic. In the same manner you can do either:
> 
> To continue the explanation above, yeah it's sensible, but I'm pointing
> out that it's *also* sensible, i.e. whatever mode git-checkout has for
> "let's create a branch with the same start point & config as [some other
> branch]" it's always going to be complimentary but not a replacement for
> git branch [-m|-c], since [-m|-c] has a mode for doing that without
> doing any checkout whatsoever, just manipulating the refstore.

Might be it didn`t read like that, but I actually agreed with you 
here completely :)

My point was exactly to say that "branch" and "checkout" [-m|-c] 
should exist one next to the other, where "checkout" also switches 
branches, and "branch" does not...

... which brings us to the very first point this whole discussion was 
started about, I think, whether "branch" should "switch branches" or 
not, and it seems the conclusion would be "no, it should not" :)

Yes, "branch" can update HEAD in case of a renamed branch, but 
conceptually, that`s not "branch switching" - but if you really want 
to "switch" to a newly created branch right away in a single command 
("new branch" not being renamed existing named or unnamed branch, but 
a genuinely new entity), "checkout" would be the tool for the job.

>>     $ git branch topic -t origin/master
>>     $ git checkout topic
>>
>> ... or shorter equivalent:
>>
>>     $ git checkout -b topic -t origin/master
>>
>> ..., you should be able to do:
>>
>>     $ git branch -c topic topic-2
>>     $ git checkout topic-2
>>
>> ..., or equivalent:
>>
>>     $ git checkout -b topic-2 -c topic
>>
>> ..., where "-c" would follow the same (or similar) logic as "-t" does
>> now, as you already pointed out :)
>>
>> p.s. That said, is `git checkout -b topic-2 --move topic` being
>> missed now...? :P That one would/could/should actually be expected to
>> move (rename) the branch *and* check it out, no matter if HEAD
>> currently points to it or not.
>>
>> Regards,
>> Buga
