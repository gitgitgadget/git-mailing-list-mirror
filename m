Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C30DA207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 17:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755179AbcJLRGF (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 13:06:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62074 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754469AbcJLRGC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 13:06:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BCE8045620;
        Wed, 12 Oct 2016 13:02:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=fshWR+5ElNQnSb2Dovmp+V6qt4Y=; b=MONfEFG
        5MppFJHoxDpc70Sxvz149LCvCcmfJEz2D1xuehenMVaP+8/7S5kw+lN1L6rI/4wI
        n3FfiKgFuAjMuzUcpntJVNYK0khg+l47LioHdvDFyNFb71WcfK2pkUj+PYzOWXlC
        S4Ipi5zKCq3NJ58VDX41G9fexwmgv8Erw9Bo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=leZu4xP8cem72slSnWnQbNm7jP6PoQvNC
        S3gRSwSrTwxRHk5rUeh7pHf5oOyBvp6+dWLXMqUyDVet/JsnG/j1sKavQqb5vLTV
        6hYrQIh+W61fBA7SRj26XZEHZt+fGI5SZp9sNxK/XWfjnZ/1yAaFoZQM3BYtc+Y5
        BHHoniei20=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B4BCF4561F;
        Wed, 12 Oct 2016 13:02:09 -0400 (EDT)
Received: from pobox.com (unknown [128.172.245.7])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 47EB04561C;
        Wed, 12 Oct 2016 13:02:08 -0400 (EDT)
Received: by pobox.com (sSMTP sendmail emulation); Wed, 12 Oct 2016 13:02:07 -0400
Date:   Wed, 12 Oct 2016 13:02:07 -0400
From:   Joshua N Pritikin <jpritikin@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: interactive rebase should better highlight the not-applying
 commit
Message-ID: <20161012170207.lapdv5h5aws4k4pw@droplet>
References: <20161011190745.w2asu6eoromkrccu@droplet>
 <CAGZ79kZSQx7aOCgQ2dwzJeCLX-k-+x1SKabEBG7CktNfeXAbvg@mail.gmail.com>
 <20161012132740.dvyofl36qtualxgk@droplet>
 <alpine.DEB.2.20.1610121815160.197091@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610121815160.197091@virtualbox>
X-PGP-Key: http://people.virginia.edu/~jnp3bc/pubkey.asc
X-PGP-Fingerprint: 275A 6673 208B 1E36 CDEC  5188 281A 7053 6127 B3F7
X-PGP-ID: 0x6127B3F7
User-Agent: NeoMutt/ (1.7.0)
X-Pobox-Relay-ID: 9C0C49A2-909D-11E6-AD36-F99D12518317-03616332!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 06:24:37PM +0200, Johannes Schindelin wrote:
> No, a false belief in your own shortcomings, as you thought it would be
> easier to address your wishes for somebody else than you.

Ah, shucks, I guess I could jump in.

> But maybe I read it all wrong and you do want to make this happen
> yourself, and you simply want a little advice how to go about it?

Ugh, if you insist. You really know how to hold someone's feet to the 
fire, eh?

> > On Tue, Oct 11, 2016 at 02:25:19PM -0700, Stefan Beller wrote:
> > > On Tue, Oct 11, 2016 at 12:07 PM, Joshua N Pritikin <jpritikin@pobox.com> wrote:
> > > However IIUC currently rebase is completely rewritten/ported to C 
> > > where it is easier to add color support as we do have some color 
> > > support in there already.
> > 
> > Sounds great. Is there a beta release that I can try out?
> 
> There is no release as such, unless you count Git for Windows v2.10.0.

Nope, that doesn't count. ;-)

> But you can try the `interactive-rebase` branch of
> https://github.com/dscho/git; please note, though, that my main aim was to
> be as faithful as possible in the conversion (modulo speed, of course).

Hm OK

> > Sometimes I do a rebase to fix some tiny thing 10-15 commits from HEAD.
> > Maybe only 1 file is affected and there are no merge conflicts, but when
> > rebase reapplies all the commits, the timestamps of lots of unmodified
> > files change even though they are unmodified compared to before the
> > rebase.
> 
> Well, they *were* modified, right?

Were they? Isn't that just an artefact of the implementation?

> A workaround would be to create a new worktree using the awesome `git
> worktree` command, perform the rebase there (on an unnamed branch -- AKA
> "detached HEAD", no relation to Helloween), and then come back to the
> original worktree and reset --hard to the new revision. That reset would
> detect that there are actually no changes required to said files.

What would be the problem with doing this by default? Or could it be a 
configuration option that can be enabled?

-- 
Joshua N. Pritikin, Ph.D.
Virginia Institute for Psychiatric and Behavioral Genetics
Virginia Commonwealth University
PO Box 980126
800 E Leigh St, Biotech One, Suite 1-133
Richmond, VA 23219
http://people.virginia.edu/~jnp3bc
