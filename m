Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A663D20248
	for <e@80x24.org>; Mon, 25 Mar 2019 19:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfCYTAr (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 15:00:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59103 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYTAr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 15:00:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15AD313C739;
        Mon, 25 Mar 2019 15:00:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=9uqtDaz9Fzziu
        pQRjuXZXuGmF/I=; b=na73hDZWouYxkYxHaNQrmYOxyhD3C6JLvfsajhlS/1JFP
        76vp5sHtEqeI0rl2vEutz66CvifSCc4hgloPuPwpo23WtjjtN7DCx5beeQd0TVgp
        gt0qv14rD2S3/Ep00OoZWK3Y0S7gpWd4SKiQ6cS0avlG6F7PzbzE+cnJxjWpFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=viplfyq
        74aDk9P/JIqB8bJskUScneyDp0Nl5IebEmmAFGGzRxEmKvqFs9Tz2dQStXA6tTak
        lT/vkHFYpuqIkxRt97SkGNQn1hZcWbnT+71bq6lLrJOCbP++rGdO+ODYxZSmYi5U
        H6kbCuqA+zddq2LjvnP68116tmN1viPCJOqU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B95E13C737;
        Mon, 25 Mar 2019 15:00:45 -0400 (EDT)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7618813C736;
        Mon, 25 Mar 2019 15:00:43 -0400 (EDT)
Date:   Mon, 25 Mar 2019 15:00:41 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190325190041.GM4047@pobox.com>
References: <20190317144747.2418514-1-martin.agren@gmail.com>
 <20190317194431.GY31362@pobox.com>
 <CAN0heSrajiswzpm+au_5nmZMZG9406iZa-CK9p5CaHLTuxm8nw@mail.gmail.com>
 <20190320181715.GJ31362@pobox.com>
 <CAN0heSpJvsPm_qq63VumokmyOG6N=6fwMZRqf_9CzoCeHsdiyQ@mail.gmail.com>
 <20190323192756.GK4047@pobox.com>
 <20190324121619.GD312@sigill.intra.peff.net>
 <20190324162131.GL4047@pobox.com>
 <20190325150633.GC19929@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190325150633.GC19929@sigill.intra.peff.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 4A5705DA-4F30-11E9-85FA-DF19F34BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Sun, Mar 24, 2019 at 12:21:31PM -0400, Todd Zullinger wrote:
>> I'm curious why manpage builds work for you and not for me.
>=20
> I think it's because I'm an idiot. I must have only been using 2.0.0
> when I was looking at the XML output manually (for the refmiscinfo
> lines), and never actually rendered it to roff. I get the same problem
> when I try a full build.

Ahh.  I was hoping you'd tell me that I was a fool. :)

>> On my fedora 29 test system, ASCIIDOC_DOCBOOK=3Ddocbook5 leads
>> to a validation failure from xmlto, since docbook5 doesn't
>> use a DTD=B9.  I added XMLTO_EXTRA =3D --skip-validation to the
>> USE_ASCIIDOCTOR block, which can build many of the man
>> pages, but fails when it gets to git-blame due to use of
>> literal < > characters in the xml:
>>=20
>>     git-blame.xml:423: parser error : StartTag: invalid element name
>>     <literallayout class=3D"monospaced"><40-byte hex sha1> <sourceline=
> <resultline> <
>>                                        ^
>=20
> That seems like a bug in asciidoctor, which ought to be quoting the "<"=
.
> We certainly can't quote it ourselves (we don't even know that our
> backend output is going to a format that needs angle brackets quoted).

Yep, it seems so.  I filed this upstream:

https://github.com/asciidoctor/asciidoctor/issues/3205

I updated to asciidoctor-2.0.1 this morning to test, in case
it was one of the issues fixed since the 2.0.0 release.
Alas, we're the first to hit it and report it.

--=20
Todd
