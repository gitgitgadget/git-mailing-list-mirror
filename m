Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7D5C202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 20:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbdCOUnq (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 16:43:46 -0400
Received: from forward10m.cmail.yandex.net ([5.255.216.203]:44284 "EHLO
        forward10m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751480AbdCOUnp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Mar 2017 16:43:45 -0400
Received: from smtp2j.mail.yandex.net (smtp2j.mail.yandex.net [IPv6:2a02:6b8:0:801::ac])
        by forward10m.cmail.yandex.net (Yandex) with ESMTP id 7BB2D22C10;
        Wed, 15 Mar 2017 23:43:36 +0300 (MSK)
Received: from smtp2j.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp2j.mail.yandex.net (Yandex) with ESMTP id 3F13C3EC1215;
        Wed, 15 Mar 2017 23:43:32 +0300 (MSK)
Received: by smtp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Qz2N7jS1Eh-hT1Olt3v;
        Wed, 15 Mar 2017 23:43:31 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1489610612;
        bh=XaId1bDvnZZ9lGOYuDv4ViT+bJXSSyB+ZuiaJrrl+hU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=jnWNRMnzrW3N7/M5UZPMABlGBrMTtQkywxXrjsOJKoXv6yxQABHWoR/pjNjzjS4a6
         rSYOI1G8dy7Wx/S0Eql2aEIj4ORhUoGAcGjIERIlDtptoAsNAWZRF9tjUUC1EusfF2
         HGLs94TAyTFPgxYlZ2yScV5Wf7BImR8McNN5KAsM=
Authentication-Results: smtp2j.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-ForeignMX:  US
X-Yandex-Suid-Status: 1 0,1 0,1 0,1 0,1 1130000030716801
From:   Valery Tolstov <me@vtolstov.org>
To:     sbeller@google.com
Cc:     bmwill@google.com, christian.couder@gmail.com, git@vger.kernel.org,
        me@vtolstov.org
Subject: Re: [GSoC] Discussion of "Submodule related work" project
Date:   Wed, 15 Mar 2017 23:43:24 +0300
Message-Id: <20170315204324.9875-1-me@vtolstov.org>
X-Mailer: git-send-email 2.12.0.192.gbdb9d28a5
In-Reply-To: <CAGZ79kbLr=aSu-g83obmj3XCMMYbuody6Q_FreCmQcqpyX+_rQ@mail.gmail.com>
References: <CAGZ79kbLr=aSu-g83obmj3XCMMYbuody6Q_FreCmQcqpyX+_rQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a thought. At the moment when submodule command is already translated
to C, possibly we want to rename submodule--helper.c, and maybe hide
some of it's functions from subcommands list. Is there any examples of
similar situation that already happened before?
Don't quite sure about this.

Thanks,
  Valery Tolstov
