Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31EDB20248
	for <e@80x24.org>; Sat, 30 Mar 2019 18:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbfC3SAY (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 14:00:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60206 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbfC3SAY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 14:00:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3944556115;
        Sat, 30 Mar 2019 14:00:20 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=vUZS2QeTh5yvX
        x3r5IYbOCTi+MY=; b=RXPvO957GuARwLFDuSWBGO9XyQ5OyDkNlj/35ySTJKYEh
        v/ccx8U9ISRPHZrosOtTveb/FEdgXEyzX1TRTByKdIbKYj08cHd2POJEKXrMWoul
        ikt+vpUF0xn7bZLO0hSlNF9b7Ai/6Ip6r0POalfkmkhBHDqRUdocVwHluwAeus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=r/SrNN4
        tp3vgNBryQZ0ATt0nQhRn6PzJpDy103jCU1g1EPSknLqMBUtUgaHFFBfGFRn83/E
        42lD/1s6Vot1mRrAZWsTWr0uPR+nlsQSm/M2mRBWHdAPlflzLb242AdH+OW0Fe1q
        NH6s/qr19G30bkQ3qAlmty9c7+qOzJ2k0R6c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F94656114;
        Sat, 30 Mar 2019 14:00:20 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E0A8656112;
        Sat, 30 Mar 2019 14:00:16 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Sat, 30 Mar 2019 14:00:14 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190330180014.GB4047@pobox.com>
References: <CAN0heSrajiswzpm+au_5nmZMZG9406iZa-CK9p5CaHLTuxm8nw@mail.gmail.com>
 <20190320181715.GJ31362@pobox.com>
 <CAN0heSpJvsPm_qq63VumokmyOG6N=6fwMZRqf_9CzoCeHsdiyQ@mail.gmail.com>
 <20190323192756.GK4047@pobox.com>
 <20190324121619.GD312@sigill.intra.peff.net>
 <20190324162131.GL4047@pobox.com>
 <20190325150633.GC19929@sigill.intra.peff.net>
 <20190325190041.GM4047@pobox.com>
 <20190327010603.GR4047@pobox.com>
 <20190328000612.GA12419@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190328000612.GA12419@genre.crustytoothpaste.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: ACF5A6FE-5315-11E9-9490-D01F9763A999-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

brian m. carlson wrote:
> On Tue, Mar 26, 2019 at 09:06:03PM -0400, Todd Zullinger wrote:
>> There's still the matter of 2.0 dropping docbook45.  I'll
>> try to get around to testing 1.5.x releases with docbook5 to
>> see if they work reasonably well.  If not, we can add a
>> version check and set ASCIIDOC_DOCBOOK appropriately.
>>=20
>> One other issue that crops up with docbook5 is that the
>> xmlto toolchain now outputs:
>>=20
>>     Note: namesp. cut : stripped namespace before processing
>>=20
>> as documented at
>>=20
>>     https://docbook.org/docs/howto/howto.html#dbxsl
>>=20
>> It's mostly an annoyance which we either want to strip out,
>> or pass an alternate docbook5 xsl, I think.  But I'm not
>> very familiar with the guts of the xml/docbook toolchains.
>=20
> I'm quite familiar with this area, because I used DocBook and its
> stylesheets for my college papers. There are two sets of stylesheets,
> the namespaced ones (for DocBook 5) and the non-namespaced ones (for
> DocBook 4). They can be distinguished because the URLs (and typically
> the paths) use "xsl" (for non-namespaced) or "xsl-ns" (for namespaced).
>=20
> xmlto by default uses the older ones, and assuming you have a reasonabl=
y
> capable XSLT processor, either set of stylesheets can be used, since
> they simply transform the document into the right type (although with a
> warning, as you've noticed).
>=20
> Unfortunately, xmlto is hard-coded to use the non-namespaced stylesheet=
s
> with no option to specify which to use, and it doesn't appear to be
> actively developed. There's an option to specify the stylesheet (-x),
> but it can't take a URL, since xmlto "helpfully" fully qualifies the
> path. That means we'd need to know the location on disk of those
> stylesheets in order to use them, since we can't rely on catalog
> resolution.

Thanks for the very useful docbook5/xmlto details!

The hard-coded use of the non-namespaced stylesheets in
xmlto is unfortunate.  I hadn't gotten far enough along to
run into that limitation of xmlto, so many thanks for saving
me from finding it myself.  I'm sure it would have taken me
far longer.

If it turns out that docbook5 causes us more pain than it's
worth, I suppose we could choose to use the builtin manpage
backend when using asciidoctor >=3D 2.

Or we could see about adding a docbook45 converter, which
upstream noted as a possibility in the ticket=B9 which dropped
docbook45 by default.

It'll be some time before we can reasonably expect to only
support asciidoctor-2.x.  We'll have to see what method
involves the least ugly hacks to support asciidoc and the
various 1.5.x and 2.x versions of asciidoctor.

=B9 https://github.com/asciidoctor/asciidoctor/issues/3005

--=20
Todd
