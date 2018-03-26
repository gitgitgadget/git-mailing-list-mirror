Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A18E81F404
	for <e@80x24.org>; Mon, 26 Mar 2018 17:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeCZR5I (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 13:57:08 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:39395 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752618AbeCZR5H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 13:57:07 -0400
Received: by mail-yw0-f173.google.com with SMTP id q66so5783433ywg.6
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 10:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QvPUFegiNA45aQ7IMyUrLDBKx7+Lz2EN0TMjR5fNDxo=;
        b=DDXgGVDGyxX5zshfah5jMiE9wj/DnB4td8FhUSB8iI6UlL9zk+5fCBgknsL9yPU2ON
         suc6lFePOVHvcA4rLDuNkf+dLr5Uz+LTHh64zXnM979BKnLAADzcgiTLGLWYxwJs00jn
         cRf4VWUFwXZkIKAzPnNm/aceTpUQAymUcpBdoXOxn/CRjz5w7M9a99NfkZGMgMzFFYKI
         ur8VxEQXtrSPLMkkNdxcu0rxdZM1m9xCv9gGagCsQ60k1F5uPcBHxZccJPlgdDP+9QyJ
         uUICUo4j/IKR94nDewuw55XWCsN8ViSzdQCHLe5PkTaSFqbWckGxYw1wr7ncgawR1+Eo
         XQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QvPUFegiNA45aQ7IMyUrLDBKx7+Lz2EN0TMjR5fNDxo=;
        b=HiGG66fQ1elUe3Bviy0R5t9F2w6fqaUZB50cCHAagI9kp8A8bHli64Za1cldFqiZXt
         eZUyy60pZCJQp727/2qcQ6JQn2n6CIWAwZopnwyWfv4rUoeVXpgehRD8hGZHdVHTTRJQ
         uRR5/gTNegDm978hRcJ5s59+TQ7CB50uuEdw5OQwbom8uYFq25cgE/T52tPl0LSbxXAJ
         B1Rp9QIkmpvjXDJaVruVVYhS+mzUjU5PYEFoaxTulfVRq8zz8c4123Jy+4nv5oqLX1TZ
         IkZO7PvfLKDJxDrJV3kt01G5COOuiOVst2jAMZHk/hL1Z1ouzjAiGPIWF4gLqaakVva4
         D/CA==
X-Gm-Message-State: AElRT7FXfhXFDHkUyjAXQmgCpiD02SlTgqZl2HAXmco2nRgS9E6oCzgh
        AbDEyvQOr+dO+vU/Gfq3Bg7dgrnMCwco2gNzie9iOg==
X-Google-Smtp-Source: AG47ELuVJ/nYiqkLfbY1bx/aorUMzrzqL7g7rbqWYK7zWm6MlHafeVlKwX/euz7yIwhRhTXHzxeRbGyLUv/Vas23Cn0=
X-Received: by 10.129.86.5 with SMTP id k5mr15191960ywb.345.1522087026430;
 Mon, 26 Mar 2018 10:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
 <874ll3yd75.fsf@evledraar.gmail.com> <0c3bb65f-d418-b39e-34c7-c2f3efec7e50@jeffhostetler.com>
In-Reply-To: <0c3bb65f-d418-b39e-34c7-c2f3efec7e50@jeffhostetler.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Mar 2018 17:56:55 +0000
Message-ID: <CAGZ79ka48UETCWDAj4FcBBnOFsPjjYGXrikqzSPv-uMcZ-N=wg@mail.gmail.com>
Subject: Re: Git Merge contributor summit notes
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        alexmv@dropbox.com, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 10:33 AM Jeff Hostetler <git@jeffhostetler.com>
wrote:



> On 3/25/2018 6:58 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> > On Sat, Mar 10 2018, Alex Vandiver wrote:
> >
> >> New hash (Stefan, etc)
> >> ----------------------
> >>   - discussed on the mailing list
> >>   - actual plan checked in to
Documentation/technical/hash-function-transition.txt
> >>   - lots of work renaming
> >>   - any actual work with the transition plan?
> >>   - local conversion first; fetch/push have translation table
> >>   - like git-svn
> >>   - also modified pack and index format to have lookup/translation
efficiently
> >>   - brian's series to eliminate SHA1 strings from the codebase
> >>   - testsuite is not working well because hardcoded SHA1 values
> >>   - flip a bit in the sha1 computation and see what breaks in the
testsuite
> >>   - will also need a way to do the conversion itself; traverse and
write out new version
> >>   - without that, can start new repos, but not work on old ones
> >>   - on-disk formats will need to change -- something to keep in mind
with new index work
> >>   - documentation describes packfile and index formats
> >>   - what time frame are we talking?
> >>   - public perception question
> >>   - signing commits doesn't help (just signs commit object) unless you
"recursive sign"
> >>   - switched to SHA1dc; we detect and reject known collision technique
> >>   - do it now because it takes too long if we start when the collision
drops
> >>   - always call it "new hash" to reduce bikeshedding
> >>   - is translation table a backdoor? has it been reviewed by crypto
folks?
> >>     - no, but everything gets translated
> >>   - meant to avoid a flag day for entire repositories
> >>   - linus can decide to upgrade to newhash; if pushes to server that
is not newhash aware, that's fine
> >>   - will need a wire protocol change
> >>   - v2 might add a capability for newhash
> >>   - "now that you mention md5, it's a good idea"
> >>   - can use md5 to test the conversion
> >>   - is there a technical reason for why not /n/ hashes?
> >>   - the slow step goes away as people converge to the new hash
> >>   - beneficial to make up some fake hash function for testing
> >>   - is there a plan on how we decide which hash function?
> >>   - trust junio to merge commits when appropriate
> >>   - conservancy committee explicitly does not make code decisions
> >>   - waiting will just give better data
> >>   - some hash functions are in silicon (e.g. microsoft cares)
> >>   - any movement in libgit2 / jgit?
> >>     - basic stuff for libgit2; same testsuite problems
> >>     - no work in jgit
> >>   - most optimistic forecast?
> >>     - could be done in 1-2y
> >>   - submodules with one hash function?
> >>     - unable to convert project unless all submodules are converted
> >>     - OO-ing is not a prereq
> >
> > Late reply, but one thing I brought up at the time is that we'll want t=
o
> > keep this code around even after the NewHash migration at least for
> > testing purposes, should we ever need to move to NewNewHash.
> >
> > It occurred to me recently that once we have such a layer it could be
> > (ab)used with some relatively minor changes to do any arbitrary
> > local-to-remote object content translation, unless I've missed somethin=
g
> > (but I just re-read hash-function-transition.txt now...).
> >
> > E.g. having a SHA-1 (or NewHash) local repo, but interfacing with a
> > remote server so that you upload a GPG encrypted version of all your
> > blobs, and have your trees reference those blobs.
> >
> > Because we'd be doing arbitrary translations for all of
> > commits/trees/blobs this could go further than other bolted-on
> > encryption solutions for Git. E.g. paths in trees could be encrypted
> > too, as well as all the content of the commit object that isn't parent
> > info & the like (but that would have different hashes).
> >
> > Basically clean/smudge filters on steroids, but for every object in the
> > repo. Anyone who got a hold of it would still see the shape of the repo
> > & approximate content size, but other than that it wouldn't be more inf=
o
> > than they'd get via `fast-export --anonymize` now.
> >
> > I mainly find it interesting because presents an intersection between a
> > feature we might want to offer anyway, and something that would stress
> > the hash transition codepath going forward, to make sure it hasn't all
> > bitrotted by the time we'll need NewHash->NewNewHash.
> >
> > Git hosting providers would hate it, but they should probably be
> > charging users by how much Michael Haggerty's git-sizer tool hates thei=
r
> > repo anyway :)
> >

