Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25FC01F404
	for <e@80x24.org>; Thu,  8 Mar 2018 19:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932199AbeCHT7O (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 14:59:14 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39845 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbeCHT7L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 14:59:11 -0500
Received: by mail-wm0-f68.google.com with SMTP id i3so2013wmi.4
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 11:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ohriWG0vyksChCr/+NOPOPPSrMJ2cDd0H4Z7UrM/Fr8=;
        b=BVgUWE/LuwFe17D7In7BLdpqVRH2nN6xcSh4mufB1H2MA0PyNTW7OusruC6zb6RbNv
         wJX3EvSquytMUrMvMuk/kSv44fKaHH/TlXD9NQCyG+gN17OAuNx75oJfETGuvKzH2GP9
         DdhDC1x5I7dLLBijzGVphgyMWqKzQr5b6bcmXbsUtLxJooeYDaNdTWXBEW0A0hRnY696
         EJ/lGce0ImUUBAmHaZi4T/o3Vay46sFuybVJeRPHgaQqbt/v+oFR9hlixeT0RJDkmhQZ
         NZPmDwL/pvHahMpoCv2Ka1SjTOz7S3Os+bfhRsd7yIsXnKOLnUknj2tmaHAdoYr5GNOh
         lFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ohriWG0vyksChCr/+NOPOPPSrMJ2cDd0H4Z7UrM/Fr8=;
        b=Yij0hazP/WqHm0ZmyhxSmySCIaeKvk3F9GhWJ8tuKSj/qG0obIGXkzyTu0SMNt7bab
         98UxHR+WQUnG1P7x0iUjYb3i3bl+HCpUXAMDpfSaPl3BjpYoAeuBh+a+1AL+uwXou+Pc
         7awdyYyh2BCrsVEkeENpwLR/D4rjAPEQRZIs5jv8UfHD5japRtBlhMOOs9wh0QzOOiqz
         9nCxjv//979s35HIBFYteqBUXmOUluSSQasZLHmyCsEw4sCq4aClg/QOxKTUI+FFqtJ6
         7Jt+tW2EyTm6XMl43o0spDHxM3v1Yz77k0hT4oaZFATDCS1ZYMx3C0Prg0udWT/guDid
         y7Cg==
X-Gm-Message-State: AElRT7FeEFdjffA3v5NFWJ9GGpvjbSH04OkMHaX9W/KsPx0Y2tGh5Gnf
        6APQLIcGAgBlCQSNkTCaUU0=
X-Google-Smtp-Source: AG47ELvC5DIwa2zEt7b0KXVYcUoU3ldWg8kdIspLq3ekNf0VK0V0lAihrCtGywmoSC4+yE/9L6ElXw==
X-Received: by 10.28.106.19 with SMTP id f19mr27626wmc.84.1520539149979;
        Thu, 08 Mar 2018 11:59:09 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id y64sm46297767wrb.56.2018.03.08.11.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 11:59:08 -0800 (PST)
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com>
 <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87vae8yq15.fsf@javad.com>
 <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com>
Date:   Thu, 8 Mar 2018 20:58:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 07/03/2018 15:08, Johannes Schindelin wrote:
> 
> > > Didn't we settle on Phillip's "perform successive three-way merges
> > > between the original merge commit and the new tips with the old tips
> > > as base" strategy?
> >
> > It seems you did, dunno exactly why.
> 
> That is not true. You make it sound like I was the only one who liked
> this, and not Phillip and Buga, too.

For myself, I do actually favor Sergey`s approach in general, but 
_implemented_ through what Phillip described (or a mixture of both, to 
be precise). But, let me explain... :)

> > The main problem with this decision is that we still don't see how and
> > when to stop for user amendment using this method. OTOH, the original
> > has this issue carefully discussed.
> 
> Why would we want to stop, unless there are merge conflicts?

Because we can reliably know that something "unusual" happened - and 
by that I don`t necessarily mean "wrong", but just might be worth 
user inspection.

For example, situation like this (M is made on A3 with `-s ours`, 
obsoleting Bx commits):

(1) ---X8--X9 (master)
       |\
       | A1---A2---A3
       |             \
       |              M (topic)
       |             /
       \-B1---B2---B3

... where we want to rebase M onto X9 is what I would call "usual 
stuff", but this situation (M is still made on A3 with `-s ours`, 
obsoleting Bx commits, but note cherry-picked B2'):

(2) ---X8--B2'--X9 (master)
       |\
       | A1---A2---A3
       |             \
       |              M (topic)
       |             /
       \-B1---B2---B3

... where we still want to rebase M onto X9 is what we might consider 
"unusual", because we noticed that something that shouldn`t be part 
of the rebased merge commit (due to previous `-s ours`) actually got 
in there (due to later cherry-pick), and just wanting the user to 
check and confirm.

This is the major reason why I would prefer Sergey`s approach in 
general... and might be I also have a good explanation on *why* it 
works, but let`s get there ;)

(p.s. This is only one, but certainly not the only case)

> > "rebase sides of the merge commit and then three-way merge them back
> > using original merge commit as base"
> 
> And that is also wrong, as I had proved already! Only Buga's addition made
> it robust against dropping/modifying commits, and that addition also makes
> it more complicated.

No, this is actually right, that sentence nicely describing _how_ it 
works. That addition of mine was just including the correct merge 
base (being the original merge commit that we are "rebasing"), and 
that`s what Sergey is talking about.

> And it still has no satisfactory simple explanation why it works.

Getting there... :)

