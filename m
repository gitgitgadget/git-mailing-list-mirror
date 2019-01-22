Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AFE71F453
	for <e@80x24.org>; Tue, 22 Jan 2019 12:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfAVM7B convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 22 Jan 2019 07:59:01 -0500
Received: from smtp02.univ-lille1.fr ([193.49.225.20]:41648 "EHLO
        smtp02.univ-lille1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfAVM7B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 07:59:01 -0500
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2019 07:59:01 EST
Received: from smtps1.univ-lille1.fr (smtps1.univ-lille1.fr [193.49.225.52])
        by smtp02.univ-lille1.fr (8.14.3/8.14.3) with ESMTP id x0MCq2eR001375
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:52:02 +0100
Received: from [192.168.0.10] (13.135.3.93.rev.sfr.net [93.3.135.13])
        (authenticated bits=0)
        by smtps1.univ-lille1.fr (8.14.3/8.14.3/Debian-5) with ESMTP id x0MCq11k011347
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:52:03 +0100
From:   jfbu <jfbu@free.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Subject: pushRemote value not updated on git remote rename
Message-Id: <22150621-8374-4D95-82E5-8312CA6E88F3@free.fr>
Date:   Tue, 22 Jan 2019 13:52:00 +0100
To:     git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
X-Mailer: Apple Mail (2.1878.6)
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner-ID: x0MCq2eR001375
X-USTL-MailScanner: Found to be clean
X-USTL-MailScanner-SpamScore: s
X-USTL-MailScanner-From: jfbu@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, 

with git version 2.16.3 on mac os x, (fink installed)
I did

```
$ git remote rename origin monfork
```

Then I checked .git/config, all was fine but for

```
[branch "master"]
	pushRemote = origin
	remote = upstream
	merge = refs/heads/master
```

Shouldn't "origin" have been changed into "monfork" ?

Apologies if this is due to outdated git, did not check,

Best,

Jean-François
