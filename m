Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10AD61F404
	for <e@80x24.org>; Tue, 23 Jan 2018 20:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeAWUxg (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 15:53:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60515 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbeAWUxf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 15:53:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 50F80C8CD4;
        Tue, 23 Jan 2018 15:53:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3ashs8P+tp06
        P1JnS6fpLFf6Lgg=; b=JmUfuajrXzybayghC//resCpNPWV/O3bRqQcipV3Jbdw
        qLmHDR+uCRTSs0x7DX4dph8nkWVUTglzH2zR+zS/85E7xvKYVaRRFerqQB91hw7S
        g4Mlbo/PFurnTPSUq0C76ABC8ocC7sH0O/1DoSm5cUTNbJPFDf64UeC6OfIo18k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ja0knI
        sF17ES6oQKntUMobxcvh+qFdm4rfOxWl7z4coqqMZgeRuSgeqRCYzprR/KThBUhu
        QfQ6rfJRXhKqMJXpulYNsPNYHsy2dBraiaBboSC4gY/BgEI5VgpUvD8AkmfxVXGj
        +ad5oerJohGc+6S2YU7F+5rdNUNW60R2c9U5I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 486B9C8CD3;
        Tue, 23 Jan 2018 15:53:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4E16C8CD1;
        Tue, 23 Jan 2018 15:53:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 0/6]  convert: add support for different encodings
References: <20180120152418.52859-1-lars.schneider@autodesk.com>
        <20180123201930.GA23019@tor.lan>
Date:   Tue, 23 Jan 2018 12:53:33 -0800
In-Reply-To: <20180123201930.GA23019@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Tue, 23 Jan 2018 21:19:30 +0100")
Message-ID: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7A56E09E-007F-11E8-9F46-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On Sat, Jan 20, 2018 at 04:24:12PM +0100, lars.schneider@autodesk.com w=
rote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Hi,
>>=20
>> Patches 1-4 and 6 are preparation and helper functions.
>> Patch 5 is the actual change.
>
> I (still) have 2 remarks on convert.c - to make live easier,
> I will send a small "on top" patch the next days.

Thanks, both.  I'll stay on the sideline ;-) and deal with other
topics first.
