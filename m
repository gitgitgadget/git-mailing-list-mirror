Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CACC433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 21:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352807AbiDAVhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 17:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352804AbiDAVho (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 17:37:44 -0400
X-Greylist: delayed 2748 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Apr 2022 14:35:53 PDT
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FC047060
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 14:35:53 -0700 (PDT)
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <markus.vervier@x41-dsec.de>)
        id 1naODa-008GqC-P7
        for git@vger.kernel.org; Fri, 01 Apr 2022 22:50:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=x41-dsec.de
        ; s=selector2; h=Subject:From:To:MIME-Version:Date:Message-ID:Content-Type;
         bh=5suu+QCdCMkJfa3epq1iVgFef+movW7JIEUcp3md+rk=; b=Qgej9Q7wlQiYDn7gZObtJqKYB
        kFxqyLWV74aJkpsV5akVVcukSIR2W5RqQCKHYSJdnFHGhHTaWdWh2CXQzcPv/aqVok6MPJaZSIdZO
        M+KkmKfqIUXSjExV1CO2PNIdHBvzF8Kqp6bE989ITbCdJtMRkPEnn68n5a+CnPgKTUAAHKTZy7iOD
        mZ4IXc0dFFruZ/0r4JzmT3yul9UA0nVhMgRnQvBneHv00yX69HifJzCC9Q8FDZ+/WQneyG2eQrZB4
        kzmnq9eHuPT24XwIPNBASMaYxmdTf4GbIOp3oGYulvgK7dnXuCu+vKEGuq0OxUVeYUsmluYtdhoCC
        8O/J94vxg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <markus.vervier@x41-dsec.de>)
        id 1naODa-000085-D6
        for git@vger.kernel.org; Fri, 01 Apr 2022 22:50:02 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (684850)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1naODP-0005FR-6d
        for git@vger.kernel.org; Fri, 01 Apr 2022 22:49:51 +0200
Content-Type: multipart/mixed; boundary="------------MTeE03xc8IPh8zs594FyGAZj"
Message-ID: <10fd679a-eb94-5380-2070-699f1b56a7b1@x41-dsec.de>
Date:   Fri, 1 Apr 2022 22:49:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To:     git@vger.kernel.org
Content-Language: en-US
From:   Markus Vervier <markus.vervier@x41-dsec.de>
Subject: Covierty Integration / Improvement
Autocrypt: addr=markus.vervier@x41-dsec.de; keydata=
 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
 ZzWupltmtHuY
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------MTeE03xc8IPh8zs594FyGAZj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear git developer team,

X41 is processing the current RfP and some questions came up regarding 
the improvement / integration of Coverity Scans for git and the 
estimation of the required work:

- Was there a special purpose for the Coverity integration (e.g. custom 
queries for variant analysis or regression testing?) or did you try to 
integrate it as a best practice / general security hygiene tool?
- Could you tell us more about the amount and types of false positives 
and problems you've faced trying to eliminate them? This will help us to 
understand the expectations / requirements for a successful integration 
of Coverity.
- Could we get access to a sample of the scan results?

Many Thanks

Markus
-- 
Markus Vervier (Managing Director)
X41 D-Sec GmbH, Dennewartstr. 25-27, D-52068 Aachen
T: +49 241 9809418-0, Fax: -9
Unternehmenssitz: Aachen, Amtsgericht Aachen: HRB19989
Geschäftsführer: Markus Vervier
--------------MTeE03xc8IPh8zs594FyGAZj
Content-Type: application/pgp-keys; name="OpenPGP_0x5C5642C317AD0166.asc"
Content-Disposition: attachment; filename="OpenPGP_0x5C5642C317AD0166.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: 7bit

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kNXmQua2GlHwZzWupltmtHuY
=rJa8
-----END PGP PUBLIC KEY BLOCK-----

--------------MTeE03xc8IPh8zs594FyGAZj--
