Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6651F858
	for <e@80x24.org>; Wed,  3 Aug 2016 18:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758090AbcHCSbm (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 14:31:42 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36625 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757931AbcHCSbj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 14:31:39 -0400
Received: by mail-qk0-f171.google.com with SMTP id v123so78296515qkh.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 11:31:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bPY+5V7hBBHVMONrzyMvOVDuIfDqe4CzoMOQIURE5cw=;
        b=ZJuGh1g9rGXQHxx5YDWECw8XBJ/HPe2+uT8KpENZVa6Xd+iDcwoS1x+a1Q7f7d28q0
         IfVj07xmNKohNQgQiXxACMIhGzXD7c/m4TmtVr4/mlZWGrpoRnqYDrnM0oURQMDm2C3+
         5imD4odMVbvmn7jbJh9Ad2OTfBrI6v4X7kOIc6/DCssoWCovr1LnIk+g6yFMxdp2td0v
         ZvNBmHT+0gF8G/7SmiGGiyYcgAajAgFrIuoBA/wjLeJIh6no0GgFRe8kRqCKXnQnPAy/
         ySX7HYzq2NasbHc03vgk69KEYA4fZpAKP1cxBevIC77Y8kwkdmyow1h2dFowVAyDU+s+
         UV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bPY+5V7hBBHVMONrzyMvOVDuIfDqe4CzoMOQIURE5cw=;
        b=IskqeqMKugLO+75z2ZG0W6hUrnFxXSn4eZ/ld+bWIYgbjVkE0PjJwpdQxWqXqr3yAz
         0ceZVptkb6QlqY0pp7Vnn+gZri0jW5H+gxU5Jof0KjkN8+08hMIDntRFZtET9bbeBWe2
         aGVYE1mC8kM3SyJbhieHEklQL2j4DBXN++sFivBz3OkpzBelNtT4iBYz9vTStxUJCnp+
         Pfa+kwg8eW/prKsVFgLOfGjCzisXSuBTShep/Fv2y9Ue6HFdw7QjCEpWrqC1jCpemrz3
         FRxNaqlcFhpSQU9OnfhE+nvUBKlhravXOfIjuH0Ta9rR/0pcFstTyJSIpQ8BQ1bSmY0B
         JDtw==
X-Gm-Message-State: AEkoouvUAhgaFLqnEZZWMYVEDhcLgGdBQb7z3f2v9EBI5dFzKiRcNIod8O56jPvQe2eDTrUd
X-Received: by 10.55.5.5 with SMTP id 5mr1438782qkf.24.1470249098713;
        Wed, 03 Aug 2016 11:31:38 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-01.NATPOOL.NYU.EDU. [216.165.95.72])
        by smtp.gmail.com with ESMTPSA id p76sm4776144qkl.48.2016.08.03.11.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2016 11:31:38 -0700 (PDT)
Date:	Wed, 3 Aug 2016 14:31:37 -0400
From:	Santiago Torres <santiago@nyu.edu>
To:	Jeff King <peff@peff.net>
Cc:	Git <git@vger.kernel.org>
Subject: Re: [OT] USENIX paper on Git
Message-ID: <20160803183136.mck5fqo4jm7hj6i2@LykOS.localdomain>
References: <20160801224043.4qmf56pmv27riq4i@LykOS.localdomain>
 <20160803145830.uwssj4uhqfemhr4o@LykOS.localdomain>
 <20160803171124.yzm5xs67empuka7o@sigill.intra.peff.net>
 <20160803174459.knlmyx6txmggixzi@LykOS.localdomain>
 <20160803175854.vys3f7tpfhzeqzsu@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160803175854.vys3f7tpfhzeqzsu@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 01:58:54PM -0400, Jeff King wrote:
> On Wed, Aug 03, 2016 at 01:45:00PM -0400, Santiago Torres wrote:
> 
> > >   - if there is a chain of signatures, the attacker must follow the
> > >     chain, but they can always withhold links from the end. So imagine a
> > >     repository has held a sequence of signed states (A, B, C), that B
> > >     has a bug, C has the fix, and I am at A. An attacker can serve me B
> > >     and I cannot know without out-of-band information that it is not the
> > >     correct tip (because until C was created, it _was_ the correct tip).
> > 
> > I think we address this by using the "nonce bag". We basically force the
> > server to fork the user's history if it withholds changes from on group
> > to the other. By doing so, the user's nonce can't be added to any other
> > history. I don't think this is noticeable from start though.
> 
> OK, I think that is in the details I glossed over. ;)
> 
> If you are effectively preventing the server from showing different
> states to different people, then at least that lets the "main"
> developers notice problems (because at least one of them already saw "C"
> because they wrote it).

yeah, that was one of our assumptions. I think it's unrealistic to think
that people do not coordinate over mailing lists or other means.

> 
> > > I think git in general is quite weak in automatic tooling for
> > > verifications. There are room for signatures in the data format and
> > > tools for checking that the bytes haven't been touched, but there's
> > > almost nothing to tell you that signatures make any sense, tools for
> > > handling trust, etc.
> > 
> > Yes, from our previous interactions, it seems that git's philosophy
> > focuses on providing the right information to users/tools and let those
> > tools make the call of whether something is fishy. I don't think this is
> > necessarily bad.
> 
> I think it's half philosophy (git strives for flexibility, and so aims
> to provide low-level tooling that you can build on), and half that
> nobody has bothered to implement a sane set of automatic checks.
> 
> There's definitely some low-hanging fruit there. I think we've discussed
> things like checking that verifying refs/tags/v1.0.0 actually gets you a
> tag that says "v1.0.0" in it. But I'd love to see a framework either
> built into or on top of git that would implement sensible policies, and
> make out-of-the-box verification easy to do. Then people might actually
> use it. :)

Yeah, that's one of the long-term goals with my PhD, but it's still on
the early stages, and I don't have much done yet in that field. I can of
course share this around once it's more mature if that's ok with people
in here :)

> 
> > > I think your solution also had some mechanisms for adding trusted keys
> > > as part of the hash chain. I'm not convinced that's something that
> > > should be part of git's solution in particular, and not an out-of-band
> > > thing handled as part of the PKI. Because it's really a group key
> > > management problem, and applies to anything you might sign.
> > 
> > I see. What about, for example, having an official "overlay" on git for
> > signing and verification of a repository? (e.g., similar to what
> > monotone does). I see that other VCS's have a plugin mechanism, and they
> > host official plugins.
> 
> In general, if something is more general than git, I'd like to see a
> general tool address it, and then add support to git to make use of the
> tool.
> 
> For group key management, I specifically was wondering if you could do
> something like:
> 
>   - start with some seed GPG keys for the project
> 
>   - existing keys can sign or revoke certificates to add or remove other
>     keys to/from the project; you could even require a threshold of
>     signatures, etc.
> 
>   - those keys could be used for signing git pushes, but also for other
>     things, like signing tarballs, used as encryption keys for sending
>     for-developers-eyes-only security reports, etc
> 
>     You'd want a tool that asks not just "is this signed" but "is this
>     signed _by a key that is valid for this project_".

Yep and also "is this signed thing the thing I should be looking at?"

> 
> And then git support would just consist of feeding signatures to
> "gpg-group --project=..." instead of "gpg". Management of the group
> would be out-of-band from git, which is in some ways good and in some
> ways bad.

yep, what I like from in-band solution is that it is easy to piggyback
on existing git mechanisms (e.g., git ref backend). 

> 
> I think a naive implementation would be pretty easy, but I've glossed
> over all of the chaining properties we've discussed. So whatever
> mechanism you use to receive updates to the key-group would have all the
> same problems (e.g., withholding revocations of compromised keys). It's
> still orders of magnitude ahead of what's currently happening
> day-to-day. :)

yeah, a naive implementation may be easy, but there are little details
to consider when trying to get something more robust. I don't see why
sketching something would be a bad idea though.

Thanks all for all your feedback! I'll keep this mail archived around to
revisit it in the future; all of this seems really interesting/helpful. 

-Santiago.
