Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 801CC20248
	for <e@80x24.org>; Wed, 10 Apr 2019 00:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfDJAho (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 20:37:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50242 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfDJAhn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 20:37:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 746C313DCFB;
        Tue,  9 Apr 2019 20:37:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HTbIVlQxKJ3s
        NsMnDurY1Zria+M=; b=NWZDhwVmgbT3P/54reUgXzNSdnRxOo8lvt2MpsK9iubw
        Mtui8bDgD5mq6bfUHl8GWOtgN/+dEueMNsKzpxXe72MNCbv1PYRXfXMg7RAi8kiG
        xxYNToj+vTnmYmWCFivUJJnmxhQCJkbvRRgFFE+ObutPiWfl8TxAAgX7TPVqFzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YUB4pa
        q5I8bb9zNaSPOfETjW97Kkytw5EKpHGi89xGDr9mFGFomHNuC0O1FQA9QfP/CoX1
        Z26opGfqO+DHNfxstytnwxpAK21dbrqcLUr/iq5kKg/jv142jnI4vKbkPxmOVzEF
        j3wsiE0vOdRZJZZcFQVVj52gaphKDUJ2TLmfg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B39A13DCFA;
        Tue,  9 Apr 2019 20:37:37 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9BECE13DCF8;
        Tue,  9 Apr 2019 20:37:36 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/2] a few more minor asciidoc/tor formatting fixes
Date:   Tue,  9 Apr 2019 20:37:32 -0400
Message-Id: <20190410003734.17124-1-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CAN0heSrPx+_dB+NZzRzidZFpfLMpQUHk-Wi8rTaer+stam0NPA@mail.gmail.com>
References: <CAN0heSrPx+_dB+NZzRzidZFpfLMpQUHk-Wi8rTaer+stam0NPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: D6A0B802-5B28-11E9-BFDB-1646B3964D18-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Martin =C3=85gren wrote:
> On Sat, 6 Apr 2019 at 00:51, Todd Zullinger <tmz@pobox.com> wrote:
>> Here's what I have currently.  I haven't tested this much with
>> asciidoctor-1.5.x releases (or maybe not at all -- it's been a
>> week or so since I worked on this).
>=20
> Tested with Asciidoctor 1.5.5. For both patches, AsciiDoctor stumbles
> before the patch, but not after it. Great. :-) For AsciiDoc 8.6.10, the
> first patch is a no-op, while the second patch makes the difference it
> intends to do. I'll follow up with comments on the individual patches.

Thanks for testing these against older Asciidoctor and for the
helpful feedback on the commit messages. =20

I reworded the message in the first commit to make it clearer
that Asciidoctor renders the {apostrophe} literally.  I updated
the body of the second commit using your suggested wording.  It
was much better than the original. :)

The contents of each commit remain unchanged.

Todd Zullinger (2):
  Documentation/git-show-branch: avoid literal {apostrophe}
  Documentation/git-svn: improve asciidoctor compatibility

 Documentation/git-show-branch.txt | 2 +-
 Documentation/git-svn.txt         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

Range-diff against v1:
1:  70e3339859 ! 1:  da553a596c Documentation/git-show-branch: drop last =
use of {apostrophe}
    @@ -1,14 +1,17 @@
     Author: Todd Zullinger <tmz@pobox.com>
    =20
    -    Documentation/git-show-branch: drop last use of {apostrophe}
    +    Documentation/git-show-branch: avoid literal {apostrophe}
    =20
         The {apostrophe} was needed at the time of a521845800 ("Document=
ation:
         remove stray backslash in show-branch discussion", 2010-08-20). =
 All
         other uses of {apostrophe} were removed in 6cf378f0cb ("docs: st=
op using
         asciidoc no-inline-literal", 2012-04-26).
    =20
    -    Escape only the leading single-quote.  This renders properly in =
asciidoc
    -    and asciidoctor.
    +    Unfortunately, the {apostrophe} is rendered literally with Ascii=
doctor
    +    (at least with 1.5.5-2.0.3).  Avoid this by using single-quotes.
    +
    +    Escaping the leading single-quote allows the content to render p=
roperly
    +    in AsciiDoc and Asciidoctor.
    =20
         Signed-off-by: Todd Zullinger <tmz@pobox.com>
    =20
2:  e8f6f873bc ! 2:  6fd412bd97 Documentation/git-svn: improve asciidocto=
r compatibility
    @@ -3,8 +3,18 @@
         Documentation/git-svn: improve asciidoctor compatibility
    =20
         The second paragraph in the CONFIGURATION section intends to emp=
hasize
    -    the word 'must' with bold type.  Adjust the formatting slightly =
to
    -    provide similar results between asciidoc and asciidoctor.
    +    the word 'must' with bold type. It does so by writing it as *mus=
t*, and
    +    this works fine with AsciiDoc. It usually works great with Ascii=
doctor,
    +    too, but in this particular instance, we have another "*" earlie=
r in the
    +    paragraph. We do escape it, and it is rendered literally just li=
ke we
    +    want it to, but Asciidoctor then ends up tripping on the second =
(or
    +    third) of the asterisks in this paragraph.
    +
    +    Since that asterisk is (part of) a literal example, we can set i=
t in
    +    monospace, by giving it as `*`. Adjust the whole paragraph in th=
is way.
    +    There's lots more monospacing to be done in this document, but s=
ince our
    +    main motivation is addressing AsciiDoc/Asciidoctor discrepancies=
 like
    +    this one, let's just convert this one paragraph.
    =20
         Signed-off-by: Todd Zullinger <tmz@pobox.com>
    =20
--=20
Todd
