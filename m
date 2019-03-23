Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66FFC20248
	for <e@80x24.org>; Sat, 23 Mar 2019 19:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfCWT2D (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 15:28:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51221 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfCWT2D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 15:28:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E39DE13B1F9;
        Sat, 23 Mar 2019 15:27:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=ChPdGx/EUzK7O
        psT1ja7b8DwuaM=; b=QjhRGsfFzJ/OMJC8Q54EJx4rCsbU2wrWMhUqzC4MrUTSk
        81j1MIDhwnzZnSb4/d7CaoiSO7qPPWPqPmWUeNd5jKtKz10XFDMD1piXqZGPe5Au
        CdHEOt8ohOPqnfb+nWIN1RslBW2JW82Vok0gtvVpqRf6Jo5F45Bq4R6rBmErNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=vYE4Xl/
        M1p158Nvvy3trSrjcZ9enU7W7Q63nE9/T/uNndmLUpA+uXCzI5jckRsiHl7cBQw0
        PuC1uE3h1VLv2f/6NAop7IC+DuoA5dBUb/gF+RmakFbhwr3cJ8sp+owkKC+1ZKFQ
        05oDEHwiJlujRn1YuAtKbJHwzWOrgCcwKMzQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB01B13B1F7;
        Sat, 23 Mar 2019 15:27:58 -0400 (EDT)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2854913B1F6;
        Sat, 23 Mar 2019 15:27:58 -0400 (EDT)
Date:   Sat, 23 Mar 2019 15:27:56 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190323192756.GK4047@pobox.com>
References: <20190317144747.2418514-1-martin.agren@gmail.com>
 <20190317194431.GY31362@pobox.com>
 <CAN0heSrajiswzpm+au_5nmZMZG9406iZa-CK9p5CaHLTuxm8nw@mail.gmail.com>
 <20190320181715.GJ31362@pobox.com>
 <CAN0heSpJvsPm_qq63VumokmyOG6N=6fwMZRqf_9CzoCeHsdiyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAN0heSpJvsPm_qq63VumokmyOG6N=6fwMZRqf_9CzoCeHsdiyQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: C3D6D2B8-4DA1-11E9-B76F-F733E42159A7-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Martin =C5gren wrote:
> On Wed, 20 Mar 2019 at 19:17, Todd Zullinger <tmz@pobox.com> wrote:
>> Martin =C5gren wrote:
>>> {litdd} now renders as &#x2d;&#x2d. We should find some other way to
>>> produce '--'. This should then be a simple change, as we're already
>>> providing this attribute inside an `ifdef USE_ASCIIDOCTOR`.
>>
>> I noticed that one and didn't work out a good fix, but it
>> sounds like you have one in mind.  That's great.
>>
>>> "+" becomes "&#43;". I didn't immediately find where we do that.
>>
>> For this one, I was working on replacing "{plus}" with `+`
>> (along with " " and "-").  That's probably not ideal though.
>=20
> The "plus" and "litdd" issues seem like they can be solved by doing:
>=20
>   ASCIIDOC_EXTRA +=3D -aplus=3D'+'
>   ASCIIDOC_EXTRA +=3D -alitdd=3D'\--'

Hmm, setting litdd makes the html generate an em dash
followed by a zero width space (in 1.5.8 and 2.0.0)

I updated my system to asciidoctor-2.0.0 last night and now
I can't even generate the man pages properly, because the
docbook45 converter was removed.  I'll have to see if I
missed some other required update. :/

> It would probably be worthwhile to try 1.5.7+ to see how much that
> improves things. Seems like you're already underway there.

Yeah, before I knew how soon 2.0.0 was coming, I updated to
1.5.8 and built the various Fedora packages which require it
to see how they handled it.  Almost all of the changes were
fixes to bugs in previous versions.  And the one which was
not is likely to be fixed in 2.0.0 according to asciidoctor
maintainer Dan Allen.

Have you looked at diffing the html output as well?  It
seems like we'll need to check it as well to be sure any
fixes to the manpage output don't have a negative impact on
the html output, and vice versa.

I used 'links -dump' output for comparison of the various
Fedora packages which currently build with asciidoctor.
It's not perfect.  It could miss visual changes which might
be important when viewed in a graphical browser.  But it was
better than trying to diff the html files directly. :)

We probably also want to check the validity of links within
the docs, as one of the changes in 1.5.8 caused breakage of
cross interdocument references.  (This is the change I noted
above which should be fixed in 2.0.0.)

It'll be quite a while until most systems with asciidoctor
1.5.x are gone.  I doubt that upgrading to even 1.5.8 is
suitable for the currently released Fedora versions due to
incompatible changes.  I am going to try and get 2.0.0 into
Fedora 30, but the deadline for changes has just passed, so
I may not be able to do so.  If not, it'll be 6-8 months
until a released version of Fedora has an asciidoctor newer
than 1.5.6.1.

All that is just to say that even if newer asciidoctor fixes
many of the issues we've seen it will still be a long time
before we can reasonable default to asciidoctor or drop
asciidoc support.

For what it's worth, the Fedora asciidoc packages moved to
python3 using https://github.com/asciidoc/asciidoc-py3.
That's not very active, but it should at least keep asciidoc
alive beyond the approaching python2 EOL.

--=20
Todd
