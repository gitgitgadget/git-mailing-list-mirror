Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7DBC433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353207AbiBKU0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:26:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239383AbiBKU0j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:26:39 -0500
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C316CF2
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:26:37 -0800 (PST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        (Authenticated sender: jn.avila@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id AA1BF19F4C8;
        Fri, 11 Feb 2022 21:26:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1644611195;
        bh=JbufnuyEVfu8IJnuailQ3cSSEtstmGWGTsn9AABYc54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FuxFU8zO9IfncHqqVGYsed6Ca9ghLaOcviRvadeZWOPen/gz01dp1yjfnkgxf3l6h
         we8eEyPHYlP7Owvu0i3wQ5b06qakf+DmIvBxlTuZrxkXq9b2uPPOrFDfXkbo6K9a3y
         f7AXrdfNeVzFM3yAj4sHLDne1/ywZcQBckff/ewKyhRd4c2dprNNEyL+xNuCIPi3DU
         BhmSTGIRH74pi4fRg6reRK5DtkzZOipjHbvYHpX2H2ZaP6i2KaquO8FR2fkbAupgDC
         UtCRzqRDPh76cO4aJjCzuWDW+7RCKFW/C5xBsARDonjKaRNpL/WtMkD1/6puiq+eWe
         vIFPpEuU9vwHA==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: factor GIT_AUTHOR_* from message strings
Date:   Fri, 11 Feb 2022 21:26:28 +0100
Message-ID: <1714138.cFTly08FWO@cayenne>
In-Reply-To: <20220119094445.15542-2-bagasdotme@gmail.com>
References: <20220119094445.15542-1-bagasdotme@gmail.com> <20220119094445.15542-2-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Note that this patch is still relevant from an i18n point of view.

If  you do not wish to propose it, I'll cherry-pick it for my next series.

Best regards,

Jean-No=EBl


