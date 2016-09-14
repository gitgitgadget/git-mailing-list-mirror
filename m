Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A9871FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 17:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761275AbcINR0q (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 13:26:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59246 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753801AbcINR0p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 13:26:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A20F3C1A5;
        Wed, 14 Sep 2016 13:26:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Dy2/dNoMBLsYGYek1NZo48MT6nw=; b=cLk3Qd
        kVrz8svaK6rMP2EQoY2k8rcKVixhpD2hYj3ZbljJ1d7ExluCXwqQmhKCiyJPYOhV
        iQsvtK3zOYbMxObK7pf5oEBZu0uzanRqyd5vG8jST0UCHsQF4ytMswhFIDpRMHnC
        joMHVhXmcEdljY/Vo5MzTebtRuM42vPKXTg0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BLvcbO0aTmz8BS2KWswhcWF4EdvBXh6X
        F7WXLrfq8lg+/4H+sXXD4w0hKFEJzWBKUQXEFcTylRKNyrPl+4MPvxW1R5Is2r3J
        AIe1p3j7aEXWj5RWWhZkl0AdBfAlhJWHh7mCI5AMQxlJZrtV5ZBT59gUZkADOMPB
        1YXSpuXxxRs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81DA83C1A2;
        Wed, 14 Sep 2016 13:26:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 082563C1A1;
        Wed, 14 Sep 2016 13:26:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jon Loeliger <jdl@jdl.com>,
        David Bainbridge <david.bainbridge@ericsson.com>,
        Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Miniconference at Plumbers
References: <E1bhKNo-0005m2-5z@mylo.jdl.com>
        <20160912004233.qh6uf35v5ylrboz6@sigill.intra.peff.net>
        <E1bjRLd-0005k0-Vb@mylo.jdl.com>
        <DB5PR07MB1448B5EDFE2E2D84C42A8AFCE2FF0@DB5PR07MB1448.eurprd07.prod.outlook.com>
        <E1bjVfp-0006sG-89@mylo.jdl.com>
        <xmqqeg4o27zw.fsf@gitster.mtv.corp.google.com>
        <1019E7FD-0AC0-4BCE-B810-BE20968DFEE9@gmail.com>
Date:   Wed, 14 Sep 2016 10:26:40 -0700
In-Reply-To: <1019E7FD-0AC0-4BCE-B810-BE20968DFEE9@gmail.com> (Lars
        Schneider's message of "Tue, 13 Sep 2016 00:14:12 +0100")
Message-ID: <xmqqsht2qtnz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6775700A-7AA0-11E6-932A-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Some applications have test data, image assets, and other data sets that
> need to be versioned along with the source code.
>
> How would you deal with these kind of "huge objects" _today_?

When you know that you'd find the answer to that question totally
uninteresting, why do you even bother to ask? ;-)

I don't, and if I had to, I would deal with them just like any other
objects.

A more interesting pair of questions to ask would be what the
fundamental requirement for an acceptable solution is, and what
solution within the constraint I would envision, if I were given a
group competent Git hackers and enough time to realize it.

The most important constraint is that any acceptable solution should
preserve the object identity.

And starting from a "I don't but if I had to..." repository that is
created in a dumb way, a solution that satisifies the constraint may
work like this, requiring enhancements to various parts of the
system:

 - The "upload-pack" protocol would allow the owner of a such
   repository and the party that "git clone"'s from there to
   negotiate:

    . what it means for a object to be "huge" (e.g. the owner may
      implicitly show the preference by marking a packfile as
      containing such "huge" objects, may configure that blobs that
      appear at paths that match certain glob pattern are "huge", or
      the sender and the receiver may say objects that are larger
      than X MB are "huge", etc.); and

    . what to do with "huge" objects (e.g. the receiver may ask for
      a full clone, or the receiver may ask to omit "huge" ones from
      the initial transfer)

 - The "upload-pack" protocol would give, in addition to the normal
   pack stream that conveys only non-"huge" objects, for each of
   "huge" objects that are not transferred, what its object name is
   and how it can later be retrieved.

 - Just like packing objects in packfiles was added as a different
   implementation to store objects in the object database that is
   better than storing them individually as loose object files,
   there will be a third way to store such "huge" object _in_ the
   object database, which may actually not _store_ them locally at
   all.  The local object store may merely have placeholders for
   them, in which instructions for how it can be acquired when
   necessary are stored.  The extra information sent over the
   "upload-pack" protocol for "huge" objects with the previous
   bullet-point are used to store these objects in this "third" way.

 - A new mechanism would allow such objects that are stored in this
   "third" way to be retrieved lazily or on-demand.

There are other enhancements whose necessity will fall naturally out
of such a lazy scheme outlined above.  E.g. "fsck" needs to learn
that the objects stored in the third way are considered to "exist"
but their actual contents is not expected to be verifiable until
they are retrieved. "send-pack" (i.e. running "git push" from a
repository cloned with the procedure outlined above) needs to treat
the objects stored in the third way differently (most likely, it
will fail a request for full-clone and send "not here, but you can
get it this way" for them).  Local operations that need more than
object names need to learn reasonable fallback behaviours to work
when the actual object contents are not yet available (e.g. all of
them may offer "this is not yet available; do you want to get
on-demand?" or there may even be "object.ondemand" configuration
option to skip the end-user interaction.  When on-demand retrieving
is not done, "git archive" may place a placeholder file in its
output that says "no data (yet) here", "git log --raw" may show the
object name but "git log -p" may say "insufficient data to produce a
patch", etc.) [*1*].

Because we start from the "object identity should not change", you
do not have to make a decision upfront when preparing the ultimate
source of the truth.  When you take a clone-network of a single
project as a whole, somebody needs to hold the entire set of objects
somewhere, and many of the repository in the clone-network may have
"huge" objects in the third "not here yet, here is how to get it"
form.  As the system improves, and as the networking and storage
technology changes, the definition of "huge" WILL change over time
and those repositories can turn the ones that used to be "huge" into
normal objects.

If you use approaches taken by various clean/smudge based current
crop of solutions [*2*], on the other hand, once you decide a blob
object is "huge" and needs to be replaced with a surrogate (to be
instantiated via the "clean" filter), the "huge" object _has_ to
stay in the surrogate form in the containing tree and you cannot
change the division between "huge" and "normal" ever without
rewriting the history.


[Footnote]

*1* Astute readers would realize that the utility of such a "third
    way" object storage mechanism is not limited to "keep and
    transfer huge objects lazily".  The same mechanism can say "not
    yet here, and there is no way for _you_ to retrieve the
    contents", which is an effective way to "obliterate" an object.

*2* I called them "hacks" because they are practical compromise that
    can be done with today's Git, while sidestepping harder problems
    that are needed to be solved to realize the solution outlined
    above.