> > > - it is *very easy* to reason about, once it is pointed out that
> > > rebases and merges result in the same trees.
> >
> > The original is as easy to reason about, if not easier, especially as
> > recursive merge strategy is not being used there in new ways.
> 
> So do it. I still have to hear a single-sentence, clear and obvious
> explanation why it works.
> 
> And please do not describe why your original version works, because it
> does not work. Describe why the one amended with Buga's hack works.
> 
> > I honestly don't see any advantages of Phillip's method over the
> > original, except personal preferences. At the same time, I have no
> > objection of using it either, provided consistency check problem is
> > solved there as well.
> 
> Okay, let me reiterate then, because I do not want this point to be
> missed:
> 
> Phillip's method is essentially merging the new tips into the original
> merge, pretending that the new tips were not rebased but merged into
> upstream.
> 
> So it exploits the duality of the rebase and merge operation, which both
> result in identical trees (potentially after resolving merge conflicts).
> 
> I cannot think of any such interpretation for your proposal augmented by
> Buga's fix-ups. And I haven't heard any such interpretation from your
> side, either.

Ok here it goes (I might be still wrong, but please bare with me).

What Sergey originally described also uses the "duality of the rebase 
and merge operation", too ;) Just in a bit different way (and might 
be a more straightforward one?).

Here`s a starting point, two commits A and B, merged into M:

(3) ---A
        \
         M
        /
    ---B


According the "patch theory"[1] (which might not be too popular 
around here, but should serve the purpose for what I`m trying to 
explain), each merge commit can be "transformed" to two non-merge 
commits, one on top of each of the merge parents, where new commit 
brings its original merge parent commit tree to the state of the 
merge commit tree:

(4) ---A---U1



    ---B---U2


Now, we have two new commits, U1 and U2, each having the same tree as 
previous merge commit M, but representing changes in regards to 
specific parents - and this is essentially what Sergey`s original 
approach was using (whether he knew it, or not).

When it comes to rebasing, it`s pretty simple, too. As this:

(5) ---X1---o---o---o---o---o---X2 (master)
       |\
       | A1---A2---A3
       |             \
       |              M
       |             /
       \-B1---B2---B3

... actually equals this:

(6) ---X1---o---o---o---o---o---X2 (master)
       |\
       | A1---A2---A3---U1
       |
       |
       |
       \-B1---B2---B3---U2

... where trees of M, U1 and U2 are same, and we can use the regular 
rebase semantics and rebase it to this:

(7) ---X1---o---o---o---o---o---X2 (master)
                                |\
                                | A1'--A2'--A3'--U1'
                                |
                                |
                                |
                                \-B1'--B2'--B3'--U2'

... which is essentially this again:

(8) ---X1---o---o---o---o---o---X2 (master)
                                |\
                                | A1'--A2'--A3'
                                |            \
                                |             M'
                                |            /
                                \-B1'--B2'--B3'

