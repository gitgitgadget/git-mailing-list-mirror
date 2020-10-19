Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D499C433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 17:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134722224D
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 17:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gzDZWh7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgJSRtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 13:49:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60004 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJSRtq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 13:49:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F9167AE84;
        Mon, 19 Oct 2020 13:49:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PC9nocPxZcQ/
        DSaQlZYxdy2PbsY=; b=gzDZWh7uXyngXwFKtcV45JzVhMw00jInNfXAsUR1vd7v
        az+8Unpq0ombyftU5mmm6ti9yWzqThxk0XTCkWqA0OOKhEjMYvlX5s6KRB/7qUm1
        c28flSad8nBYLLIs3i+6TRdKgoS/OBOFlgrVPRmwRGALLY2fQTvt2fEsCh2+pF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xxPkCY
        PKruDdyOKyeVLho1A0FYvEvi9FcpxnkotaNM55lK1SkRl1edzeQvId7pGBLgw7bP
        vvtx+lx4aPPt273UOgUzFPCbLmn411zNr/NCx/wEhV9EpL7tamI4sxXzu20i1ryZ
        s+OI0PlkVZkH0L30/Fl2C2Xo5MilCgzObBM5s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 669B17AE83;
        Mon, 19 Oct 2020 13:49:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E11A17AE82;
        Mon, 19 Oct 2020 13:49:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Sami Boukortt <sami@boukortt.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: French translation: incorrect translation for error message in
 =?utf-8?Q?=E2=80=9Cgit?= push =?utf-8?Q?=3Cremote=3E=E2=80=9D?=
References: <CAAb+AL_xObsexRXL_fZdhj2FNQsOLzEz3_mZqd1Yz7F0=-havA@mail.gmail.com>
        <20201019174127.GA42778@nand.local>
Date:   Mon, 19 Oct 2020 10:49:43 -0700
In-Reply-To: <20201019174127.GA42778@nand.local> (Taylor Blau's message of
        "Mon, 19 Oct 2020 13:41:27 -0400")
Message-ID: <xmqq5z76umvc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7882D8E0-1233-11EB-A067-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Thanks for pointing it out. My French skills are poor (and getting wors=
e
> each day), but this seems reasonable to my limited knowledge.

Thanks, both.

> If you are up for it, you can send a patch changing the po/fr.po file.
> See for more on how to do that the Documentation/SubmittingPatches, and
> po/README. Here [1] is an example patch that recently modified the
> French translation.
>
> Thanks,
> Taylor
>
> [1]: https://lore.kernel.org/git/20200827223527.36788-1-sandals@crustyt=
oothpaste.net/

The localization (l10n) coordinator, Jiang Xin <worldhello.net@gmail.com>=
,
coordinates our localization effort in the l10 coordinator repository:

        https://github.com/git-l10n/git-po/

As a contributor for a language XX, you should first check TEAMS file in
this directory to see whether a dedicated repository for your language XX
exists. Fork the dedicated repository and start to work if it exists.

And here is the entry in po/TEAMS file for the French team.

    Language:	fr (French)
    Repository:	https://github.com/jnavila/git
    Leader:		Jean-No=C3=ABl Avila <jn.avila@free.fr>
    Members:	S=C3=A9bastien Helleu <flashcode@flashtux.org>

My understanding is that the l10n effort mostly uses the GitHub pull
request based workflow than sending patches to this mailing list.

Thanks.


