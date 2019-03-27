Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 211EA20248
	for <e@80x24.org>; Wed, 27 Mar 2019 20:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfC0UH7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 16:07:59 -0400
Received: from bureau84.ns.utoronto.ca ([128.100.132.184]:41165 "EHLO
        bureau84.ns.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfC0UH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 16:07:59 -0400
X-Greylist: delayed 2505 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2019 16:07:59 EDT
Received: from exsmtp.utoronto.ca ([128.100.46.57])
        (authenticated bits=0)
        by bureau84.ns.utoronto.ca (8.13.8/8.13.8) with ESMTP id x2RJQC0S006668
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 15:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=utoronto.ca; s=beta;
        t=1553714773; bh=zl6IumyopWMBoi5dtAUkqnYRR1phqtU0/VHp2Zuozt8=;
        h=From:To:Subject:Date:Message-ID:Content-Type:
         Content-Transfer-Encoding:MIME-Version;
        b=6TjV6RRmJ+Snsoi45S9st+5QBtYjkAsLjmQ4H87ig7NEmxCe6ZXyUPLtyRCerB0tY
         WP/NO87lGWd14Ci5yvQUYPHm3w/LwV7Yv8g1/b/e23RuYRc1/pg8ipea26nKyRSVzP
         QiWNGicDXcduPQ6pCIctrZnRY4G85iaq/xSwel00=
Received: from ARBOREXCASX3.UTORARBOR.UTORAD.Utoronto.ca
 ([fe80::d479:357a:c4f:796c]) by arborexhubx1.UTORARBOR.UTORAD.Utoronto.ca
 ([2002:8064:2e39::8064:2e39]) with mapi id 14.03.0224.002; Wed, 27 Mar 2019
 15:26:12 -0400
From:   Julian Cheng <julian.cheng@utoronto.ca>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [GSoC] [t9803]
Thread-Topic: [GSoC] [t9803]
Thread-Index: AQHU5NLUUBNMeD/zM0yu7jlWN2IVvw==
Date:   Wed, 27 Mar 2019 19:26:12 +0000
Message-ID: <7BFDFF1D85B3B544BB69BB9AB23D479D01F4534A@arborexcasx3.UTORARBOR.UTORAD.Utoronto.ca>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.100.46.46]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git Community,=0A=
=0A=
I=92m new here and hoping to get to be a part of GSOC 2019. I have question=
s about the main project and the microproject=0A=
=0A=
Main Project Quesctions=0A=
I was hoping to work on =93git revert --drop=94 and =93git commit --reword=
=94. Are there any mentors available for this project? The ideas page lists=
 mentors for other projects but not this one.=0A=
=0A=
Also, =93git revert --drop=94 and =93git commit --reword=94 appear not to h=
ave been discussed yet in the public inbox. Is this correct or am I just no=
t finding the threads?=0A=
=0A=
=0A=
Microproject Questions (test_path_is_*)=0A=
I would like to improve t9803-git-p4-shell-metachars.sh =0A=
=0A=
On the microprojects page, it suggests I should run the tests to make sure =
they all pass. But if I=92m making changes to the tests, is it really adequ=
ate testing just to make sure they all pass?=0A=
=0A=
To run all tests, I assume I would just navigate to the tests folder in ter=
minal and call =93sh *.sh=94, but that doesn=92t seem to work. Also, when I=
 call =93sh  t9803-git-p4-shell-metachars.sh=94, I get =93error: GIT-BUILD-=
OPTIONS missing (has Git been built?).=94 Git is definitely installed on my=
 computer though. I=92ve been using it for months. I cloned this repo with =
Git. What am I missing here?=0A=
=0A=
Best,=0A=
Julian=0A=
