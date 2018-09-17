Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9812D1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 09:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeIQOwF (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 10:52:05 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:52589 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeIQOwF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 10:52:05 -0400
Received: by mail-it0-f53.google.com with SMTP id h3-v6so10203184ita.2
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+cvLhg9NxVm8KHZZ0J82vBbMf+bwQngGf8Ni6iRs2uE=;
        b=fePkRclD85gxgbk8SSYw4tqWOOOCr2uKIPAGjehxlY55kne6BAGe0xvMa+axHJL4p4
         wb6iTADGnIDawgQ32lwbjUW+/vFNSlJrCp7kU618fRXSvsYqe8JcSIzXBWE0fB/Y/TxO
         0PBHdZpZ77/2kRAB5OknHyPCFzALkCLg3o7O6EB/1v0admLgGTJaiI+fWMePlyD3UODr
         bAXyY4/jTfjZFFOON6frHU4IrHLyMXOF0T9FBr1+GLTwGhhrMPlDAsR5c+4CSDHekPEX
         UfmzQ237ZgnqaYOXTWmd1Bi4vhI5JIZ/jMwHyulrWo6BbNTvZWQXcKv0MTjTWRS88YWL
         IanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+cvLhg9NxVm8KHZZ0J82vBbMf+bwQngGf8Ni6iRs2uE=;
        b=iQr5RrbsYqa2Km5uEHV/Ps0m5squ3N6EhUDGtdAxcTfPbt6hOfVjfXM28Dj7NXWZKV
         bLammstAZ4ztHY2Y67CAbX4QvAoYvGrj4kp0cDoSjxU2lzxfJcAdnTT7hfihX6N0HJN7
         +RqmuTwZh5dC3zh+qQpC+mKg4dGZYH8vQ4heWrysC3OrSNvB9Lru1qDES7hG6v56ZVrr
         pmxk1D7YfB9ZEtTJFYUXMXQqEfi5cUFtApzPDzYEJwxCIX++9RqVpF64/Y9+iOEExVIc
         GJi6q3C9i/LeSLSC2Ol3HYIrBQPNsGN0SFzf1ICGfsb/0WkhMqgikwpWxhoeuNo9bgKF
         9OJg==
X-Gm-Message-State: APzg51B7zDGJkIPwucnbdiraqZsDzQd4p/JJYEtjIEP1sGP1TzQ21Ttg
        wlX7RdncgPvow/qv7gQexFFWJT/hGh3BhZFkAuI=
X-Google-Smtp-Source: ANB0VdZl2hd52CPONAQTf8Q1OorFt1qfJWdKT7XDg4E1C9xCANFJqAELkllpxZCE0bgETML4Gvc7XfV37IROr3f3cCI=
X-Received: by 2002:a24:ecc4:: with SMTP id g187-v6mr11105143ith.145.1537176331802;
 Mon, 17 Sep 2018 02:25:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 02:25:31
 -0700 (PDT)
In-Reply-To: <20180917032101.GD22024@sigill.intra.peff.net>
References: <20170202022655.2jwvudhvo4hmueaw@sigill.intra.peff.net>
 <20180916101520.GC18517@gmail.com> <20180917032101.GD22024@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 17 Sep 2018 11:25:31 +0200
Message-ID: <CAP8UFD2cC7VMu7Zp9NaXj4x0BMBPZ5CJ6prwEv+s24SuNG=7JA@mail.gmail.com>
Subject: Re: Git trademark status and policy
To:     Jeff King <peff@peff.net>
Cc:     David Aguilar <davvid@gmail.com>, git <git@vger.kernel.org>,
        git@sfconservancy.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 5:21 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Sep 16, 2018 at 03:15:20AM -0700, David Aguilar wrote:

>> The "Git Cola" project[1][2] provides two fully-featured Git porcelains,
>> "git-cola" and "git-dag".  The DAG tool is never referred to as a
>> separate project, so shouldn't be a concern trademark wise.
>>
>> The project dates back to 2007, while the "Git Cola" name dates back to 2008.
>> FTR, the name "Cola" is also a shout-out to Linux (comp.os.linux.announce).

[...]

> An official answer will have to involve opinions and a vote from the
> whole PLC, but let me tell you what _I_ think:
>
>   - we mostly grandfathered good-faith names that predate the trademark,
>     even if we probably wouldn't grant them today. Searching my mail
>     archives, I see that git-cola did come up (along with a few others
>     like Gitolite and TortoiseGit). And we even ended up with written
>     agreements for some (at the very least GitLab and Gitolite), but I
>     think several (including git-cola) were never officially resolved in
>     anyway.
>
>   - In my opinion "Git Cola" is a lot less confusing than something like
>     "Git Cloner". Because there is little chance that somebody might say
>     "Ah, the official Cola of Git!". Whereas a generic operational term
>     like "Cloner" does introduce confusion (the "Git" is easily
>     interpreted as "Git presents X" and not "this is an X for using with
>     Git").
>
> So my opinion is that it is not something the project should be worried
> about. But like I said, do not take that as an official position at this
> point.

I agree with that. I think that old projects that have been known for
a very long time and that don't have a confusing name should
definitely be ok.

> (Also, to be clear, this is all _only_ about "Git Cola". The "git-cola"
> command is explicitly OK in the policy because that's how commands
> work).

I agree about "git-cola" though I wonder about "git-dag" as this is
another command used by the project that is more generic. For example
I could imagine that, if we wanted to provide a shortcut for `git log
--graph --decorate --oneline`, we might want to use `git dag`.

I guess we can still recommend to change it if possible, though we can
also acknowledge that, as our recommendation comes very late (too
late?), it is just a "weak" recommendation.

>> In my (biased) opinion, granting "Git LFS" was the right call.
>>
>> As long as the project is clearly a separate, but primarily Git-centric,
>> project then it seems like the right approach to allow "Git Foo" for
>> open source projects that contribute positively to the Git ecosystem.

I agree especially as "LFS" is not generic.

[...]

>> Lastly, due to time constraints, the Git Cola logo is a tweaked version
>> of the Git logo, which may convey a level of "officialness" that might
>> be unwanted.  We can work on a replacement if desired.
>>
>> Part of keeping the logo/visual identity close to core Git is because
>> the tool was always meant to be strongly tied to Git's unique features.
>> It's probably the same reason why the git-lfs branding uses similar
>> orange/red palettes -- to convey cohesiveness.  I would prefer to keep
>> the visual identity as-is (including the logo).
>>
>> Can we continue to use the derivative logo for the time being until a
>> replacement is produced?  Alternatively, can we keep the logo as-is?
>
> I don't think this is a question we've ever really considered before.
>
> I had to actually dig a little to find any use of the logo, which
> doesn't seem to be on most of your screenshots. :) For reference, this
> is the one I found:
>
>   https://github.com/git-cola/git-cola/blob/master/share/git-cola/icons/git-cola.svg

Thanks for digging and sending the link as I previously thought that
the logo was actually this:

https://git-cola.github.io/images/logo-top.png

which is on top of their homepage.

> I do think that's much more ambiguous than just the name when it comes
> to potentially confusing endorsement. If a random proprietary GUI client
> had a logo like that, I think we'd probably ask them to change it. But I
> have to admit that given the general good history of git-cola, the fact
> that it's open-source, and the fact that its main developer is also a
> helpful member of the Git development community, I'm less inclined to do
> so here.
>
> So in that sense, I don't have any problem saying "sure, let's make an
> explicit exception here". But I do wonder if we're better off trying to
> be as even and impartial as possible, so as not to create funny
> distortions (i.e., doing anything that endorses one over the other; I
> don't really use any graphical interface around Git, and I don't have an
> opinion on the technical qualities).
>
> I'd be curious to hear what other people in the community think.

My opinion on the logo is that they should probably make it clearer in
general what their visual identity is, as the 2 images on the above
links are quite different. And if they do that, yeah, it would be nice
if the logo that comes out is a bit less similar as the Git logo. In
general I think logos and visual identities are easier to change than
names.