> While we are converting to a new hash function, it would be nice
> if we could add a couple of fields to the end of the OID:  the object
> type and the raw uncompressed object size.

This would allow to craft invalid OIDs, i.e. the correct hash value with
the wrong object type. (This is different field of "invalid" compared to
today, where we either have or do not have the object named by the
hash value. If we don't have it, it may be just unknown to us, but not
"wrong".)

> If would be nice if we could extend the OID to include 6 bytes of data
> (4 or 8 bits for the type and the rest for the raw object size), and
> just say that an OID is a {hash,type,size} tuple.

My suspicion is that the size of the OID is directly proportional to
the speed of lookup (actually worse than linear, due to CPU caches
being finite), specifically given Stollees work on walking the DAG.
Hence I would appreciate if an OID would not contain redundant
information and have a high information density.

> There are lots of places where we open an object to see what type it is
> or how big it is.  This requires uncompressing/undeltafying the object
> (or at least decoding enough to get the header).  In the case of missing
> objects (partial clone or a gvfs-like projection) it requires either
> dynamically fetching the object or asking an object-size-server for the
> data.

The commit graph could have these infos in another column, too?
Then we would have to add the promised objects
to that data structure as well, but that would look like
a way better design IMHO.

> Just a thought.  While we are converting to a new hash it seems like
> this would be a good time to at least discuss it.

I'd agree.

Stefan
