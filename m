Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 929311FC44
	for <e@80x24.org>; Mon,  8 May 2017 12:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbdEHMPa (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 08:15:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:64069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751125AbdEHMP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 08:15:29 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LraSn-1eAv363SZR-013Q5d; Mon, 08
 May 2017 14:15:21 +0200
Date:   Mon, 8 May 2017 14:15:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] add--interactive: add builtin helper for interactive
 add
In-Reply-To: <CAEA2_RKzUdSPP4bBvGiFVfNnAY3wwp+0LYriC4q5XfCP-1-F4w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705081335400.146734@virtualbox>
References: <1494009820-2090-1-git-send-email-bnmvco@gmail.com> <1494009820-2090-3-git-send-email-bnmvco@gmail.com> <alpine.DEB.2.21.1.1705052328380.146734@virtualbox> <CAEA2_RKzUdSPP4bBvGiFVfNnAY3wwp+0LYriC4q5XfCP-1-F4w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-675691365-1494243451=:146734"
Content-ID: <alpine.DEB.2.21.1.1705081346050.146734@virtualbox>
X-Provags-ID: V03:K0:3c0kCJ8r3MRu0JVgxMvvIOHndNCieeXvW7f7/lH3Hl+XoL7T2Yw
 f/9dnSt7chsl1JQ1s5JpA7dVc73X3Oh445psYsWij8Vpk7pS6Dj/EqgmjLaG6aXK7k6iA4x
 XyNJuGiO8WaHZSr2nC7iQDOiYnNgDoLHyLWy4yIA9Oyf9+bkp4Du0D5Roak02Jn24n/ZW8S
 o0qq8a/Kf6hmWp5va8OTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LpdkvObDRaA=:vk2EXWKbr978tZBv0BEiGA
 i0JlWSm4zXWx3wnBJoV+n5jAo+mFtyjt8MZ1lwGeHZYtj4YocLE4piPsQ8iKCB1ceLAB8dtna
 Qhrvct71Oao05Gr2q/+8e1K65aYfvZQ4ioyTxfjQbXDKzVRbRpP6APWHNS7bY99BBBADk4Gn2
 AW+pjzH2zbCm+euDCC2sSsLFCVYjje+qmE9qZhIYuCKoUYXxnYLGvaDgHfyBd2J/JAl2u7lwF
 qd2iks0853PLUKHpIrhCKPdITeB0ds2J2f+9Iqa9QZhMtiBGaXeGVut/lZ3Vhpt3QuBrUn3F1
 G0XISHFN36XLde05TZtmT5NKunIP6idByeC0xnZD31r+CrpJilMnUGvkHW62eVtaldDjwjYqk
 25S3tGnSOqf8CEVXzc60EJzZski+cj97hR6XA7XQvw0dppkanwQMU3lf3cksYcrzTofKGTx5C
 b1V/FL/WfE7HZWzHDjwso268InGixirdKRYmCyBEfc/v2g6dik8ao7F+lVL98KRinM0fKT6sQ
 /Qx6CdIVlgct9iKqk6uixI/WLSbfX7R2PYYK4f0gq/x10e5xD4am+hNFXL5e5dkx68OonyxVP
 gXBX4FTC9PSWXulphSbRTmaKvh4njlhtgwyihU7Jg5RaD/TWtM/6jsVDETX5whRdwcx0Zdq2s
 ruuBeEQFlLtmuhRKVEkwxMwA6iXYaaHXyVBd1Q+c+GxaGZ1UWGu9pk2WJRz1xjBgonvNsBgCG
 UEbbWCGwenFRkBD9OGFosmjAP4qK2tQUN/V+3V3zNpbCXb/WXt77HDQsyEJU+sFViWbCqQx7n
 NbRmlWq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-675691365-1494243451=:146734
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.21.1.1705081346051.146734@virtualbox>

Hi Daniel,

On Fri, 5 May 2017, Daniel Ferreira (theiostream) wrote:

> On Fri, May 5, 2017 at 7:30 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >> +static int git_add_interactive_config(const char *var,
> >
> > Not git_add_interactive__helper_config()? ;-)
>=20
> I don't get if you mean this ironically (because of the verbosity) or
> if you do think this would be a good name ;P

Hehe. I meant it tongue-in-cheek.

So let me try again in my endeavor to provide *constructive* criticism,
i.e. not only pointing out what I think is suboptimal, but *also* how to
improve it in my opinion. How about add_i_config() or git_add_config()?

