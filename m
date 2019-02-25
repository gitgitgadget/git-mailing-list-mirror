Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F3720248
	for <e@80x24.org>; Mon, 25 Feb 2019 16:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfBYQCF convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 25 Feb 2019 11:02:05 -0500
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:41636 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfBYQCE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 11:02:04 -0500
X-Greylist: delayed 1810 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Feb 2019 11:02:04 EST
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id 9CA82A02B1
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 16:31:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RRql_A_Tm0zS for <git@vger.kernel.org>;
        Mon, 25 Feb 2019 16:31:53 +0100 (CET)
Received: from JEMBX2013-01.univ-lyon1.fr (jembx2013-01.univ-lyon1.fr [134.214.201.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id 2C33DA00F0
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 16:31:53 +0100 (CET)
Received: from BEMBX2013-02.univ-lyon1.fr (2002:86d6:c9f8::86d6:c9f8) by
 JEMBX2013-01.univ-lyon1.fr (2002:86d6:c9f9::86d6:c9f9) with Microsoft SMTP
 Server (TLS) id 15.0.1263.5; Mon, 25 Feb 2019 16:31:52 +0100
Received: from BEMBX2013-02.univ-lyon1.fr ([fe80::bc7c:3e7e:93a4:9e64]) by
 BEMBX2013-02.univ-lyon1.fr ([fe80::bc7c:3e7e:93a4:9e64%15]) with mapi id
 15.00.1263.000; Mon, 25 Feb 2019 16:31:52 +0100
From:   CHABANNE PABLO p1602176 <pablo.chabanne@etu.univ-lyon1.fr>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     MOY MATTHIEU <matthieu.moy@univ-lyon1.fr>,
        BERBEZIER NATHAN p1601409 <nathan.berbezier@etu.univ-lyon1.fr>,
        BOMPARD CORENTIN p1603631 <corentin.bompard@etu.univ-lyon1.fr>
Subject: How to test the url of a remote ?
Thread-Topic: How to test the url of a remote ?
Thread-Index: AQHUzR8lSjBSKu80rEmfjHldKB8olQ==
Date:   Mon, 25 Feb 2019 15:31:52 +0000
Message-ID: <1551108712434.33528@etu.univ-lyon1.fr>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [134.214.126.172]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

we are currently working on adding the set-upstream to pull, and we were wondering on how to test if the url of the remote is a valid one. We believe it's call in the do_fetch() function in fetch.c, but we don't how it works.

Thanks in advance,

--
Corentin Bombard, Nathan Berbezier and Pablo Chabanne.
