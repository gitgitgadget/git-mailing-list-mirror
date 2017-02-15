Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F01E82013A
	for <e@80x24.org>; Wed, 15 Feb 2017 12:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbdBOMct (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 07:32:49 -0500
Received: from mout.gmx.net ([212.227.15.18]:62109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751557AbdBOMcs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 07:32:48 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIu7d-1cgRjV09zV-002WBD; Wed, 15
 Feb 2017 13:32:40 +0100
Date:   Wed, 15 Feb 2017 13:32:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: make stderr unbuffered again
In-Reply-To: <ef8549ea-7222-fdd0-739d-855ad428e39c@kdbg.org>
Message-ID: <alpine.DEB.2.20.1702151312330.3496@virtualbox>
References: <c88612da0a62bfcbc3e278296f9d3eb010057071.1487025228.git.johannes.schindelin@gmx.de> <xmqqlgt9btrv.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702141545380.3496@virtualbox> <ef8549ea-7222-fdd0-739d-855ad428e39c@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bSpzqgBygXSK0m/Yd5mxa7Q7ouyH3ymkmo6wfbj9A4Soxia2NX7
 I6lIzACr28XpiyOIEZr5jL+UpwPumWdwKWwJOM/Hg8hIMegwM9a3uDkdFqVIdfqs+mrHtGq
 luFR/TxGLGD+Ah6mNm+9cgcOzLHeA8uls36vBKZXtOXirbqJ0Q4+tkiAEJOxby2yDU3f8Jl
 qUSwde/YqIuBZdvajB2cQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r6igC0IwKxg=:vpnaiEBkJBMvoN2GjaaAdt
 3P2x6iVIViZNzLOz931wtN4nDmPkGp6RXlRDjXLtN6ZtGTPd3VdXtaxApKpDZDjuD7Kv9Gc6K
 iNm/uEHssm1qaZ0Mad9yY4x5FdzhOPSh0AuuvuneXNj2Nt/nIHmyXEGLd/wpMdWLElfub3WR4
 LP6MXpRcigMJPI6fe5GTGy2wetgMYdxxndSvBBfW0oDO9/rkQt78tSlx/U1DtHOPXOPi0G6sb
 qCMgcdONrSW2mmcjI0c88aioxzbIR35S11WOcedvMFSBFaWNuZVTUyH5iAdoMtd3pgDQldw7P
 mt0S8b86Ee4nXJTzuek8qfT92zzuMBsTJYhXnO3BOJMKOmrKfz2z0+FPT21Fx6014MExsd8uq
 nP2/VOAh0222HcmmWtPanPijfXv35OCTyh8j0/TD54GXBSfFC2kogKdjG1ppUSfZLk/OUyC0J
 +Moak9K0okvdeZd+uj+tjha2jJobGYpz7vDl4XFbj4JlHtbYRSZxmdIaboSw9Qepp8LBmnvRt
 5K75MEdpDEMzGTszvRPlXN07TFJIEBtQmBQ28X1c1245i3hVILGoW3TmlJVYEkBpWVTDR8wS5
 pUQEKW8ChYYyrcoHP3RbO5AXfmv2YCg8O+9jhFTwARXQEkpGAwF5t04SzV0latGwiB3ZNKuFk
 cZoMNLIyaYiNV99mB/obOih2M0eFuciFEnAEVhiR0pJk42SXv+EIqv2s0/ilg+OC5Kn2JnLGj
 Az7WcTFR3nwYy0WuAewH3LEfRE0MJwkcGOE4mri6meNtTkaqQE7ehDEf4p0DWAk3HvUXR9cOa
 hTZvNzi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Tue, 14 Feb 2017, Johannes Sixt wrote:

> Am 14.02.2017 um 15:47 schrieb Johannes Schindelin:
> > On Mon, 13 Feb 2017, Junio C Hamano wrote:
> > > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> > > > When removing the hack for isatty(), we actually removed more than
> > > > just an isatty() hack: we removed the hack where internal data
> > > > structures of the MSVC runtime are modified in order to redirect
> > > > stdout/stderr.
> > > >
> > > > Instead of using that hack (that does not work with newer versions
> > > > of the runtime, anyway), we replaced it by reopening the
> > > > respective file descriptors.
> > > >
> > > > What we forgot was to mark stderr as unbuffered again.
> 
> I do not see how the earlier patch turned stderr from unbuffered to
> buffered, as it did not add or remove any setvbuf() call. Can you
> explain?

Certainly. I hoped that the commit message would do the job, but then, I
am under time pressure these days, so it was probably a bit terse.

The hack we used to make isatty() work used to change data structures
directly that are *internal* to the MSVC runtime. That is, instead of
*really* redirecting stdout/stderr, we simply changed the target of the
existing stdout/stderr and thereby could fool MSVC into believing that it
is *still* writing to the terminal (because the bit is set) and that it is
*not* a pipe (because we forcibly unset that bit).

Needless to say, this meddling with internal data structures is not only
prone to break with future updates of the MSVC runtime, it is also
inappropriate because the implementation may rely on certain side effects
(or not so side effects) that may very well cause crashes or data loss.
Imagine, for example, that the internal data structure were variable-size,
based on the HANDLE type. That is totally legitimate for an internal data
structure. And if we meddle with the HANDLE, we can easily cause data
corruption.

As GCC is basically tied to using an older version of the MSVC runtime
(unlike GLIBC, multiple versions of the MSVC runtime can coexist happily,
making it relatively easy to maintain backwards-compatibility, but that
concept is foreign to GCC), this used to not be a problem.

However, with our recent push to allow developing, building, debugging and
performance profiling in Visual Studio, that limitation no longer holds
true: if you develop with Visual Studio 2015, you will link to a newer
MSVC runtime, and that runtime changed those internal data structures
rather dramatically.

That means that we had to come up with a non-hacky way to redirect
stdout/stderr (e.g. to parse ESC color sequences and apply them to the
Win32 Console as appropriate) and still have isatty() report what we want
it to report. That is, if we redirect stdout/stderr to a pipe that parses
the color sequences for use in the Win32 Console, we want isatty() to
report that we are writing to a Terminal Typewriter (a charming
anachronism, isn't it?).

My colleague Jeff Hostetler worked on this and figured out that the only
way to do this properly is to wrap isatty() and override it via a #define,
and simply remember when stdout/stderr referred to a terminal before
redirecting, say, to that pipe.

As my famously broken patch to override isatty() (so that /dev/null would
not be treated as a terminal) *already* overrode isatty() with a custom
wrapper, and as it was broken and needed fixing, I decided to reconcile
the two approaches into what is now the version in `master`.

So instead of "bending" the target HANDLE of the existing stdout/stderr
(which would *naturally* have kept the buffered/unbuffered nature as-is),
we now redirect with correct API calls. And the patch I provided at the
bottom of this mail thread reinstates the unbuffered nature of stderr now
that it gets reopened.

Hopefully that makes it clear why the setvbuf() call is required now, but
was previously unnecessary?

Ciao,
Dscho
