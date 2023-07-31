Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75CAC001DF
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 21:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjGaV4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 17:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjGaV4o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 17:56:44 -0400
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3696B19B7
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 14:56:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=t7z9uBmD0B4imHgiyxzdTCx/v3l2vFhhyw5P6b64kcr76P9/m4CJxytNtNYfrBugIiXRrgZq1pamraPyjNUyYkcp3yCnOYiizeJgVLMAgA915Kjhegw3hxGjZf66N5t+QNtBr2IvEl4r16C9CgaSooncmMWJKKqe2Gxw3DhLY28KZVJ+0lO/FyXugxi6Tfo/uPfYxQMymWXQf89PEKPbDFLcpDjWk5vaJ7lN6BtlBXo6c7qEbGqNMmwWs/3E2xNYG1VUr+/p8jn3K3X+wyBTX3mnsXPJYnIQqMCdSV4tueRnfFYZiv20IpijOWcLj8ukZvp/jcWwgo7zd2EFnDV0cw==; s=purelymail1; d=faughnan.net; v=1; bh=bYi6+Pv/rsHRjCm3DbEUrAtO92xiblr+9JfYHKRmwaU=; h=Received:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=t4Q+TUjevLg+Mse9DHw3rvdeWtXTcyARzYzgVeXt1+yS9TWJ0rM2G/t3F9HEzfdoUtWSjC32UWqggnkwMC1aSLRqB5AeR7S81HH2Vj2o/dWzgCsykIHIxW1p0EMDaPki0j5IJmb0ZpRekxCicpV51yETCla/SdgehTalA/lKutiDNM1JwxrwdDBaBGhElD3f+vpH1br4drL59BFyOwn/GHiJA6lgQbdy9W1V/nWPv6dQlLGIGt2zqiVJypWWv1C8P7TjcLoKrhT2Ojfo9rjPo+xyhu5XOTphfaBenXYnCsKaIYlbub9HIUQ4H/FaqRTYWRjkTDHc2WmXN9sx/9+ozw==; s=purelymail1; d=purelymail.com; v=1; bh=bYi6+Pv/rsHRjCm3DbEUrAtO92xiblr+9JfYHKRmwaU=; h=Feedback-ID:Received:Subject:From:To;
Feedback-ID: 3419:981:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 630178626;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 31 Jul 2023 21:56:07 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 31 Jul 2023 17:56:06 -0400
Message-Id: <CUGOYGU96P8T.3EUVTC5SAFW36@badwolf>
Cc:     "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
        "Daniel P." <danpltile@gmail.com>
Subject: Re: [PATCH] ident: don't consider trailing dot crud
From:   "Thomas J. Faughnan Jr." <thomas@faughnan.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
X-Mailer: aerc 0.15.2-108-g02eeed0b4898
References: <ZMghdgIaQB4L88WR@tapette.crustytoothpaste.net>
 <20230731214435.1462098-1-sandals@crustytoothpaste.net>
In-Reply-To: <20230731214435.1462098-1-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I agree that simply dropping the "." from the crud list is the best
solution. Hope this gets merged.
