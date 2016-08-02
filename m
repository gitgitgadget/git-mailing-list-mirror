Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DB991F858
	for <e@80x24.org>; Tue,  2 Aug 2016 11:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbcHBLCd (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 07:02:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:64742 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514AbcHBLCb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 07:02:31 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LskKv-1b6dTk1hDV-012Fq2; Tue, 02 Aug 2016 12:43:05
 +0200
Date:	Tue, 2 Aug 2016 12:30:36 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
	Kevin Willford <kewillf@microsoft.com>
Subject: Re: [[PATCH v2] 1/4] patch-ids: stop using a hand-rolled hashmap
 implementation
In-Reply-To: <xmqqy44gi7bp.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608021013010.79248@virtualbox>
References: <20160729161920.3792-1-kcwillford@gmail.com> <20160729161920.3792-2-kcwillford@gmail.com> <xmqqoa5gmas6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607301056120.11824@virtualbox> <xmqqy44gi7bp.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/YVGntsSX1VxYhUAmp5/1NnFOgNFvFrHZgjinQlAjS7elOQ/TE9
 /GUHBv4YjX8BwJ82gvs3v3XchI3LStVlNFNAigD+Zdhq5lEP4iYBS92qG4B5NkK9yZI3g/f
 1rZVyscAMkFrh27h4CP6VsQCRbV+8lx/4bWpviQeO8ndFAWfKUTyOIres5RxgiyfzgHKgOt
 sJUsNwySBzKDcw60SDZ+A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:gJkGlFxcjV4=:W/78mnfU67OfufYOdpFymP
 KyFZE/DiBGqLJIrbuogxMk7obBbSk+XRbp65v20sK8C0Ut2TMO9mYOsxajfV3BtkMJ0NkkBuY
 mjopNDQ+WOo39zjq+ULiFYOdPq9sL2eXKovU1//w7E7MKgiuiQtemGImtjjXUknMNyhckImq2
 r3IpRlpz9GhZhqT8qfZ2IpSG9MiKJfg79uEupjzYjNh6iTacymwH0mKqRjs5UWtvIUO0lugOd
 +IF/dvoR411SXtTySfrgvsJcSA++HsVJ2Wz4CmEdZuyNUefvpL3exH669cV3yoq0xTG4l9YUt
 b5agRtOOUSw5u/z6lJE70svIYo4cL8sjAQbBULmChrtoVy5DY/N1wV2vrg6AuRvnaMSBYiYIs
 m+iWvZ0anOg94O3garpFJEfmgMR6WGnSXilNyRTJ9Zy9ZJJoR2jOV1iC2+c+0JB7RSPein8bk
 lT5wXhOrV3lMSQMSAArOggI1eqYzU+cKG6+pKkhFDe1JH+ApavF2rnE/Wl9LlveDCP/7tZZ/v
 obYB3hqUzEbcgdLwmY6Won1QvgR4X6GGRnAyyDVHrnVj1w90tdwLJ005FbdtcwHfe8vJ/uZBU
 Llkv5viJ+mqq4dXYMLBY8Xh7H0a2QOzVOUtvayAszyVKpqvFouHOpRA9yWA5EvJjW44TCAlzP
 DpWKQ+/blCCeT6mY7WPF28qUrSzxQC3lAQNrcPr6ceK8Fal9cYIk0ysOr19uuzLpn2UTgOePY
 yWPS7czYZVlG1OKHCP3g01gmDS0iVz3cVW+nt3zHmM5+oqhPeGuNwrQP/1S3FC0SpMRmB9EIl
 oQKa1WX
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 1 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > It would be a serious bug if hashmap_entry_init() played games with
> > references, given its signature (that this function does not have any
> > access to the hashmap structure, only to the entry itself):
> >
> > 	void hashmap_entry_init(void *entry, unsigned int hash)
> 
> I do not think we are on the same page.  The "reference to other
> resource" I wondered was inside the hashmap_entry structure, IOW,
> "the entry itself".

Oh, I see now.

> Which is declared to be opaque to the API users,

Actually, not really. We cannot do that in C: we need to define the struct
in hashmap.h so that its size is known to the users.

> so whoever defined that API cannot blame me for not checking its
> definition to see that it only has "unsigned int hash" and no allocated
> memory or open file descriptor in it that needs freeing.

That is the reason, I guess, why we have the documentation in
Documentation/technical/api-hashmap.txt: it would have to talk about your
hypothetical hashmap_entry_clear() (which would better be named
*_release() BTW, unless I misunderstood what you want a hypothetical
future version of that function to do).

And quite frankly, unless we *have* to, I would rather try to avoid
introducing that function as much as possible, as it would make using the
hashmap API even more finicky than it already is.

> By the way, the first parameter of the function being "void *" is
> merely to help lazy API users, who have their own structure that
> embeds the hashmap_entry as its first element, as API documentation
> tells them to do, e.g.
> 
> 	struct foo {
>         	struct hashmap_entry e;
>                 ... other "foo" specific fields come here ...
> 	} foo;
> 
> and because of the lazy "void *", they do not have to do this:
> 
> 	hashmap_entry_init(&foo->e, ...);
> 
> which would be required if the first parameter were "struct
> hashmap_entry *", but they can just do this:
> 
> 	hashmap_entry_init(&foo, ...);

Yes, I know that. It is the common way to simulate subclassing in C, for
lack of a more compile-safe construct.

> I have a slight preference to avoid the lazy "void *", but that is
> an unrelated tangent.

Oh, we are already safely in Unrelated Tangent Land for a while, I would
think. Nothing of what we are discussing in this thread has anything to do
with Kevin's patch series, which is about trying to use resources more
sensibly when using the revision machinery's --cherry-pick option.

And since we are already there, I'll offer an opinion in favor of `void
*`: doing the &foo->e dance could quite possibly suggest that `e` is a
field just like any other field (and does not necessarily *need* to be the
first).

But again, this has nothing to do with the patch series we are discussing
here.

> >> The fact that hashmap_entry_init() is there but there is no
> >> corresponding hashmap_entry_clear() hints that there is nothing to be
> >> worried about and I can see from the implementation of
> >> hashmap_entry_init() that no extra resource is held inside, but an
> >> API user should not have to guess.  We may want to do one of the two
> >> things:
> >> 
> >>  * document that an embedded hashmap_entry does not hold any
> >>    resource that need to be released and it is safe to free the user
> >>    structure that embeds one; or
> >> 
> >>  * implement hashmap_entry_clear() that currently is a no-op.
> >
> > Urgh. The only reason we have hashmap_entry_init() is that we *may* want
> > to extend `struct hashmap_entry` at some point. That is *already*
> > over-engineered because that point in time seems quite unlikely to arrive,
> > like, ever.
> 
> I am saying that an uneven over-enginnering is bad.

Hmm. I guess that the _init() function could be replaced by an _INIT macro
a la STRBUF_INIT. Not sure it is really worth the effort, though.

Ciao,
Dscho
