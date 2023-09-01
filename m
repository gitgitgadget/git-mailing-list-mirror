Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3A8CA0FE6
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 07:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbjIAH3R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 03:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjIAH3P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 03:29:15 -0400
Received: from out-238.mta1.migadu.com (out-238.mta1.migadu.com [95.215.58.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FC9E47
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 00:29:11 -0700 (PDT)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1693553350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jG0/eh4giQa+6sSRuvHPXPnpJsJyzd1Kz5QsFbroqAQ=;
        b=raNC/GMhwTk5aPtZMpIRWGUBScA9yUtT/gjj+UmRSvuoK9Sl37sShCGt/YQHu1O4ddw7m7
        PhzAjENOZgCL9SSCSpxfMgsT+IrBgFArB/rsnTAmGfoIdjU6EIM9NCo27XEjzfGfwt+LBJ
        pMGGB7RIg5Aaal00OFzPJ30H1M3jjimMOxe9kvz6g4S5nDNyGjuwgMNmJLQlGyI/y56bbA
        JDNRxV+13EpOERj7zGBr6fWVimPl/MbH4shnb1fkVpd3Hd2aL1DnrHiC9TJ92J/X6mOl8x
        rNFk3B62yTOuPmPBx5VtEbRJ2OOLtNVoX8GCzXm5qAp4Sh1x0m/QJGjztZWOmw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 01 Sep 2023 09:29:00 +0200
Message-Id: <CV7EK073OLB2.3Q4Y31O55ZY9P@taiga>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v4] format-patch: --rfc honors what --subject-prefix
 sets
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
References: <20230830064646.30904-1-sir@cmpwn.com>
 <xmqqsf808h4g.fsf@gitster.g>
 <20230831212950.GA949706@coredump.intra.peff.net>
 <xmqqv8cuswah.fsf@gitster.g>
In-Reply-To: <xmqqv8cuswah.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+1 to proposed changes
