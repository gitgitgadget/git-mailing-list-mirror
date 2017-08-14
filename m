Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0686620899
	for <e@80x24.org>; Mon, 14 Aug 2017 20:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbdHNUcx (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 16:32:53 -0400
Received: from mout.web.de ([212.227.15.14]:58567 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752297AbdHNUcw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 16:32:52 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LcPRO-1dHgSA1FtW-00jv8I; Mon, 14
 Aug 2017 22:32:36 +0200
Date:   Mon, 14 Aug 2017 22:32:35 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/9] Convert pack-objects to size_t
Message-ID: <20170814203235.GA4293@tor.lan>
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
 <87fc215e-b860-10f5-5c5e-60652502fae8@ramsayjones.plus.com>
 <20170813183026.GC31079@mail.zuhause>
 <627042be-ab86-e9da-8c4e-5aac3278f5c6@ramsayjones.plus.com>
 <xmqqtw1bw1v6.fsf@gitster.mtv.corp.google.com>
 <xmqqfucuw00a.fsf@gitster.mtv.corp.google.com>
 <c49628e0-6a57-34d6-6727-f8111b80cbab@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c49628e0-6a57-34d6-6727-f8111b80cbab@ramsayjones.plus.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:mWHfyxgWM9TxoVZVFjy0nbDwl5onHU7a4uqBhFdDfiY/2EH0/YN
 b7MaJ0HIAHi3AsO1PlIr5roJwFLwgUVt+PEbIOnKe0ZPfssSwSs77nt+NnWFSASbA597YlG
 eJzupk1siVtw6A3A7ABp0jkHOAfOYkrC0BVe/Yi0xEDSZfd1bSsWvRfXQeVPXtQJGLV5sqm
 5/WPyPFENYOCvuV4jGmiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fson5g6KwsE=:7Z4K5vS6dyNsqdJdBSR98q
 Af8qUf6pZHufCafZHqI8z3qU7/FeicLV+zCLWHlZF+TdSQPym6Q3ThabFSIRwztgcHywefJ6E
 ytC3N5Knev2r6G8mUgvYit/CFaZm8i5TIH9r91rjKGMK1MC1/jV/gNzKM4jN6x6bPWDvLz8tV
 uyLXkP8dMPue+clSFwM6TFoes3J/Njn5f4qi0jl15uhTKyn0aCl3TCKZUNjPnvtDFOspSi5GT
 UBFIL9Zly2ol2vv4PPebCD2GzCn4b/oCSMSLTwRRTWl5l4Z9VxdruFklkKo33HDpA+mu8VW+D
 7VZ6wCDyOTWoCyaIW5Q8N3syyvEdGKtmMnrKJMQml0eMvGjoCkwstowbaXdXpc0T4Papzlf+a
 nuCoTXavuQL9lhFELmMAUP7cgjTigfbaG8dvojc18odDG7aGAQaFJgCU5o0O9R3FY6o5fjfJH
 BZsirD+ZpzQStaiPZ9YOhWLJM5ADTQLNqBWV1uBE4x1UGpMsrWtzit2uSRNxlQcmiJSqP4IDR
 ZlAokZUQLGFXyaP83AzNNQvSgrtCy69iklSIG1nNkagFNfOd2mDqHaJSQ6liFeEOft4a4vpM6
 6dQ4dgyuROUb+NrXXsuqkxL428rGpl5LklWvMU1qd4ycahOqMBWqJreTnjPCxPE63vqNcKWzE
 sVKGL+Hid8eYKva1eoRg+oCa9BmpNsuptB/BSSmMqx9NfcZBO2hDs1mTK7KImWMGy/2nW34dL
 ZNCOuu4HT0kr/du+n0A6/4Q8NxaQl1BsmuuvyLAH61mKESJuHpG1edI+qLjh5xPenk0kr9KmO
 46HtinEZZdv/jx1Xk85NannfluESw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 08:31:50PM +0100, Ramsay Jones wrote:
> 
> 
> On 14/08/17 18:08, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> >> One interesting question is which of these two types we should use
> >> for the size of objects Git uses.  
> >>
> >> Most of the "interesting" operations done by Git require that the
> >> thing is in core as a whole before we can do anything (e.g. compare
> >> two such things to produce delta, have one in core and apply patch),
> >> so it is tempting that we deal with size_t, but at the lowest level
> >> to serve as a SCM, i.e. recording the state of a file at each
> >> version, we actually should be able to exceed the in-core
> >> limit---both "git add" of a huge file whose contents would not fit
> >> in-core and "git checkout" of a huge blob whose inflated contents
> >> would not fit in-core should (in theory, modulo bugs) be able to
> >> exercise the streaming interface to handle such case without holding
> >> everything in-core at once.  So from that point of view, even size_t
> >> may not be the "correct" type to use.
> > 
> > A few additions to the above observations.
> > 
> >  - We have varint that encodes how far the location from a delta
> >    representation of an object to its base object in the packfile.
> >    Both encoding and decoding sides in the current code use off_t to
> >    represent this offset, so we can already reference an object that
> >    is far in the same packfile as a base.
> > 
> >  - I think it is OK in practice to limit the size of individual
> >    objects to size_t (i.e. on 32-bit arch, you cannot interact with
> >    a repository with an object whose size exceeds 4GB).  Using off_t
> >    would allow occasional ultra-huge objects that can only be added
> >    and checked in via the streaming API on such a platform, but I
> >    suspect that it may become too much of a hassle to maintain.
> 
> In a previous comment, I said that (on 32-bit Linux) it was likely
> that an object of > 4GB could not be handled correctly anyway. (more
> likely > 2GB). This was based on the code from (quite some) years ago.
> In particular, before you added the "streaming API". So, maybe a 32-bit
> arch _should_ be able to handle objects as large as the LFS API allows.
> (Ignoring, for the moment, that I think anybody who puts files of that
> size into an SCM probably gets what they deserve. :-P ).

In general, yes.
I had a patch that allowed a 32 bit linux to commit a file >4GB.
There is however a restriction: The file must not yet be known to the
index. Otherwise the "diff" machinery kicks in, and tries to
compare the "old" and the "new" versions, which means that -both-
must fit into "memory" at the same time. Memory means here the available
address space rather then real memory.
So there may be room for improvements for 32 bit systems, but that is another
story, which can be developped independent of the ulong->size_t conversion.

> 
> The two patches I commented on, however, changed the type of some
> variables from off_t to size_t. In general, the patches did not
> seem to make anything worse, but these type changes could potentially
> do harm. Hence my comment. (I still haven't tried the patches on my
> 32-bit Linux system. I only boot it up about once a week, and I would
> rather wait until the patches are in the 'pu' branch before testing).
> 
> ATB,
> Ramsay Jones
> 

And here (in agreement with the answer from Junio):
We should not change any off_t into size_t, since that means a possible
downgrade.
Whenever an off_t is converted into size_t, a function in git-compat-util.h is
used:

static inline size_t xsize_t(off_t len)
{
	if (len > (size_t) len)
		die("Cannot handle files this big");
	return (size_t)len;
}

Having written this, it may be a good idea to define a similar function
xulong() which is used when we do calls into zlib.

Thanks to Martin for working on this.
If there is a branch on a public repo, I can e.g. run the test suite on
different systems.
