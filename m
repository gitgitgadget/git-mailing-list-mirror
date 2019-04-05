Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0997820248
	for <e@80x24.org>; Fri,  5 Apr 2019 22:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfDEWv1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 18:51:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57350 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDEWv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 18:51:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 67497578D3;
        Fri,  5 Apr 2019 18:51:22 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hQbxtPDxlwk/
        XWLebIH+e37Sx9g=; b=gT2Biw1IXXQFcufztj6dRJlIiNigJizR54ST+LVAukdB
        RcaGnv9thk9gxyOdObd366bNimphsjLydcjLpjETqR53Ap7GwHcSNSNzZ1mg1yYk
        tF7IypMeZenFmy3zmU3G+T/C/WyJPlYSfvbPhdqJ0Fgw7a2NNdN8iHhM7Ctaukw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CCmj1H
        AVPYTWZCbgopO1y58i3mYzM+0PAlZvCoNLofE4FNR50jZZC3AIwbes5LBN4NLMuL
        qAQqfPAP4yq1kLwXGLtYYrBsN95Sug0wK5d9eb0a/8km25rtLZjjWB2HGtpKEttb
        gzdYFaZdUiAi14aTpBNBdSZ4xVDW2rGY9GY6Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 46D83578D2;
        Fri,  5 Apr 2019 18:51:22 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 689CD578D0;
        Fri,  5 Apr 2019 18:51:18 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/2] a few more minor asciidoc/tor formatting fixes
Date:   Fri,  5 Apr 2019 18:51:13 -0400
Message-Id: <20190405225115.3882-1-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CAN0heSrbjRExHwch0K_W+xwpERnFUJmaiHhCkAaK9nnxFnXEhw@mail.gmail.com>
References: <CAN0heSrbjRExHwch0K_W+xwpERnFUJmaiHhCkAaK9nnxFnXEhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 537008C4-57F5-11E9-A603-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Martin =C3=85gren wrote:
> On Fri, 5 Apr 2019 at 03:40, Todd Zullinger <tmz@pobox.com> wrote:
>> There are two other changes I've got queued locally.  One in
>> git-show-branch.txt removes the last use of {apostrophe}.
>> Another in git-svn.txt is a bit of a work-around for a
>> difference in the way asciidoc and asciidoctor parse the
>> second paragraph in the CONFIGURATION section.  That may
>> well be an asiidoctor bug, but it seems like one we can
>> adjust for without much effort.
>=20
> The second one looks like it can be fixed by using `*` instead of '\*',
> which I think is more correct anyway. I don't know what your local
> workaround looks like, but I think a patch like "use backticks
> consistently" (both change to them, in a number of places, and add them=
,
> where we currently have nothing) would be a good change by itself, and
> we could note that "BTW, this fixes ...". How does that compare to what
> you have?

That's exactly what I have -- except that I only changed the
parts needed to improve compatibility between asciidoc and
asciidoctor.  So my commit message justifies it differently.

You're probably right that a more general cleanup could be done
and then we get better asciidoctor compatibilty as a consequence.
I was trying to keep from taking too many tangents to avoid
making more work (both for myself and reviewers). :)

Here's what I have currently.  I haven't tested this much with
asciidoctor-1.5.x releases (or maybe not at all -- it's been a
week or so since I worked on this).

Todd Zullinger (2):
  Documentation/git-show-branch: drop last use of {apostrophe}
  Documentation/git-svn: improve asciidoctor compatibility

 Documentation/git-show-branch.txt | 2 +-
 Documentation/git-svn.txt         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

