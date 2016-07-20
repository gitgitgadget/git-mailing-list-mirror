Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 821851F744
	for <e@80x24.org>; Wed, 20 Jul 2016 14:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbcGTOsr (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 10:48:47 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:36066 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981AbcGTOsp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 10:48:45 -0400
Received: by mail-io0-f171.google.com with SMTP id b62so49481936iod.3
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 07:48:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ISydJTy7z/3XqMg+u/OmCEGmGMStHYjvJGUx8M9mt7Y=;
        b=yamlmGn/gwMoWwN+dUWOb7VlvIN3pu0Ab6TcK09i1G7nREXE8Q4xa60AeqaAUIQSdm
         8I0vEpOuRrfSfdRglf77Tnu1MUuw0Z3g3WQvd7TihZC4R58tDp8eOzgjKkzVHxPDYcm1
         Vrd/PK/YiSMXZiLK0zpNH/BW/QeG1rr32apMwHKd2jghHxnO18dj+Jdy/iJOzH0mBjGx
         LTzfc+lSE0m8KH1DCL30iPXstZn1HUe+3hI/R3I+Jng03nuuFmxqiYTjPuMwx3zYiVxE
         Mna2vFAWT1NKiaEFbfYCsIzXoIS7L7/wujpxW9PIMkMkGFbN56tqNZXqYm/og1i4TB9w
         aRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ISydJTy7z/3XqMg+u/OmCEGmGMStHYjvJGUx8M9mt7Y=;
        b=CYYhjs3cxc66EvCqitkbtQv8LAyp8M7chC4l8MklOAlSFbyWPvpBCcaVUdQMRB4Gc/
         TU2n4cN95XFsWpNHAGEMrovhFtXRxvoGWup6sAkQk73tc3iTomgH5EQdH7Ob8t9PUjWB
         J8kk3AB6YrpCMGnzilwRhHaB4TFaD8RDqhv7JwNRefC/frZSj3w6e2RLYy1YwVfBBjs/
         b9REv9nqJwtdiar1sArkSUoqO05nEHBi5zokJEVN3TRHxJb6G3dOIF4luvV9PxjV6JAe
         1LqiGuaBWR3lhXy0Dhq9erl3/brN0LPxtGnDClEdLKU4y0Ijg3jndkPRBVndYQvCyMfV
         EVcw==
X-Gm-Message-State: ALyK8tIKz3UY9yrmMIqLjcEbCYxDUI23I8XGSXp0Op6eu0PY5Gk0qFEo6GZGBjO3eRWmdIyiXFBBBJGP+C8jtQ==
X-Received: by 10.107.159.147 with SMTP id i141mr16206557ioe.29.1469026124908;
 Wed, 20 Jul 2016 07:48:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 20 Jul 2016 07:48:14 -0700 (PDT)
In-Reply-To: <CAPp-VrZ1YjUyPYwgH2CD1fohU1R+uSizyVE6QwMXHcztvcQqSQ@mail.gmail.com>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net> <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
 <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org>
 <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com>
 <alpine.DEB.2.20.1607180905320.28832@virtualbox> <CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com>
 <alpine.DEB.2.20.1607181750470.3472@virtualbox> <CACsJy8Ba=c+-WV2TsY768_fTDO2KesS1b6BK7kdykNY6gkh=UQ@mail.gmail.com>
 <alpine.DEB.2.20.1607190910370.3472@virtualbox> <CACsJy8CSUu=AemQ-7uxth_2M=ko_KDGsdObwYdiE=L4OMKcVZw@mail.gmail.com>
 <alpine.DEB.2.02.1607191032270.25425@nftneq.ynat.uz> <CACsJy8Bvqt9r2dRtRfx1C-3Fp16z3SJ=hp0i7-itwFwfEfZwTw@mail.gmail.com>
 <alpine.DEB.2.02.1607191057170.25425@nftneq.ynat.uz> <CACsJy8D1RtwVF4ZtRHV2Z=huTqRBp8Du5GMZq9qxwXDZezBF2g@mail.gmail.com>
 <CAPp-VrZ1YjUyPYwgH2CD1fohU1R+uSizyVE6QwMXHcztvcQqSQ@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 20 Jul 2016 16:48:14 +0200
Message-ID: <CACsJy8CgDCROJURW9ERTRX1HwjwEDE5jXwFqg2P9+JhL2v_Knw@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	Herczeg Zsolt <zsolt94@gmail.com>
Cc:	David Lang <david@lang.hm>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 8:58 PM, Herczeg Zsolt <zsolt94@gmail.com> wrote:
> 2016-07-19 20:04 GMT+02:00 Duy Nguyen <pclouds@gmail.com>:
>> On Tue, Jul 19, 2016 at 7:59 PM, David Lang <david@lang.hm> wrote:
>>> On Tue, 19 Jul 2016, Duy Nguyen wrote:
>>>
>>>> On Tue, Jul 19, 2016 at 7:34 PM, David Lang <david@lang.hm> wrote:
>>>>>
>>>>> On Tue, 19 Jul 2016, Duy Nguyen wrote:
>>>>>
>>>>>> On Tue, Jul 19, 2016 at 9:18 AM, Johannes Schindelin
>>>>>> <Johannes.Schindelin@gmx.de> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> But we can recreate SHA-1 from the same content and verify GPG, right?
>>>>>>>> I know it's super expensive, but it feels safer to not carry SHA-1
>>>>>>>> around when it's not secure anymore (I recall something about
>>>>>>>> exploiting the weakest link when you have both sha1 and sha256 in the
>>>>>>>> object content). Rehashing would be done locally and is better
>>>>>>>> controlled.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> You could. But how would you determine whether to recreate the commit
>>>>>>> object from a SHA-1-ified version of the commit buffer? Fall back if
>>>>>>> the
>>>>>>> original did not match the signature?
>>>>>>
>>>>>>
>>>>>>
>>>>>> Any repo would have a cut point when they move to sha256 (or whatever
>>>>>> new hash), if we can record this somewhere (e.g. as a tag or a bunch
>>>>>> of tags, or some dummy commits to mark the heads of the repo) then we
>>>>>> only verify gpg signatures _in_ the repository before this point.
>>>>>
>>>>>
>>>>>
>>>>> remember that a repo doesn't have a single 'now', each branch has it's
>>>>> own
>>>>> head, and you can easily go back to prior points and branch off from
>>>>> there.
>>>>>
>>>>> Since timestamps in repos can't be trusted (different people's clocks may
>>>>> not be in sync), how would you define this cutoff point?
>>>>
>>>>
>>>> The set of all heads at the time the conversion happens (maybe plus
>>>> all the real tags). We can make an octopus merge commit to cover all
>>>> the heads, then it can be the reference point.
>>>
>>>
>>> so to make sure I'm understanding this, anything not reachable from that
>>> merge must be the new hash, correct? Including forks, merges, etc that
>>> happen from earlier points in the history.
>>
>> Yes everything except that merge and everything reachable from it, the
>> whole old clone, basically.
>
> It could work, but does it worth it?
>
> 1) If you use multihash, you should assume that anything with SHA1
> could be manipulated. That means you can "inject" something later to
> that "old clone" anyway.

No it's not multihash. The repo only uses sha256, but by substituting
it with sha1 using the same dag, we can recreate the exact same sha1
repo (up to the conversion point). This is mostly to avoid people
injecting something because _you_ generate the repo locally.

> 2) Even if the content is re-hashed, it's hard to understand for a
> user where the trust comes from. The user should decide weather he
> trust (or not) the person who signed that octopus breakpoint.
>
> Even without git you can achieve this security: Get the complete old
> repository, make a signed tarball of it. If anytime later you want to
> check that signatures, you can just use that tarball. I don't think
> it's worth the trouble to create a native method for something which
> is rare, and can be worked around easily. It's actually easier for a
> user to understand the "trust relation" when using this workaround.
>
> Referring to that signed-tarball approach, you may just as well drop
> all signature data on conversion... As long as you can look up the
> references to old hashes easily, I think it's usable enough.

It's more or less the signed-tarball approach in my view, except that
you recreate that tarball dynamically with your sha256 repo (so this
tarball is "signed" with sha256).
-- 
Duy
