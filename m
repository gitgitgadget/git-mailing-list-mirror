Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAEFF1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 00:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935595AbeCCA3v (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 19:29:51 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39631 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935368AbeCCA3u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 19:29:50 -0500
Received: by mail-wm0-f66.google.com with SMTP id i3so5908006wmi.4
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 16:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lTBCa/jiBuBoSQ5HhpcsR8633fEgtQ6vWW7irdMz+N0=;
        b=l59lU1bvumFchzJCRBvM7U+cFMohuYpdbzGZ6uUOGZ2Z0dcRy62Z1uXT27XWHrBKrp
         6I7WtV49jTBbLUxRCgd2vm4NBOkzFGQJJRwHj+vu1+YwnSrSia+Lr1IIk0ckorIFUD74
         iP2gNVpeRNA0Kgzce2r8wJR4LUdruigF4EWlTl4HkClcOoOUQaiG4UrrW9QbHtJUs8WH
         4a7uYDURvEf0g2WT0v2zxCT5sfBWaN7cnnkorLRhdzYZc9f7uU4Ea3tvULSXGQfP7wUm
         hpz/OLlYnrG/K+m5bnkz0bFj3mA1PhlT1TmElAh1KYD1vk5T9bHT6el6GDPh6JlGMWTN
         OD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lTBCa/jiBuBoSQ5HhpcsR8633fEgtQ6vWW7irdMz+N0=;
        b=Txa5uIuXxMb/hau9sSCAgQ5n0hXoktJBfgdAyEddI+tmvF/CpmMZWXrQQOrUyl4tYQ
         q2famxcwZKuB0oN6uty50Ub87iuxBacJSqV7WBjO6p5MrrdNJ53pFqAnuJXn6ZKRXuy2
         9CgxLj6UEOzQSq+5T7xtDooRWTXP5GkACSxk8UMa31/2kAarzfOjPxKIyDrNClnt4Bee
         LZVTXKAQ4DL6N+u2CkE5R11D6MmeWFriTM4989vMwg/xPc7E6WrBcfq0eNBmvgN7V2nG
         mBuuqdaHH1XWoFDz54xXZJ1dbQ78Ppe+i+vYDVE9F59mjVofitPe0yq+XY1PPus7XFAt
         DgXg==
X-Gm-Message-State: AElRT7HbFOkGhwEuRNwK7qgNUpnXiwinMEfqScCSut7a444CnA2LzU6A
        W5rde2Y7Ldgjk2ymyZQgXRY=
X-Google-Smtp-Source: AG47ELtdkUh4xidkXXgUoyK8BP2WDoLLVjrNMVYzX48yb8bLBKj+WLepocX8BvOCkmmTfn9IETTXIQ==
X-Received: by 10.28.94.131 with SMTP id s125mr2629790wmb.155.1520036988929;
        Fri, 02 Mar 2018 16:29:48 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id o94sm11799995wrc.7.2018.03.02.16.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 16:29:48 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     phillip.wood@dunelm.org.uk, Sergey Organov <sorganov@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com>
Date:   Sat, 3 Mar 2018 01:29:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 02/03/2018 12:31, Phillip Wood wrote:
> 
> > Thinking about it overnight, I now suspect that original proposal had a
> > mistake in the final merge step. I think that what you did is a way to
> > fix it, and I want to try to figure what exactly was wrong in the
> > original proposal and to find simpler way of doing it right.
> >
> > The likely solution is to use original UM as a merge-base for final
> > 3-way merge of U1' and U2', but I'm not sure yet. Sounds pretty natural
> > though, as that's exactly UM from which both U1' and U2' have diverged
> > due to rebasing and other history editing.
> 
> Hi Sergey, I've been following this discussion from the sidelines,
> though I haven't had time to study all the posts in this thread in
> detail. I wonder if it would be helpful to think of rebasing a merge as
> merging the changes in the parents due to the rebase back into the
> original merge. So for a merge M with parents A B C that are rebased to
> A' B' C' the rebased merge M' would be constructed by (ignoring shell
> quoting issues)
> 
> git checkout --detach M
> git merge-recursive A -- M A'
> tree=$(git write-tree)
> git merge-recursive B -- $tree B'
> tree=$(git write-tree)
> git merge-recursive C -- $tree C'
> tree=$(git write-tree)
> M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB' -pC')
> 
> This should pull in all the changes from the parents while preserving
> any evil conflict resolution in the original merge. It superficially
> reminds me of incremental merging [1] but it's so long since I looked at
> that I'm not sure if there are any significant similarities.
> 
> [1] https://github.com/mhagger/git-imerge

