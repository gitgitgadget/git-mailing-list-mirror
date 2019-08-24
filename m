Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 191F21F461
	for <e@80x24.org>; Sat, 24 Aug 2019 01:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfHXB7V (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 21:59:21 -0400
Received: from sonic310-25.consmr.mail.gq1.yahoo.com ([98.137.69.151]:34278
        "EHLO sonic310-25.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbfHXB7V (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Aug 2019 21:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1566611959; bh=plq52ff/yZ37mw+psE04W7Bf22ZdoIo0sXyOhZt/mvw=; h=From:To:Subject:Date:From:Subject; b=BypSGAkR5Qm4iWQII2bUCiIsjwurnmvLVaTcyzXoGyHBIgGfrTGpUas1V9Y3xBn/GifGDrYEyrz5AUybMMdoM3xHxFKk7j+4dzVfUf88UQzr5VhJrC5Uhm2+cg0D7gsSQc/MaNkcq1nGtajaz4SpSOtJ8q7HBiSSigdLGddAqwnyhfSAIN0JBRDs20xG2dO55vrwXYkUi+UUA9VDIMwgL51lzp/rDyyVLPu/I8hYgtXS/hKiM+jW7sNZI+VZhZQIqxU5omNDun4EtCQ2u/hiohqzFpMEPBAqpdBw+pnzIvzCJg5wNV3Sp8NqYyxKLfEaI9OmX+7poVqwxXoFwzGFgw==
X-YMail-OSG: fdiK9uMVM1ngMwCGozFuTGfe1EbHc5BfB6DLPWeJCEMm4wUpFoUK2cimsIr_rZV
 yg2RXYpAEQaFX1GmrkF7cRmBvppD_0zqfQMcrdJwuQPft9oNsCi9wkHN572VLNEdP5m1HeTKsOT_
 DadP26qXC78Z0qaiQlDeTZezxYKo_LT3J7Ii.XSf76k.hS3rFanbl8geSJKR590ldwQ5gaCzQEAV
 FGoyjoh8nrVY0emIQ.kNQ30uqAZHuwMy036vWDOcBY1Ym1pJB_pPGnvYJm_oYmNVnRs.MJODitTd
 HVbl5woFYS3xfhkfVRLAtoNInFpXdhmfdtBC8gCTXP7KluIeEN8f4vMp76YGmaKhrMk8j5BQkDcA
 Yi5mFtMXWlrHaR6whLhj4HKCaLIVrbDQqr35.58sqUlbIn5wuwEGD9VpoXxQk98rtSUUw1.W31Ik
 7gQXLRA4B77dEeKSP.080tOxtlCs5vrZGnVnCAS1WF4AzSPTea_9AnfXRSimoIaSgy5.6SAmgKna
 xVU_tXzNF.hSHIq.9PX0AGlsxecMcthRSwV9ssadS8nDslVzGoiZy6fvtCsuP8jR22eICNfn.W6z
 21RkJp44qlnCmhqHAN7fqzZMOzzwHkxsttqqei4RiQ4PXmiC0NEz3BjQdwsFxkffbr4sh357vGPa
 ynHiaXWhzR8ae2FXjrwjQwWqFj.D2vzyGzVobb3capmSyX8hUKQzA_4xamBSCuKeSXjJeIZysuHh
 8TQf5skISThVx5d3bylwru4PbEt5iBjHo9dK24aa4MUaFhusVhfOurE83X1aAcVsJcOr9AccNT_x
 EM2apW0TYhJcaouaiSPtqTKBgpzt8It3qT_f0RPsLanZVhbQgCHW.c9iYj88htTJZboCemT46Syb
 29eqiUOl.kr7T5SD3wJACpWsc2y47fhp0uH2FF..CjmvjUaohvm8jc6Hw28hKqwAtj8WWJ.5ltIv
 DzmzUArpdwrmdHwVrDAGq3l98RpPp0T0PSWxXBz_xN6rKy5iCZorP3i3Z2TsiccbTUnRTmbPMUlA
 GcM9.awfBTfHzzFJqRntq46oU5RPdKsIB1blPQdXUajcddml1bWd0zubSHUyF.hSkI_jET6x55L9
 nkpnAWPQ7sxKsqyOLSIVKUgFdXYvrzOyXUVBSJtaIE2dmySK0CGwU8UtYCPiHjSEQn.FwQczPuL5
 c1Bel5K7.HQyi5C2CmACiadiZ77LiqlL5aro1ay6uGPeUfdV9EQl8aN8J5IkmbYcSpnpl4IpaG0m
 57QRgD2Btbcoc2hSyse8F
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sat, 24 Aug 2019 01:59:19 +0000
Received: by smtp426.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2aa7b5e014e19f0365102e0b5e68fc32;
          Sat, 24 Aug 2019 01:59:16 +0000 (UTC)
From:   <randall.s.becker@rogers.com>
To:     <git@vger.kernel.org>
Subject: [Question] clone performance
Date:   Fri, 23 Aug 2019 21:59:14 -0400
Message-ID: <005f01d55a1f$88e2ab20$9aa80160$@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdVaHvUaJBDp+wJRSWKE7NTcYK6wQQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I'm trying to answer a question for a customer on clone performance. They
are doing at least 2-3 clones a day, of repositories with about 2500 files
and 10Gb of content. This is stressing the file system. I have tried to
convince them that their process is not reasonable and should stick with
existing clones, using branch checkout rather that re=cloning for each
feature branch. Sadly, I have not been successful - not for a lack of
trying. Is there any way to improve raw clone performance in a situation
like this, where status really doesn't matter, because the clone's life span
is under 48 hours.

TIA,
Randall


