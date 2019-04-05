Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 455FD20248
	for <e@80x24.org>; Fri,  5 Apr 2019 01:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbfDEBkt (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 21:40:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50460 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfDEBkt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 21:40:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C8416784C;
        Thu,  4 Apr 2019 21:40:47 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=sA+9ySbs+DqqC
        qZYSbcL5Z2lRXM=; b=ufwhdli1dLol4rbWyATs/MPgNHY3P9zDY4ACI/ghRC9aR
        jsRmo/mwiKIpSe3WECFD0mBpiUalxhojtGOj4dEqYR2vP525Yyt8/jGk/xRFYuY8
        KBYr5z/POQmg7KNrAo8URfgolN6F3dtI1JiEilsje2AhTX7sM9qGBu6Nug5HMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=OICAGKM
        uEFonXpJe/jvWsvikO9XnC7YUOVgSiPMuAP7agyqH4obTAwbmfFmTrXac36q0zl+
        /xf/fNzq1rB7SdsK6ipQwVi8OC65GREgfpW+iI0W7g6B7Pt3NaE7NGaoIDXca6d1
        AvsSzDgSlrx+hbc+WdSKRWr2rmBtWXHsXX3Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 23ADD6784B;
        Thu,  4 Apr 2019 21:40:47 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D17A26784A;
        Thu,  4 Apr 2019 21:40:43 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Thu, 4 Apr 2019 21:40:41 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v1 0/2] minor asciidoc/tor formatting fixes
Message-ID: <20190405014040.GR4047@pobox.com>
References: <20190330183001.16624-1-tmz@pobox.com>
 <CAN0heSpB_0Hi2zCA+gmiaARpSYM7fKayB2rs6wFi_VeXevqd+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAN0heSpB_0Hi2zCA+gmiaARpSYM7fKayB2rs6wFi_VeXevqd+Q@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: D3F6F514-5743-11E9-BEF6-D01F9763A999-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Martin =C5gren wrote:
> On Sat, 30 Mar 2019 at 19:30, Todd Zullinger <tmz@pobox.com> wrote:
>>
>> Just chipping away at the remaining differences between asciidoc and
>> asciidoctor.
>>
>> Todd Zullinger (2):
>>   Documentation/rev-list-options: wrap --date=3D<format> block with "-=
-"
>>   Documentation/git-status: fix titles in porcelain v2 section
>=20
> Nice. I've tested and diffed across various dimensions. Looks good to m=
e.

Thanks for testing!  On pu we're down to a fairly small
amount of differences now.  Most of what remains are
whitespace changes; some of which I would like to bring up
to the Asciidoctor team to see if they're intentional.

There are two other changes I've got queued locally.  One in
git-show-branch.txt removes the last use of {apostrophe}.
Another in git-svn.txt is a bit of a work-around for a
difference in the way asciidoc and asciidoctor parse the
second paragraph in the CONFIGURATION section.  That may
well be an asiidoctor bug, but it seems like one we can
adjust for without much effort.

--=20
Todd
