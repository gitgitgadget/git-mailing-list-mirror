Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31E2B2021E
	for <e@80x24.org>; Sat, 29 Oct 2016 03:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755653AbcJ2Dev (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 23:34:51 -0400
Received: from homie.mail.dreamhost.com ([208.97.132.208]:60932 "EHLO
        homiemail-a14.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751223AbcJ2Deu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Oct 2016 23:34:50 -0400
Received: from homiemail-a14.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a14.g.dreamhost.com (Postfix) with ESMTP id 7A177392095;
        Fri, 28 Oct 2016 20:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=2nNqFSZbxP9u4e8a+WEk9jfby7U=; b=N19t3EQk/K
        tQhad9cyVglDcO/z0cGc7yJo+uxYPGP/Lhd3jfxHVcyb02A4Sd35DAgMzzTNzsFX
        hor/x8AZapVIicm3EIpPO48rGggEvdWw8UprwwpbMmRpDIjBHp9AKaEk5iTeu6fs
        OCHC9nX+tUnwl5mvkBlVJz4FmedqFecBc=
Received: from main (c-50-177-20-184.hsd1.ma.comcast.net [50.177.20.184])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a14.g.dreamhost.com (Postfix) with ESMTPSA id 17E9039208F;
        Fri, 28 Oct 2016 20:33:52 -0700 (PDT)
Message-ID: <1477712029.2904.64.camel@mattmccutchen.net>
Subject: Re: Fetch/push lets a malicious server steal the targets of "have"
 lines
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Fri, 28 Oct 2016 23:33:49 -0400
In-Reply-To: <xmqq7f8sx8lg.fsf@gitster.mtv.corp.google.com>
References: <1477690790.2904.22.camel@mattmccutchen.net>
         <xmqqmvhoxhfp.fsf@gitster.mtv.corp.google.com>
         <1477692961.2904.36.camel@mattmccutchen.net>
         <xmqq7f8sx8lg.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2016-10-28 at 18:11 -0700, Junio C Hamano wrote:
> Ah, I see.=C2=A0=C2=A0My immediate reaction is that you can do worse th=
ings in
> the reverse direction compared to this, but your scenario does sound
> bad already.

Are you saying that clients connecting to untrusted servers already
face worse risks that people should know about, so there is no point in
documenting this one? =C2=A0I guess I don't know about the other risks as=
ide
from accepting a corrupt object, which should be preventable by
enabling fetch.fsckObjects. =C2=A0It seems we need either a statement tha=
t
connecting to untrusted servers is officially unsupported or a
description of the specific risks.

Matt
