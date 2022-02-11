Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77034C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 21:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349282AbiBKVBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:01:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbiBKVBw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 16:01:52 -0500
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09685A5
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 13:01:49 -0800 (PST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        (Authenticated sender: jn.avila@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 6A86719F522;
        Fri, 11 Feb 2022 22:01:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1644613306;
        bh=UWljaQwLYJAFI30BLNPWnhJYSh9IxNXVau6nTYPJlpo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uFnP+2zo/HiABdSA6MiUEw+tFonrGLcwu1dzJdS5OhMjazh6cx/pbb0WJFbsToAse
         7+diRC26oQ96qrVKKxYAvKzVEZFgQcZWmDCof+H/6snEcn6sZ4ES8BuvP6d4lqRtNy
         Q8HFw+3fyArvUSmmoE/yZ7pNPOH47oRL+abQyHs4i8O8nbCC79GLiRwVPfJ+dG6e3N
         V3/tbOR2PecRZoiJIi5DEmxGPMdaakWPLjRazztAc2pDiIY1PFnEI+/9xMi/z66woU
         LzgAEptI4D0EsPQ16ZU/co8OooaqnhORYYhHkkGzXEDLFB5hTy/c+YxE+6FfT1Pfzl
         oOYa9d4XeLj3w==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2022, #02; Wed, 9)
Date:   Fri, 11 Feb 2022 22:01:44 +0100
Message-ID: <1886649.yonrKIyjYj@cayenne>
In-Reply-To: <xmqqa6ez60l8.fsf@gitster.g>
References: <xmqqa6ez60l8.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, 10 February 2022 01:12:51 CET Junio C Hamano wrote:
> * bs/forbid-i18n-of-protocol-token-in-fetch-pack (2021-12-22) 2 commits
>  - fixup! fetch-pack: parameterize message containing 'ready' keyword
>  - fetch-pack: parameterize message containing 'ready' keyword
>=20
>  L10n support for a few error messages.
>=20
>  Expecting an ack for fixup.
>  source: <20211222075805.19027-1-bagasdotme@gmail.com>
>=20

Looks good to me.

Jean-No=EBl


