Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE481C3DA7A
	for <git@archiver.kernel.org>; Mon,  2 Jan 2023 03:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjABDiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Jan 2023 22:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjABDiS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2023 22:38:18 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A702199
        for <git@vger.kernel.org>; Sun,  1 Jan 2023 19:38:16 -0800 (PST)
Received: from letrec.thunk.org (host-67-21-23-146.mtnsat.com [67.21.23.146] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3023bk0q010559
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 1 Jan 2023 22:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1672630677; bh=hJgt3cniDblWTGbdG6TKiMOvP8E5zY31/KXVzE3wu4o=;
        h=Date:From:To:Subject:References:In-Reply-To;
        b=mzbC9wAoqcAE7E8EUgDruBuAaCPkWesJCh5pGPYL91obDqdfSleTfem9z7wQZv8j8
         tge2iXFdvEFugeYpkDkMPiIsFDwKOZqDh70lRbTJX1ri+/IVVghZboJTBBrq0bvL4r
         T4UAjWawYzD46wWeFNCthkthgfrAmPjtA2/K3Y5FNgwbDrrAFxE6F0Cz6qYlP+MnpB
         NSNcVrTiFy2aI9xWfYlvYeyqkjY0u8m2icoH0+uSiqa9aunKk8bae4nDmQOkEQh/SD
         so5WNl+SSJX+9EBq6yiMerrXZuIiIvNMHI+RuoL0PQvX8bizG1BnEgjcbdWbcyQvJc
         FEozX3U3Ge9kg==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 842D88C03BC; Sun,  1 Jan 2023 22:37:43 -0500 (EST)
Date:   Sun, 1 Jan 2023 22:37:43 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Filip Lipien <aaa@164.ooo>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request to remove Junio C Hamano as the Git Maintainer
Message-ID: <Y7JRh6WZ1YZ2AkKJ@mit.edu>
References: <7hfRSnKTRnT4uJh5Pok8U8gfLm_NXzCS6w_7_Rc9OH3a9Lv8hpjySZqxDglBFC-fTOdZHi-ODCihiEHlQD9nIhUmld5jYvRx_JvB0z2IAL0=@164.ooo>
 <Y7H2sN1fEZ8pi6xY@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7H2sN1fEZ8pi6xY@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 01, 2023 at 09:10:08PM +0000, brian m. carlson wrote:
> Instead, this is an open-source project, and it's my impression that
> Junio spends most of his time shepherding other people's patches and
> making sure that the project and contributions are in a good state.  He
> sends relatively few patches himself, and while he might make a
> suggestion on what he'd like to see out of a series or project, he
> doesn't really tell people what to do because people don't have to
> do what he says.

Another way of putting this is that git is perfectly usable for
intermediate to expert developers.  As a long-time Linux
developer/maintainer, my opinion is that git developer experience is
just *fine*.  I like how powerful it it is; I like how it improves my
productivity; and I don't have any problems using git.

One of the ways this can be seen is that we haven't see a huge amount
of contributions trying to make git more novice-firendly.  The fact
that we haven't seen those contributions is a strong indication that
it's not really a problem for git development community.  And given
that git developers are humans, there is very clearly a set of humans
who find their experience of git sufficiently convivial that it's not
worth their time to make it better.

So the claim that git has a poor developer experience is not accurate.
It may be that the experience for novice / beginner developers could
be improved, sure.  Unfortunately for novice / beginner developers,
they generally do not have the expertise to contribute those sorts of
patches to git.  They can send petulant messages to the git mailing
list, not understanding the difference between an open source
maintainer and a "product manager", but that's not going to be
effective.

And by the time that they do become experienced git developers, they
understand why things are the way things are, and very often, they
will find better things to do with their time.  For those that do
become experienced git contributors and who continue to be passionate
about making git easier for novice users, the challenge is how to make
git more friendly to novices while not compromising backwards
compatibilty or the power that expert users are happily using every
day.

And of course, if they are contributing to git on company time, their
company has to be willing invest their engineers' times on making git
easier for novices, which implies that most companies will want a
valid business case for making git more friendly more users for
developers like (presumably), Filip.  And if we aren't seeing those
contributions from corporately funded git developers, perhaps that is
a strong suggestion that the business case simply doesn't exist.

						- Ted