> >> +     for (i =3D 0; i < q->nr; i++) {
> >> +             struct diff_filepair *p;
> >> +             p =3D q->queue[i];
> >> +             diff_flush_stat(p, options, &stat);
> >> +     }
> >> +
> >> +     for (i =3D 0; i < stat.nr; i++) {
> >> +             int file_index =3D s->file_count;
> >> +             for (j =3D 0; j < s->file_count; j++) {
> >> +                     if (!strcmp(s->files[j].path, stat.files[i]->nam=
e)) {
> >> +                             file_index =3D j;
> >> +                             break;
> >> +                     }
> >> +             }
> >
> > So basically, this is looking up in a list whether we saw the file in
> > question already, and the reason we have to do that is that we run the
> > entire shebang twice, once with the worktree and once with the index.
> >
> > I wonder whether it would not make sense to switch away s->files from a
> > list to a hashmap.
> > [...]
> > BTW in the first pass, we pretty much know that we only get unique name=
s,
> > so the entire lookup is unnecessary and will just increase the time
> > complexity from O(n) to O(n^2). So let's avoid that.
> >
> > By moving to a hashmap, you can even get the second phase down to an
> > expected O(n).
>=20
> How would you go about implementing that hashmap (i.e. what should be
> the hash)? Does Git have any interface for it, or is there any example
> I can look after in the codebase?

The example =C3=86var pointed to seems to be pretty good (Michael Haggerty'=
s
commits are in general excellent examples to follow):

=09https://github.com/git-for-windows/git/commit/7d4558c462f0

In this case, we can even fold the added/deleted part into the struct:

=09#include "hashmap.h"

=09...

=09struct file_stats {
=09=09struct hashmap_entry entry;
=09=09struct {
=09=09=09uintmax_t added, deleted;
=09=09} index, worktree;
=09=09char name[FLEX_ARRAY];
=09}

=09...
=09=09for (i =3D 0; i < stat.nr; i++) {
=09=09=09struct file_stats *stats;
=09=09=09const char *name =3D stat.files[i]->name;
=09=09=09unsigned int hash =3D strhash(name);

=09=09=09stats =3D s->phase =3D=3D INDEX ? NULL :
=09=09=09=09hashmap_get_from_hash(&map, hash, name);
=09=09=09if (!stats) {
=09=09=09=09FLEX_ALLOC_STR(stats, name, name);
=09=09=09=09hashmap_entry_init(stats, hash);
=09=09=09=09stats->index.added =3D stats->index.deleted =3D 0;
=09=09=09=09stats->worktree.added =3D
=09=09=09=09=09stats->worktree.deleted =3D 0;
=09=09=09=09hashmap_add(&map, stats);
=09=09=09}

=09=09=09if (s->phase =3D=3D INDEX) {
=09=09=09=09stats->index.added =3D stat.files[i]->added;
=09=09=09=09stats->index.deleted =3D stat.files[i]->deleted;
=09=09=09} else {
=09=09=09=09stats->worktree.added =3D stat.files[i]->added;
=09=09=09=09stats->worktree.deleted =3D stat.files[i]->deleted;
=09=09=09}
=09=09}

But maybe it should simultaneously put those added entries into a growing
array, as they arrive sorted and we will want to output the entries
sorted, too.

Oh, this reminds me: you are reading the list in two phases, and each time
the entries arrive sorted, but the second time we still may append new
entries.

Maybe we need to sort the entries afterwards?

> > Apart from using PATH_MAX bytes for most likely only short names: [...]
>=20
> If not PATH_MAX, what should I go for? Make it a strbuf? I tend to
> believe keeping that on the stack would be simpler and more optimal.

On the stack, no question. But I was talking about struct
add_interactive_file_status, which is allocated via malloc(), not
allocated on the stack/heap.

> > Now that I read this and remember that only WORKTREE and INDEX are
> > handled in the callback function: is there actually a use for the NONE
> > enum value?  I.e. is current_mode read out in any other context than
> > the callback function? If there is no other read, then the NONE enum
> > value is just confusing.
>=20
> I just preferred to have a declared non-handled value than leave
> something undefined behind. I felt it might avoid headaches in the
> future with petty segfaults.

I found it a little harder to read, as I was puzzled about the NONE
value...

> > Why not collapse all three functions into one? It is not like they are
> > totally unrelated nor super-long.
>=20
> To me it is a matter of personal preference to keep them separate. If
> there is, however, any technical or project-style-related reason to get
> them together, I'll certainly do it.

I was looking at it from a readability point of view. These functions
became very small, and the operation (which in my mind was one logical
two-phase operation) became too scattered to follow easily. This may be a
limitation of my brain, but I would have had an easier time if those three
functions were one function.

Ciao,
Johannes
--8323329-675691365-1494243451=:146734--
