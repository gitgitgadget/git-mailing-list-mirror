Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA41C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 14:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3316820898
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 14:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbfKTOee (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:34:34 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:36691 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbfKTOed (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 09:34:33 -0500
X-Originating-IP: 157.45.8.100
Received: from localhost (unknown [157.45.8.100])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2CD346000A;
        Wed, 20 Nov 2019 14:34:30 +0000 (UTC)
Date:   Wed, 20 Nov 2019 20:04:28 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Reftable format implementation in C and Go
Message-ID: <20191120143428.u3rmuufhphbntgm5@yadavpratyush.com>
References: <CAFQ2z_Pe1Pdjy22VmCMzf4Gvx3wte1eQRn_PjSisJbr9_y7bbg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1911201247410.15956@tvgsbejvaqbjf.bet>
 <CAFQ2z_PiuFe=ZKNaZG3=2AqjcNRb-k5-CYSXeN6MQ0r5sv4S=g@mail.gmail.com>
 <CAFQ2z_PBPPQuJYA-mvKz532GikBXureOi1ePr7YdBRJbxOJCeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFQ2z_PBPPQuJYA-mvKz532GikBXureOi1ePr7YdBRJbxOJCeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/11/19 06:22AM, Han-Wen Nienhuys wrote:
> On Wed, Nov 20, 2019 at 6:19 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
> >> Would you mind, however, to relicense the code under a license compatible
> >> with GPLv2? Currently your code is under the Apache License (which I heard
> >> somewhere is probably incompatible with the GPLv2 used by the Git
> >> project):
> >> https://github.com/google/reftable/blob/6cd8dbb4106d18627f442d3148de71d7db43d4b6/c/api.h#L1-L13
> >>
> 
> according to our open source lawyers, Apache is actually compatible
> with GPLv2, but I think we could dual-license the code.

The GNU website [0] says:

  Apache License, Version 2.0

    This is a free software license, compatible with version 3 of the GNU GPL.

    Please note that this license is not compatible with GPL version 2, 
    because it has some requirements that are not in that GPL version. 
    These include certain patent termination and indemnification 
    provisions. The patent termination provision is a good thing, which 
    is why we recommend the Apache 2.0 license for substantial programs 
    over other lax permissive licenses.

[0] https://www.gnu.org/licenses/license-list.html#apache2

-- 
Regards,
Pratyush Yadav
