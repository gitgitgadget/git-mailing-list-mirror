Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC649202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbdCIWBO (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:01:14 -0500
Received: from forward1h.cmail.yandex.net ([87.250.230.16]:36887 "EHLO
        forward1h.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750739AbdCIWBN (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Mar 2017 17:01:13 -0500
Received: from smtp2j.mail.yandex.net (smtp2j.mail.yandex.net [IPv6:2a02:6b8:0:801::ac])
        by forward1h.cmail.yandex.net (Yandex) with ESMTP id 92887210FA;
        Fri, 10 Mar 2017 01:01:03 +0300 (MSK)
Received: from smtp2j.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp2j.mail.yandex.net (Yandex) with ESMTP id 068963EC0E95;
        Fri, 10 Mar 2017 01:01:01 +0300 (MSK)
Received: by smtp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id IHLfoO085d-10Pi3tp6;
        Fri, 10 Mar 2017 01:01:00 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1489096861;
        bh=4tJKDuzyMrxRbIKfJVaQFBmkqxVfY0ZF7IILfvs5bc0=;
        h=Date:From:Subject:To:Cc:Message-Id;
        b=UxlQ5m64vdXqNNTj04iYkHU8cT9XK3vzHszCYWJsA8566wVN51VDFYXJuOvwh03dE
         EfIGztpNdZbUhx8wLWBqFuPm2wsGhk9Go/+7E2Mc6Et4Enfn/sS4NDnksCTYZkq39v
         +aWw8GNhtQVTCXSQ4WXJvyYHgu9LubEoUdxTiX3o=
Authentication-Results: smtp2j.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-Suid-Status: 1 0,1 0,1 0,1 0
Date:   Fri, 10 Mar 2017 01:00:59 +0300
From:   Valery Tolstov <me@vtolstov.org>
Subject: [GSoC] Git patch flow
To:     git <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Message-Id: <1489096859.3286.1@smtp.yandex.ru>
X-Mailer: geary/0.11.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Documentation/SubmittingPatches it is said:

 > (4) The list forms consensus that the last round of your patch is
 > good. Send it to the maintainer and cc the list.

https://public-inbox.org/git/20170309181837.GF153031@google.com/T/

I assume that my patch is at stage 4 now. Now I need to do what is in 
p.4 said exactly, right? Asking this question because can't find good 
examples in mailing list archive.

Thanks,
  Valery Tolstov