Interesting, from quick test[3], this seems to produce the same 
result as that other test I previously provided[2], where temporary 
commits U1' and U2' are finally merged with original M as a base :)

Just that this looks like even more straight-forward approach...?

The only thing I wonder of here is how would we check if the 
"rebased" merge M' was "clean", or should we stop for user amendment? 
With that other approach Sergey described, we have U1'==U2' to test with.

By the way, is there documentation for `git merge-recursive` 
anywhere, besides the code itself...? :$

Thanks, Buga

[2] https://public-inbox.org/git/f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com/
[3] Quick test script:
-- >8 --
#!/bin/sh

# rm -rf ./.git
# rm -f ./test.txt

git init

touch ./test.txt
git add -- test.txt

# prepare repository
for i in {1..8}
do
	echo X$i >>test.txt
	git commit -am "X$i"
done

# prepare branch A
git checkout -b A
sed -i '2iA1' test.txt
git commit -am "A1"
sed -i '4iA2' test.txt
git commit -am "A2"
sed -i '6iA3' test.txt
git commit -am "A3"

# prepare branch B
git checkout -b B master
sed -i '5iB1' test.txt
git commit -am "B1"
sed -i '7iB2' test.txt
git commit -am "B2"
sed -i '9iB3' test.txt
git commit -am "B3"

git checkout -b topic A
git merge -s ours --no-commit B # merge A and B with `-s ours`
sed -i '8iM' test.txt           # amend merge commit ("evil merge")
git commit -am "M"
git tag M #original-merge

# master moves on...
git checkout master
git cherry-pick B^     # cherry-pick B2 into master
sed -i "1iX9" test.txt # add X9
git commit -am "X9"

# (0) ---X8--B2'--X9 (master)
#        |\
#        | A1---A2---A3 (A)
#        |             \
#        |              M (topic)
#        |             /
#        \-B1---B2---B3 (B)

# simple/naive demonstration of proposed merge rebasing logic
# using iterative merge-recursive, preserving merge commit manual
# amendments, testing `-s ours` merge with cherry-picking from
# obsoleted part, but still respecting interactively rebased
# added/modified/dropped/cherry-picked commits :)

git checkout -b A-prime A
git reset --hard HEAD^             # drop A3 from A
sed -i '/A1/c\A12' test.txt        # amend A1 to A12
git commit -a --amend --no-edit
git rebase master                  # rebase A onto master
git cherry-pick B                  # cherry-pick B3 into A

git checkout -b B-prime B
git rebase master                  # rebase B onto master
sed -i '12iB4' test.txt            # add B4
git commit -am "B4"

git checkout --detach M
git merge-recursive A -- M A-prime
tree="$(git write-tree)"
git merge-recursive B -- $tree B-prime
tree="$(git write-tree)"
git tag M-prime "$(git log --pretty=%B -1 M | git commit-tree $tree -p A-prime -p B-prime)"

git update-ref refs/heads/topic "$(git rev-parse M-prime)"
git checkout topic

# (1) ---X8--B2'--X9 (master)
#                 |\
#                 | A12--A2'---B3' (A)
#                 |             \
#                 |              M' (topic)
#                 |             /
#                 \-B1'--B3'---B4  (B)

# show resulting graph
# echo
# git log --all --decorate --oneline --graph

# in comparison to original merge commit M, rebased merge commit 
# M' is expected to:
#
# - Add X9, from updated "master"
# - Have A1 changed to A12, due to A12 commit amendment
# - Keep A2, rebased as A2'
# - Remove A3, due to dropped A3 commit
# - Keep amendment from original (evil) merge commit M
# - Miss B1' like M does B, due to original `-s ours` merge strategy
# - Add B2, cherry-picked as B2' into "master"
# - Add B3, cherry-picked as B3' into "A"
# - Add B4, added to "B"
#
# echo
# echo 'diff M M-prime:'
# git diff M M-prime
