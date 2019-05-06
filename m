Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95D811F45F
	for <e@80x24.org>; Mon,  6 May 2019 15:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfEFPi0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 11:38:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32934 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfEFPi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 11:38:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id f23so11515881ljc.0
        for <git@vger.kernel.org>; Mon, 06 May 2019 08:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=YXs6oRrPlqy9hZ4jnnj6Vbn/B1+GO89uhoT7ECpJShw=;
        b=XYL1OMLU70suvC2RI8qudPh91HgESVHmEbowHE1RSi36aEa5/7CG47SfxUM2FDyzpE
         RTy7VcwhPgImSJB1NzWkOlNhrwqeHsyYxz97uOmZdPQny8PfW9mTr7x+COThU1Qs4u3Y
         EpUnUWEEclxr0gk2dGbatbCOYGLfn32ZnxeR4lIy1mtClj4K34hcU//KaD56/N4QA8XD
         LH/VgnnM2y6P7KfFQ2wYYWYeZ+cKX+/kQ0s3v0eZaukzcvKFBnn3c9CU8Jcaj9ZdgRDX
         ghwLOm0Vn2xtk6L6ZxOo4OKKJrOQZQlz39JXDAixMQywuVs+GlYpgIe0/yB174RHBVPf
         4SzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=YXs6oRrPlqy9hZ4jnnj6Vbn/B1+GO89uhoT7ECpJShw=;
        b=Iq9J4VZ+21qDO9z/f9IcyEh89w3kWzRsOBfAjfWv8qPrVCUBCTBzvxY/5k5vw2Wu8t
         fV+an8jiaW6nMcfvs6kkse9odbV4dWupwFEUH2gg34lFZKN9CqjlAsHDaLYN1Esp/6Vz
         nNmfAQ53TsZiiV7Bf76wjNR/TdRmm/8RZpXvTzYRZYl9bdSJu3smwmzfqykFjVBd1MIa
         LRDYEUzs5nNSdehMTKetWKl+YA40h1zCbU142j3S6HqiTXmD5+yYXV5WcYHgBEhYUTSm
         WMaaIIIjY3SBZKdkm6tIDDIWXpapfpqK1eHFCXyVVnPxdjdn7bu+DKqv7lJ+YDR/xJrX
         JF/Q==
X-Gm-Message-State: APjAAAV3wv8r23VVgqIdqvnMTA8RG17plo3szrkP/Z4uUpBepOJHY8uJ
        Lz9hUlQBNSe75uIYhmmlo24Y7RSNj7Bs3/U9anWoGQ==
X-Google-Smtp-Source: APXvYqzHqNVFuxgQnaGh6Y1byVXpUB5Vo+cdabaxmbS5NsvrHXEeJWD+6ike003IRyx7nWOkAnqv+P6uN7h86OBgNtU=
X-Received: by 2002:a2e:9e47:: with SMTP id g7mr13693004ljk.48.1557157104461;
 Mon, 06 May 2019 08:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499BEHd79zL76um2oB4YMdScM2icrMXstg1g=xwdBqk43EQ@mail.gmail.com>
 <20190503191231.GA5426@esm>
In-Reply-To: <20190503191231.GA5426@esm>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Mon, 6 May 2019 10:38:12 -0500
X-Google-Sender-Auth: jCdnvDm1vCKNbvLfWfkZYsseCfg
Message-ID: <CAHd499CUOnFVkNGEG-MmG5OsUPpmWHET2X1j1fjNuGUkELf-5w@mail.gmail.com>
Subject: Re: Merge commit diff results are confusing and inconsistent
To:     =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I feel like you got hung up too much on exact wording of what I was
trying to describe. I do apologize I don't have the background to
explain things 100% accurately, especially at a low level. My
explanations are mostly intended to be as a user, based on what is
observable, and based on intent. I'll clarify in the quotes below...

On Fri, May 3, 2019 at 2:12 PM Eckhard Maa=C3=9F
<eckhard.s.maass@googlemail.com> wrote:
> Hold on. Basically, there is no such thing as "committed directly" for a
> merge. You only have differences of the commit to its parents. What you
> aim for are changes that you cannot find in either preimage - and this
> can be observed best with the --cc option. Maybe also interesting would
> be -c for showing a comined diff and -m for showing diffs to parents
> after one another.

"Committed directly" here means that I made some changes, none of
which is part of a parent commit. Since no additional commits were
made following the merge, I assume that within the merge commit is
some type of diff. If I perform a merge, make some changes, and amend
those changes into the merge, in mind they ARE contained in that merge
commit. The underlying machinery doesn't matter here: This is the
observable state to the user.

Maybe the machinery, which I have no knowledge of or transparency
into, is important because it is affecting the behavior I'm seeing
when I do the diffs? Not sure...

> There shouldn't be "just the diff of <commit>" - you always have to tell
> where to diff it too, intrinsically Git does not save patches, but the
> whole content, after all.

I do understand this. But again, I'm not trying to be super technical
here. In plain english, all I'm trying to say is that I want to see
the changes that 1 commit introduces into the code base. So when it
comes to communicating the end result I want, I talk about it in terms
of 1 commit (the merge commit). The means to get that output is part
of my question and overall confusion. But as a baseline, I want to
clarify that I do understand a range is required input for the diff
command. In the case of merge commits, the way you specify the ranges
has many forms so I'm not sure based on the results I see, which one
is correct or what they all mean.

> Somebody else might know better why the diff actually produced the
> results you were looking for. I admit it is puzzling to me - I would
> have expected to error it out on the output of git rev-parse as there
> are three items.

Actually I can't think of any other command that can show me what
revision ranges translate to in "raw" commits. To me the raw forms are
always <sha1> and ^<sha1>, repeated as many times and in as many
orders necessary. Don't all of the vanity revision specifications
ultimately boil down to "from this parent" and "not from this parent"?
