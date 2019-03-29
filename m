Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6B520248
	for <e@80x24.org>; Fri, 29 Mar 2019 13:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfC2NTo (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 09:19:44 -0400
Received: from mail.bs-ag.com ([188.21.13.130]:50501 "EHLO mail.bs-ag.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729483AbfC2NTn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 09:19:43 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Mar 2019 09:19:42 EDT
Received: from mail.bs-ag.com (mail.bs-ag.com [127.0.0.1])
        by mail.bs-ag.com (Postfix) with ESMTP id C8D741629
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 14:10:20 +0100 (CET)
Received: from BSEDGE01.bsbanksysteme.com (bsedge01.bsbanksysteme.com [192.168.12.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.bs-ag.com (Postfix) with ESMTPS id 649421629
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 14:10:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bs-ag.com; s=mail;
        t=1553865020; bh=x9ZYf7cLw9lE1BkGFy7V9sn3IOoLIZwKzj+Sp2kCqwI=;
        h=From:To:Subject:Date:From;
        b=Ftxm6Zal0u4drs7f2Yj3VCfUQUhTDv0tPRLLDoBmBju5fJjirYEf4uL3XiR7eUFyV
         w+w5hOcfPGYTiFRLVYkb4MFm0eGN6GHwRUp43LW1CedeZEbvDWavRlKa2EZc8xL77v
         HPC1iShuCX9W5Y8OsScdTa/XsMRMnbjB5X7pgvhM=
Received: from BSMAIL04.bsbanksysteme.com (192.168.61.4) by
 BSEDGE01.bsbanksysteme.com (192.168.12.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 29 Mar 2019 14:10:00 +0100
Received: from BSMAIL03.bsbanksysteme.com (192.168.61.3) by
 BSMAIL04.bsbanksysteme.com (192.168.61.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 29 Mar 2019 14:10:19 +0100
Received: from BSMAIL03.bsbanksysteme.com ([fe80::7caf:3000:a4ad:8b1e]) by
 BSMAIL03.bsbanksysteme.com ([fe80::7caf:3000:a4ad:8b1e%3]) with mapi id
 15.01.1531.010; Fri, 29 Mar 2019 14:10:19 +0100
From:   Kurt Ablinger <kurt.ablinger@bs-ag.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Problem with filename containing '?'
Thread-Topic: Problem with filename containing '?'
Thread-Index: AdTmMDmLpwQZ0+zUTtiuFmuefskE2w==
Date:   Fri, 29 Mar 2019 13:10:19 +0000
Message-ID: <1c1c5d858d8b431fb96b1d48044c00b7@bs-ag.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.61.246]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EndpointSecurity-0xde81-EV: v:6.6.9.134, d:out, a:y, w:t, t:32, sv:1553852180, ts:1553865000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

in Linux the git-client accepts (add, commit, push) files with '?' (questio=
nmark)  in its name.

When cloning such a repository into Eclipse (eGit/jGit) the repository-clon=
e is rejected with an 'Invalid Path'-message with the ?-filename.

Under Linux it is possible to create a clone (the same git-binary used to c=
heckin the ?-file) without any message.
But the directory containing the ?-file is silently discarded whatever you =
checkout (master/HEAD, first or any other commit containing this file).

Git-version is 2.17.0
Linux - Cent/OS: 2.6.32-754.10.1.el6.x86_64 - GNU/Linux

More information needed ?

Greetings and a have nice weekend
Kurt

