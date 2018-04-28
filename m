Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 510131F424
	for <e@80x24.org>; Sat, 28 Apr 2018 00:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933287AbeD1Afz convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 27 Apr 2018 20:35:55 -0400
Received: from ewa-mbsout-02.mbs.boeing.net ([130.76.20.195]:29031 "EHLO
        ewa-mbsout-02.mbs.boeing.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933207AbeD1Afx (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Apr 2018 20:35:53 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Apr 2018 20:35:53 EDT
Received: from localhost (localhost [127.0.0.1])
        by ewa-mbsout-02.mbs.boeing.net (8.14.4/8.14.4/DOWNSTREAM_MBSOUT) with SMTP id w3S0TSm6057776;
        Fri, 27 Apr 2018 17:29:29 -0700
Received: from XCH15-05-04.nw.nos.boeing.com (xch15-05-04.nw.nos.boeing.com [137.137.100.67])
        by ewa-mbsout-02.mbs.boeing.net (8.14.4/8.14.4/UPSTREAM_MBSOUT) with ESMTP id w3S0TKoV057658
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 17:29:20 -0700
Received: from XCH15-05-02.nw.nos.boeing.com (137.137.100.59) by
 XCH15-05-04.nw.nos.boeing.com (137.137.100.67) with Microsoft SMTP Server
 (TLS) id 15.0.1365.1; Fri, 27 Apr 2018 17:29:20 -0700
Received: from XCH15-05-02.nw.nos.boeing.com ([137.137.100.59]) by
 XCH15-05-02.nw.nos.boeing.com ([137.137.100.59]) with mapi id 15.00.1365.000;
 Fri, 27 Apr 2018 17:29:20 -0700
From:   "Tang (US), Pik S" <Pik.S.Tang@boeing.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Branch deletion question / possible bug?
Thread-Topic: Branch deletion question / possible bug?
Thread-Index: AdPehldpPc+KUMHLSMmwYvYnxmB3kg==
Date:   Sat, 28 Apr 2018 00:29:19 +0000
Message-ID: <d4d8d8208b6a41c380ecf20807763bcf@XCH15-05-02.nw.nos.boeing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.137.12.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I discovered that I was able to delete the feature branch I was in, due to some fat fingering on my part and case insensitivity.  I never realized this could be done before.  A quick google search did not give me a whole lot to work with...  

Steps to reproduce:
1. Create a feature branch, "editCss"
2. git checkout master
3. git checkout editCSS
4. git checkout editCss
5. git branch -d editCSS

Normally, it should have been impossible for a user to delete the branch they're on.  And the deletion left me in a weird state that took a while to dig out of.

I know this was a user error, but I was also wondering if this was a bug.


Thanks,

Pik Tang

