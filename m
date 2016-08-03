Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AEC01F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 17:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbcHCRpZ (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 13:45:25 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35234 "EHLO
	mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbcHCRpX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 13:45:23 -0400
Received: by mail-qt0-f176.google.com with SMTP id x25so147635329qtx.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 10:45:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IyKj9ubC6PYO7KKQEsU1Gg5mrxgGTJyAx+mWgBwpTn4=;
        b=O1FZwAkPU9pYFET5PbSAmM3yzVHo0px9HEJ5fq1TX3T4wLZeULJ3NzWU9AkNneD/c/
         Kmx2BCyKro5zcKQjUbttDgL17tTixEPGCIzFuQJ0Rp9GiMee798IvbHpdmz8//sxdb/+
         Cv/WUna0A6zOpFqMhPolNPXel3TZGjDtCLB4TsREsBKN4grIfcbhg+SymFpWBVIskA12
         260BMFofiwwxTn7t2dKfto8pfV4FOTTSw7XsZlfZXCVNGhiiCnzlKFhQcyXpNeeu2h1A
         lwHRVdvCIfg8Dwsin4s+ASz/INInzaqCxGru4pvg60z2Hl/3/4fy9kkKdxhCnHLcKmBv
         75Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IyKj9ubC6PYO7KKQEsU1Gg5mrxgGTJyAx+mWgBwpTn4=;
        b=NLNBD4u64Y16XhFaGBWiYKC8szMi6NpFi/kSOqQGZH8Qpz4mj9BMuiP307Pc1uCgK0
         odLgygr7j4KR61XLTtBULD4TVDGiFI6VcoWl42K7pXGvUNs3XS6kyfsy0nipC8JFdAUT
         IqogjS76VcXzFAVOXONikdKpk2aKK0n+Y/NFOzDTfsWMoGFZCvGF2x1NRKk11ewtRCNR
         kzSCbeCesuym4/exntfvqyYDD4ccv7Dy5wPfy6avG4B78J+HqemsQBCOPoGdcAlczXfi
         rEvVZohnGuO1Ima+rRXpYfHFrbhPihYv3WKo1dxVy3Ir8PwOk0SgW8J2hlY7SQ3jGYc7
         RNOA==
X-Gm-Message-State: AEkoouvHFKZT5kPOIiQXaaOlnQnuHNBGFlW7lxAMHLQY1Vo34K1JUsoxG+QPCKo1rjczbMXs
X-Received: by 10.200.55.215 with SMTP id e23mr1374830qtc.20.1470246301359;
        Wed, 03 Aug 2016 10:45:01 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-01.NATPOOL.NYU.EDU. [216.165.95.72])
        by smtp.gmail.com with ESMTPSA id l89sm4671290qte.41.2016.08.03.10.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2016 10:45:00 -0700 (PDT)
Date:	Wed, 3 Aug 2016 13:45:00 -0400
From:	Santiago Torres <santiago@nyu.edu>
To:	Jeff King <peff@peff.net>
Cc:	Git <git@vger.kernel.org>
Subject: Re: [OT] USENIX paper on Git
Message-ID: <20160803174459.knlmyx6txmggixzi@LykOS.localdomain>
References: <20160801224043.4qmf56pmv27riq4i@LykOS.localdomain>
 <20160803145830.uwssj4uhqfemhr4o@LykOS.localdomain>
 <20160803171124.yzm5xs67empuka7o@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160803171124.yzm5xs67empuka7o@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello,

> Here are my comments on the work itself. They're critical, but meant in
> a friendly way. :)
> 

Thanks! If anything, the community here has been incredibly helpful in
helping me understand everything.

> As far as the attack goes, I'm still not convinced this is all that
> _interesting_ an attack in the real world. What it boils down to is: the
> ref state is not signed or authenticated in any way, so somebody who can
> compromise your server repo or do a MiTM can lie about where the refs
> are (even if individual commits are signed).

Yup, that's pretty much it. I do agree that some of these attacks feel
tangential in the way it should be used. I also agree that, if git is
used how the Linux kernel or git.git does, then these attacks are rather
hard to pull off. 

> 
> So if you want to treat Git as a cryptographic end-to-end distribution
> mechanism, then no, it fails horribly at that. But the state of the art
> in source code distribution, no matter which system you use, is much
> less advanced than that. People download tarballs, even ones with GPG
> signatures, all the time without verifying their contents. Most packages
> distribute a sha1sum or similar (sometimes even gpg-signed), but quite
> often the source of authority is questionable.

