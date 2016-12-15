Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43EEC1FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 20:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755845AbcLOUPv (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 15:15:51 -0500
Received: from mxout01.autodesk.com ([132.188.64.231]:36428 "EHLO
        mxout01.autodesk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbcLOUPt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 15:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=autodesk.com; s=s1;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From; bh=1Xly6VBrDWP912qa2vga370r5YVACwP1mSyUg3da7g0=;
        b=nEOYXtzE3/xT6RWE9PSWlcWziL7P/QeDJrPMvmbCmPey1HBdVQ7czdxHU11pxYj5eHNOD8X32jQFtOWXrmt9DsUN+bg2Ksq1VX6pNU/XrvJ+bdGWIyGZQLcoHa/HfUFoIX6ei/A4ZF8RKyc0ZIz2wCAJnWU7n/zUwE19shVjA7JkSvMwcz5ugcgJlP2Dw9I+LARNO5EB37f08kqnkwP+P4Um8ZUnr5CUdeviYF1kHpzp3n47U+B7ku8fIW6/GdK9lp0+3skOIh1+Ak3wA8ZbGSYY5375QqztqsiLvMXb7GmnYg1zC0UhgOdayvnlIzj0ALthTCdYPC4YCGHPpKtjjA==;
Received: from [141.251.76.23] (helo=005-smtp-out.autodesk.com)
        by mxout01.autodesk.com with esmtps (TLSv1.2:AES256-SHA256:256)
        (Exim 4.84_2)
        (envelope-from <larry.minton@autodesk.com>)
        id 1cHcQe-0006H1-QH
        for git@vger.kernel.org; Thu, 15 Dec 2016 15:15:00 -0500
Received: from BLUPR79MB001.MGDADSK.autodesk.com (141.251.76.20) by
 BLUPR79MB003.MGDADSK.autodesk.com (141.251.76.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.761.13; Thu, 15 Dec 2016 20:14:59 +0000
Received: from BLUPR79MB001.MGDADSK.autodesk.com ([141.251.76.20]) by
 BLUPR79MB001.MGDADSK.autodesk.com ([141.251.76.20]) with mapi id
 15.01.0761.022; Thu, 15 Dec 2016 20:14:59 +0000
From:   Larry Minton <larry.minton@autodesk.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Is there a way to have local changes in a branch 'bake' while working
 in different branches?
Thread-Topic: Is there a way to have local changes in a branch 'bake' while
 working in different branches?
Thread-Index: AdJW7l6YXm7TGqXRTUOyzZVjoX4P5wAITbyA
Date:   Thu, 15 Dec 2016 20:14:58 +0000
Message-ID: <14b481f95c5043aca6cdfddfe4728fa9@BLUPR79MB001.MGDADSK.autodesk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [141.251.76.68]
x-ms-office365-filtering-correlation-id: af342535-0645-4469-fd60-08d425270b57
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider recommended I ask you this question.

My question:

Let's say I have a code change that I want to 'bake' for a while locally, j=
ust to make sure some edge case doesn't pop up while I am working on other =
things.=A0 Is there any practical way of doing that?=20
I could constantly merge that 'bake me' branch into other branches as I wor=
k on them and then remove those changes from the branches before sending th=
em out for code review, but sooner or later pretty much guaranteed to screw=
 that up....

His response:

Good question. Your merging idea would work but I agree it might be cumbers=
ome. In this situation I keep modified files in my tree. That would work fo=
r you too, but this would be inconvenient if you have many changed files. I=
 wonder how the Git core guys manage this kind of situation.

Thanks,

Larry Minton
3ds Max Core team
LiveDesign Group
Media & Entertainment, Education Experiences, Impact (MEI)

