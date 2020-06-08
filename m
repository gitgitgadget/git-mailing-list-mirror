Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B28C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 22:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954302074B
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 22:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IfWtv6Cd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgFHWMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:12:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60923 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgFHWMu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 18:12:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3292658599;
        Mon,  8 Jun 2020 18:12:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xCmZamjdmtkR
        vB1Vbe/KvrqWVvU=; b=IfWtv6CdXGG2EjrGiM7V5PvKYY8wrIDxEe7zsVwi/l/5
        /wS4Upj8+bUhHCKFH53Hu0EDf/2o8/weECwVVEWp0IplONATzvtJOwx5ZTnUNLOK
        yWafjPJ01ymkl6IKpd+8HYUHCZ7t81Jdy26FWB9A9e+xP9ooWI6VwE6xQzaQ0xE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LCja7t
        xBWZ2X8WARBOHByvPuUxPP51Gd8FeFLgn40OEZjyE+kQNt4LczjzmlCoRlGVYlc+
        Ocu++X2+73Bb7ZVS9AM2rwnaiEefh+NUu60KR7BP5PAgRBFcVp2Ob2D1sAQxINGk
        PdY4fFzTpLuZkcqpFBrCY4IbXQfnwyi2+dyJk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29D9458598;
        Mon,  8 Jun 2020 18:12:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 690A758597;
        Mon,  8 Jun 2020 18:12:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] docs: mention MyFirstContribution in more places
References: <20200608211132.194267-1-emilyshaffer@google.com>
        <6BD1731B-8D1D-4A07-BE23-70AEB740C455@gmail.com>
Date:   Mon, 08 Jun 2020 15:12:46 -0700
In-Reply-To: <6BD1731B-8D1D-4A07-BE23-70AEB740C455@gmail.com> (Philippe
        Blain's message of "Mon, 8 Jun 2020 17:25:05 -0400")
Message-ID: <xmqq5zc1jjfl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2F4642FA-A9D5-11EA-A83F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Emily,
>
>> Le 8 juin 2020 =C3=A0 17:11, Emily Shaffer <emilyshaffer@google.com> a=
 =C3=A9crit :
>>=20
>> While the MyFirstContribution guide exists and has received some use a=
nd
>> positive reviews, it is still not as discoverable as it could be. Add =
a
>> reference to it from the GitHub pull request template, where many
>> brand-new contributors may look. Also add a reference to it in
>> SubmittingPatches, which is the central source of guidance for patch
>> contribution.
>>=20
>> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>> ---
>>=20
>> Since v1, only the tiny nit - took Philippe's advice to refer to a
>> "step-by-step" tutorial, instead of an "interactive" tutorial.
>>=20
>> Thanks.
>> - Emily
>
> Thanks. Looks good.=20
>
> Reviewed-by: Philippe Blain <levraiphilippeblain@gmail.com>

Thanks, both.