Yes, this happens an awful lot of times. We did some work with python's
pypi last year, and we found out that less than 1% of people actually
downloaded the gpg signature for the package they are retrieving[1].

> 
> For example, consider somebody downloading a new package for the first
> time. They don't know the author in any out-of-band way, so any
> signatures are likely meaningless. They _might_ be depending on the
> source domain for some security (and using some hierarchical PKI like
> TLS+x.509 to be sure they're talking to that domain), but in your threat
> model, even well-known hosts like FSF could be compromised internally.
> 
> So yes, I think the current state of affairs (especially open-source) is
> that people download and run possibly-compromised code all the time. But
> I'm not sure that lack of tool support is really the limiting factor. Or
> that it has turned out to be all that big a problem in practice.

I couldn't agree more. I feel that OSS is slowly moving towards a more
cryptographically robust, trust-based way of doing things, which I find
pleasing.

> 
> Anyway. As far as your solution goes, I'll admit I skimmed over the
> details, but it looks like basically a sequence of signatures producing
> a chain of state (so the tip state is signed, but you can also make sure
> the chain connects from your current state to what the server claims is
> the new tip state, and not a replay of some old state). Please correct
> me if that's not accurate. :)

Yeah, this sounds about right.

> 
> Without having thought too hard about it, it seems like you could do the
> same thing with push certs, as they have both a "before" and "after" for
> each ref. So if in addition to fetching the refs from a server, I fetch
> all of the push certs, I should be able to walk the chain of push certs
> from the one at my current state, to the one at the tip state, making
> sure that each one builds on the last.

Yeah, when we looked at push certs I actually thought that "chaining" the
certs could achieve a similar effect to the solution I described.

> 
> There are two cases that I don't think that handles, but that I also
> don't see are handled in your solution:
> 
>   - if I am cloning for the first time, I have no "current" state to
>     base the chain from. An attacker could serve me any old signed ref
>     state, and I have no way to know that it's old (except perhaps by
>     seeing the wall-clock timestamp and comparing it to my clock; this
>     isn't a proof but may be cause for suspicion if it's too old)

Hmm, I didn't think about it. Let me jot it down. This sounds
interesting. I recall you mentioning metadata expiration back then.

> 
>   - if there is a chain of signatures, the attacker must follow the
>     chain, but they can always withhold links from the end. So imagine a
>     repository has held a sequence of signed states (A, B, C), that B
>     has a bug, C has the fix, and I am at A. An attacker can serve me B
>     and I cannot know without out-of-band information that it is not the
>     correct tip (because until C was created, it _was_ the correct tip).

I think we address this by using the "nonce bag". We basically force the
server to fork the user's history if it withholds changes from on group
to the other. By doing so, the user's nonce can't be added to any other
history. I don't think this is noticeable from start though.

> 
>     I think this is actually a generalization of the cloning issue
>     (where state "A" is simply "I have no existing state yet").
> 
> So it seems like there is room for better tooling around push-certs
> (e.g., to fetch and verify the chaining automatically). 

Yeah, I think that in-band cert distribution and automatic validation
may be a desirable feature, but there may be reasons as to why this is
not appealing. (I already have some in mind).

> I think git in general is quite weak in automatic tooling for
> verifications. There are room for signatures in the data format and
> tools for checking that the bytes haven't been touched, but there's
> almost nothing to tell you that signatures make any sense, tools for
> handling trust, etc.

Yes, from our previous interactions, it seems that git's philosophy
focuses on providing the right information to users/tools and let those
tools make the call of whether something is fishy. I don't think this is
necessarily bad.

> 
> I think your solution also had some mechanisms for adding trusted keys
> as part of the hash chain. I'm not convinced that's something that
> should be part of git's solution in particular, and not an out-of-band
> thing handled as part of the PKI. Because it's really a group key
> management problem, and applies to anything you might sign.

I see. What about, for example, having an official "overlay" on git for
signing and verification of a repository? (e.g., similar to what
monotone does). I see that other VCS's have a plugin mechanism, and they
host official plugins.

Thanks a lot!
-Santiago.

[1] https://isis.poly.edu/~jcappos/papers/kuppusamy_nsdi_16.pdf
