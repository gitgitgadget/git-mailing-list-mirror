Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5675C77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 19:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjECTAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 15:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjECTAU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 15:00:20 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CF47ED0
        for <git@vger.kernel.org>; Wed,  3 May 2023 12:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1683140402; i=tboegi@web.de;
        bh=fulhYavH6iUSd07ZC8dDUh3aeyfjqblVb8PjV3cL9Ec=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Hub92dzdh8Fm1LR1f83ElTW8Xd8YnYzaYzou175X5alIHyfntM1r3oUZXgiTEYOlX
         EB/x7AJRj0pLHUIjo+MpBJbbO1BgmqBgXe1DMocbWSBzPk/Pd7+pdpjHm4NhrTGLLk
         96LF+10aCfT6YfOjC//5blSOWsE9/Nxjbdhs2sFEl5Ln2bt4M4oA7MLLH7Xpp/sjOt
         6bOPHM3DGP1Ck8uwfltfOow+7mJMLF/MU9QdFKb0/yUZQk5UVl3fGcm8SOgYVdxN1w
         kuTnITOOc0KnecsUznbpJCQ+J0C7o2EQVlfLZecTx4Irufh4D1dPiCrvmNUeVioTUG
         6WTETFRMNm5Kw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MK574-1pfUPn3QSs-00LpIF; Wed, 03
 May 2023 21:00:01 +0200
Date:   Wed, 3 May 2023 21:00:00 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        eyvind.bernhardsen@gmail.com, sandals@crustytoothpaste.net
Subject: Re: [PATCH v4 1/1] docs: rewrite the documentation of the text and
 eol attributes
Message-ID: <20230503190000.5icpfm5k3dxgoq4d@tb-raspi4>
References: <20230501023533.35370-1-alexhenrie24@gmail.com>
 <20230503044656.221175-1-alexhenrie24@gmail.com>
 <20230503044656.221175-2-alexhenrie24@gmail.com>
 <xmqq8re5wg9r.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8re5wg9r.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:xDpSbGz46ADl+00rkr9z9wTlYOD2iVmVzC31tlYLf3oYjluRxOF
 1FI/QOe6bb6y+V2Lbe/wdMlcV5VAAa+rnw0M4kuV4nidciGKRSIFae3IOLadcCSYpPlhFw+
 81NbOqV4KA8Ja9vUxQsFCEdcL7eiYjn2zOuyLdmwO+l/pnUD6Y5InK8KDC7FoZzOQjsuf1E
 yXlvmQI7FPQJo2ByfR1MA==
UI-OutboundReport: notjunk:1;M01:P0:JNCzgvKxdm4=;ZeUAAFNBa0optk+L3Hb2VhSyKP5
 nrAklYPhKdSONK9nQ4UD4IrVaTDqUUuUiP8IGklGeAV3KMCZs44W5BBVj+N2Q82VKM4/Ng85e
 QqCjCISr5/uwDeG0YRJ8eO0YSFr43itpeb2y45QG1NTYcza5fPIgqYjbQ6RSOMN+JOSKhPYue
 wYXHvcbxE52Fosg0yK0AaH+XCBFUdBTfqKIXdHUe3hya8Uhni4qEpcPDxe+GR0qjbzdfnkW5T
 u9BeWtXPAJZe4IuUxdHoTiUKHafD4epi/qLh4A1FnTYcrezu8FZUqXlRAFAbYuhL07wfz5Y5B
 F/2iF72Cf2NQzd6DUCPvBr/Xpnkk8Z3lFi+UNytgTj+H3dbVty02LeOfxDAIlRlyUIB6SVr4p
 usiESePUwAcJuv2n6nelgLfS1z4xTJO2OVmcjctPuZYcJAT6+uyYDfFyhPBK+OrjyVJlLMM0t
 /zBbUgmohVBY3KOAWtTvhMxteq4xtrnQw0/9foaeIh/CHFXKIw2q0P97uGnujOyxL2Q6/nEt1
 LRbdk5xT+h3Yw9GAXpAeSQ3MJcmuQmwPqZB3e9va1Qj3aCOQKU3TlV4YBc3+hRCd7y+Y2CLOD
 RF6sTGclb80+nmPYoHeLLw3rPtCDYyTo0kenYF6E1ZmZsLgAHYpi1qwv2lF7hTtBqQKhhfuCN
 Svxa1TTjIsl4S1wGW1/Jx11wJ5/mPv/lt3cm9rxBeUp83sVvyZp0RPmk14Yg5NYVe+698te1f
 Zi8LV1z6ENfx/ujGX+e7eRMuZ7FMPQAZCaLITkUkqkB8KTfJgqmImhGFaQCoCELAgO4gMNzeX
 BKbiTok+izAgWciHyDZamtf7vxF7jGmmPOhsx41iJEoa7W8SzEJm2CJYZl1gEMMesi7vn2JbH
 E0T/1OI82RZbLlXlDWYrrXr1NpJZXJi1guWOk8uhSM9yxh8GtkjWSO8K9xI3Kr/3PRGzCZBNe
 cz8JYQfYgSXmFWWod3arBR5zPE0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 03, 2023 at 09:06:56AM -0700, Junio C Hamano wrote:
> Alex Henrie <alexhenrie24@gmail.com> writes:


> > ---
> >  Documentation/gitattributes.txt | 59 +++++++++++++++++---------------=
-
> >  1 file changed, 31 insertions(+), 28 deletions(-)
>
> Will replace.  Unless I hear objections soon, I'll mark it for
> 'next' and merge it down.  Thanks.
>
That's all fine with me - no objections.
Happy line-ending ;-)
