Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA4AD1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 11:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932710AbeGJLQ2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 07:16:28 -0400
Received: from m50-111.126.com ([123.125.50.111]:57589 "EHLO m50-111.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751418AbeGJLQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 07:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Mime-Version:Subject:Message-Id:Date; bh=eK8eU
        6XtEhkcT+XSH1t8Cm1llV4nNA7QNjhbKcVTx7w=; b=edW8/0zBjRix4vyllqnNJ
        a9oB4oyRDXQ/YFwDuwqTswmBaDbSV7R6/CV4F90jOXu8WvrV8SFh+wZEb4BDZdCm
        SOnIVuK5reO7iRbTXfaOTs6m59asfOxng2iyxBhbuqBOey7kI3cP2dQ+YTWJQDTa
        tQ+Elye8EZ0Af5F6zEd6y0=
Received: from [10.221.173.35] (unknown [202.120.234.89])
        by smtp5 (Coremail) with SMTP id jtKowAAXOZCFlURbGdvRAQ--.12892S3;
        Tue, 10 Jul 2018 19:16:23 +0800 (CST)
From:   =?gb2312?B?1tzTpszs?= <zhoudao200@126.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Git log command doesn't run as expected.
Message-Id: <F261A512-F38D-45F2-8F4F-A932B9BEA6A1@126.com>
Date:   Tue, 10 Jul 2018 19:16:21 +0800
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.8.2)
X-CM-TRANSID: jtKowAAXOZCFlURbGdvRAQ--.12892S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU28u4UUUUU
X-Originating-IP: [202.120.234.89]
X-CM-SenderInfo: p2kr3vddrsiia6rslhhfrp/1tbiXAd-8VpD53ScMwAAsw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
	I=E2=80=99m using following command to do some search work:
	git log --all -G 'some regexp' -p =E2=80=94 path/to/my/file.
But the output could miss some commit. (For example, I grep a little =
piece of code from a commit diff message(properly handled for regexp), =
but when I use the command above to search that code, I could not get =
that commit.)
	I wonder that it is because I use it in a wrong way? Then what =
should I do to correct it.

										=
										=
			Thanks!=

