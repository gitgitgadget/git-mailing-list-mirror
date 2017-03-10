Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38A65202F8
	for <e@80x24.org>; Fri, 10 Mar 2017 11:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934113AbdCJL2d (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 06:28:33 -0500
Received: from forward5m.cmail.yandex.net ([5.255.216.23]:43154 "EHLO
        forward5m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933809AbdCJL2X (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Mar 2017 06:28:23 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::27])
        by forward5m.cmail.yandex.net (Yandex) with ESMTP id 96401210E6;
        Fri, 10 Mar 2017 14:27:50 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp3o.mail.yandex.net (Yandex) with ESMTP id EB1EF2940E96;
        Fri, 10 Mar 2017 14:27:39 +0300 (MSK)
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 9swM2oQPqj-RcUi8R2X;
        Fri, 10 Mar 2017 14:27:38 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1489145259;
        bh=4W7INJK3ncGJq/zUQzqKL4aaOmvoPwwjd0jtGBVzMBc=;
        h=Date:From:Subject:To:Cc:Message-Id;
        b=iFVowQUVt4DQHxT8pvVu826LZgg8Xio2TsPLsSNzdOMyXfX5KZr3DFuEFu3W2uGP4
         WJAkOh9WQdPU35a289UWRJXBhdMZphb0Oy0lYeJLHIH1Qo4/SRNUyHjxPNxKJK5tBq
         e1OFCxzFC8yn9r48/9LNFNihXJ+h1Nsld8gMdFfk=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-Suid-Status: 1 0,1 0,1 0,1 0
Date:   Fri, 10 Mar 2017 14:27:38 +0300
From:   Valery Tolstov <me@vtolstov.org>
Subject: [GSoC] Discussion of "Submodule related work" project
To:     Stefan Beller <sbeller@google.com>
Cc:     christian.couder@gmail.com, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org
Message-Id: <1489145258.10535.0@smtp.yandex.ru>
X-Mailer: geary/0.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have some questions about "Submodule related work" project

First of all, I would like to add this task to the project, if I'll 
take it:
https://public-inbox.org/git/1488913150.8812.0@smtp.yandex.ru/T/
What do you think about this task?

 > Cleanup our test suite. Do not use a repo itself as a submodule for 
itself

Not quite familiar with submodules yet, why this is considered to be 
ineligible
(i.e. using repo as a submodule for itself)?

 > (Advanced datastructure knowledge required?) Protect submodule from 
gc-ing
 > interesting HEADS.

Can you provide a small example that shows the problem, please?
And why advanced datastructure knowledge is expected?

Maybe you have something else about this project to say.

Thanks,
  Valery Tolstov


