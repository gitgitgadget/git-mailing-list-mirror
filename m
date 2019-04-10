Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9098320248
	for <e@80x24.org>; Wed, 10 Apr 2019 11:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbfDJLvH (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 07:51:07 -0400
Received: from mail.bs-ag.com ([188.21.13.130]:50839 "EHLO mail.bs-ag.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729157AbfDJLvG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 07:51:06 -0400
Received: from mail.bs-ag.com (mail.bs-ag.com [127.0.0.1])
        by mail.bs-ag.com (Postfix) with ESMTP id C692D152B
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 13:51:04 +0200 (CEST)
Received: from BSEDGE01.bsbanksysteme.com (bsedge01.bsbanksysteme.com [192.168.12.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.bs-ag.com (Postfix) with ESMTPS id 75279152B
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 13:51:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bs-ag.com; s=mail;
        t=1554897064; bh=uvc6fl9bLMJcZUArPY1UlvFrxTsT3Thf1gUF7jiuTVo=;
        h=From:To:Subject:Date:From;
        b=XF5ajRnyr7M5Pr7DY+BPZVUKoUCOPJWnpmF+ExU9aSzCWnNd0TBqQyfKi6z4sIp8C
         RcFbYNUi59C9RP+ELChSvG4pwuFu/iT0vbG7e8RseibcdR756SlLNGbptiqYjQg7Uh
         mNKs4M5SyO4cDp8FKnS8hsYxeZ4z+6bSjGm7KnyY=
Received: from BSMAIL04.bsbanksysteme.com (192.168.61.4) by
 BSEDGE01.bsbanksysteme.com (192.168.12.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Wed, 10 Apr 2019 13:50:26 +0200
Received: from BSMAIL03.bsbanksysteme.com (192.168.61.3) by
 BSMAIL04.bsbanksysteme.com (192.168.61.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Wed, 10 Apr 2019 13:51:04 +0200
Received: from BSMAIL03.bsbanksysteme.com ([fe80::7caf:3000:a4ad:8b1e]) by
 BSMAIL03.bsbanksysteme.com ([fe80::7caf:3000:a4ad:8b1e%3]) with mapi id
 15.01.1531.010; Wed, 10 Apr 2019 13:51:04 +0200
From:   Kurt Ablinger <kurt.ablinger@bs-ag.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: repeated empty section in config of repository
Thread-Topic: repeated empty section in config of repository
Thread-Index: AdTvk2oo/MrSr8iLQPCmrcAU2Bgm9g==
Date:   Wed, 10 Apr 2019 11:51:03 +0000
Message-ID: <32db4d5189264ab791704cce91d6efaf@bs-ag.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.61.246]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EndpointSecurity-0xde81-EV: v:6.6.9.134, d:out, a:y, w:t, t:31, sv:1554888503, ts:1554897026
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,=20

I am not sure if this can be problem - at least it is proably not correct:

when adding a key to an empty section and deleting the key so that the sect=
ion is empty again,
every add adds the section-name again - example:

git config gc.autoDetach false ; git config --unset gc.autoDetach ; cat con=
fig
[gc]

git config gc.autoDetach false ; git config --unset gc.autoDetach ; cat con=
fig
[gc]
[gc]

git config gc.autoDetach false ; git config --unset gc.autoDetach ; cat con=
fig
[gc]
[gc]
[gc]

Git-version is 2.17.0
Linux - Cent/OS: 2.6.32-754.10.1.el6.x86_64 - GNU/Linux

Greetings
Kurt