... where it is still true that trees of U1', U2' and M' are still 
the same. So we managed to rebase a merge commit without ever doing a 
merge :) (note that, practically, we _can_ finally even merge U1' and 
U2' to produce M', it shouldn`t really matter as all the trees are 
the same, so merge will be a no-op)

But, as we saw (what you`ve explained), this doesn`t really work in 
case one of the sides of the merge gets "disbalanced" (so to say), 
like dropping a commit (which could also happen non-interactively, 
where a commit has been cherry-picked to a different branch, but
previously obsoleted by `-s ours` merge).

As observed, dropped commit could still wrongly get into final merge 
commit tree (or cherry-picked commit wrongly not get there), due to 
the nature of those rebased U1 and U2 temporary commits to hold all 
the differences in regards to their specific merge commit parent.

A natural improvement to original idea which Sergey eventually came 
up with after my findings (which you now ended up calling a hack, even, 
but I would respectfully disagree), is to use original merge commit M 
as a merge base for final merge of U1' and U2' - and here is why it 
works, too, and why I wouldn`t consider it a hack, but a proper (and 
a solid) solution.

Merge commit M is what we are rebasing, so we should have a way to 
somehow learn from it, alongside U1 and U2 temporary commits - and 
that is what using original merge commit M as a base does for us. It 
helps us spot any "disbalances" that happened in comparison to original 
merge parent trees, which is exactly what we`re interested in.

In ideal case (as per "patch theory"[1]), final merge of rebased U1' 
and U2' with original merge commit M as a base would be rather simple, 
too (not to say pointless again), as both U1' and U2' would have same 
changes in comparison to M, namely all the changes from commit we are 
rebasing from (X1 above) to commit we are rebasing to (X2 above).

But in a more complex case like this:

(9) ---X1---B2'---o---o---o---o---X2 (master)
                                  |\
                                  | A12--A2'---B3'
                                  |             \
                                  |              M'
                                  |             /
                                  \-B1'--B3'---B4

..., being what we are ultimately interested in, it helps us notice 
all kind of changes on our rebased merge parent branches, and act 
accordingly (as shown by my previously posted test script[2]).

All this said (and hoping anyone is still reading this), to shed some 
light on what I meant by "favoring Sergey`s approach in general, but 
_implemented_ through what Phillip described".

I think we should use temporary commits U1 and U2, being a sound 
approach backed up by the "patch theory"[1], as it helps us notice 
any "disbalances" of the rebased merge commit parents trees (so we 
can stop for user inspection), finally merging them with original 
merge commit as a base, in order to spot additional changes on trees 
of the merge commit parents we are rebasing.

But, the merging steps themselves, backed up by a need to stop for 
conflict resolution as soon as one happens, should be performed 
_iteratively_, like Phillip showed us... I would think :)

And, for example, that would do wonders when we introduce completely 
new branch during an interactive rebase, too, for example:

(10) ---X1---B2'---o---o---o---o---X2 (master)
        |\                        /|\
        | A1---A2---A3---U1       || A12--A2'---B3'---U1'
        |             \           ||             \
        |              M          ||              M'
        |             /           ||             /|
        \-B1---B2---B3---U2       |\---B3'---B4-/-|---U2'
                                  |               |
                                  \-----B1'-------/


In this situation, we would merge all temporary Ux commits using 
original merge M as a merge base, and then merge _that_ resulting 
tree with B1' (being a newly introduced merge commit parent), using 
whatever merge base is most appropriate between the two (in this 
case, X2).

So, for diagram (10) above, I guess something like this:

	git merge-recursive U1' -- M U2'
	tree="$(git write-tree)"
	# in case of original merge being octopus, we would continue like:
	# git merge-recursive $tree -- M U3'
	# tree="$(git write-tree)"
	# git merge-recursive $tree -- M U4'
	# ... and so on, then finally:
	git merge-recursive $tree -- "$(git merge-base U1' U2' B1')" B1'
	# in more general case, it would be:
	# git merge-recursive $tree -- "$(git merge-base <all-parents-of-new-merge-commit>)" B1'
	tree="$(git write-tree)"
	git tag M' "$(git log --pretty=%B -1 M | git commit-tree $tree -p B3' -p B4 -p B1')"

... where we would stop for conflict resolution after each failing 
merge-recursive attempt (which is also true for producing rebased U1' 
and U2' in the first place).

There, I would still need to make a test script doing this, but I 
hope the concept is clear, and I`m not missing something crucial here.

Comments welcome :)

Regards, Buga

[1] https://en.wikibooks.org/wiki/Understanding_Darcs/Patch_theory
[2] https://public-inbox.org/git/f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com/
