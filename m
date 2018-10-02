Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EE641F453
	for <e@80x24.org>; Tue,  2 Oct 2018 06:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJBMnv convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 2 Oct 2018 08:43:51 -0400
Received: from dns1.iai.co.il ([194.90.48.30]:30300 "EHLO mmnxfpmta1.iai.co.il"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbeJBMnv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 08:43:51 -0400
Received: from exmail4.iai.co.il (unknown [172.21.48.62])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 34D0E73403C1AAF2C978
        for <git@vger.kernel.org>; Tue,  2 Oct 2018 08:47:12 +0300 (IDT)
Received: from EXS11.iai.co.il ([169.254.2.245]) by exmail4.iai.co.il
 ([172.21.48.62]) with mapi id 14.03.0266.001; Tue, 2 Oct 2018 08:47:12 +0300
From:   Michele Hallak <mhallak@iai.co.il>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git projects with submodules in different sites - in txt format (:+(
Thread-Topic: git projects with submodules in different sites - in txt
 format (:+(
Thread-Index: AdRaE1vIt/NhnL3PTdOAtEyz5cGDcA==
Date:   Tue, 2 Oct 2018 05:47:11 +0000
Message-ID: <15774B2750A13244948B89FDD2FEC2EACF15C69A@EXS11.iai.co.il>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.48.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am getting out of idea about how to change the methodology we are using in order to ease our integration process... Close to despair, I am throwing the question to you...

We have 6 infrastructure repositories.
Each project is composed of 4 repositories, each one using one or two infrastructure repositories as sub-modules. (Not the same)

The infrastructure repositories are common to several projects and in the case we have to make change in the infrastructure for a specific project, we are doing it on a specific branch until properly merged.

Everything is fine (more or less) and somehow working.

Now, we have one project that will be developed in another site and with another git server physically separated from the main site.

I copied the infrastructure repositories in the new site and removed and add the sub-modules in order for them to point to the url in the separated git server.

Every 2 weeks, the remotely developed code has to be integrated back in the main site. 
My idea was to format GIT patches, integrate in the main site, tag the whole thing and ship back the integrated tagged code to the remote site.
... and now the nightmare starts:

Since the .gitmodules is different, I cannot have the same SHA and then same tag and I am never sure that the integrated code is proper.

May be there is a simple solution that I don't know about to my problem? Is there something else than GIT patches? Should I simply ship to the remote site the code as is and change the submodules each time?

Thanks a lot for trying to help me,

Michele



*********************************************************************************************** Please consider the environment before printing this email ! The information contained in this communication is proprietary to Israel Aerospace Industries Ltd. and/or third parties, may contain confidential or privileged information, and is intended only for the use of the intended addressee thereof. If you are not the intended addressee, please be aware that any use, disclosure, distribution and/or copying of this communication is strictly prohibited. If you receive this communication in error, please notify the sender immediately and delete it from your computer. Thank you. Visit us at: www.iai.co.il
