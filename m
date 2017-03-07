Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 584F51FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 20:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755601AbdCGUIW (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 15:08:22 -0500
Received: from forward8p.cmail.yandex.net ([87.250.241.193]:49258 "EHLO
        forward8p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750882AbdCGUIV (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Mar 2017 15:08:21 -0500
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Mar 2017 15:08:21 EST
Received: from smtp2h.mail.yandex.net (smtp2h.mail.yandex.net [84.201.187.145])
        by forward8p.cmail.yandex.net (Yandex) with ESMTP id B11F3216D7;
        Tue,  7 Mar 2017 22:52:51 +0300 (MSK)
Received: from smtp2h.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp2h.mail.yandex.net (Yandex) with ESMTP id 6E300780CE6;
        Tue,  7 Mar 2017 22:52:47 +0300 (MSK)
Received: by smtp2h.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id l5n658qPXy-qkuiewHi;
        Tue, 07 Mar 2017 22:52:47 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1488916367;
        bh=wiKPxsuC1Kf4beMXkG58Yvxu6x+r1wZm6uc0A5SLXxE=;
        h=Date:From:Reply-To:Subject:To:Cc:Message-Id;
        b=iE1vmRA52lsjknfjOJzcsZG+bakafxiBofVPHgmNN1XpRbOfSf8GhXzuxF1CSO5NE
         Vxs1AH90bk56b2xQdVlqRuwV+kR9mZ3AMv2hKbCY+rFP5uUOuoegT1O6ZzjIXjV+dk
         9t8Xb4KVGy4Y8AkrnEh6F+ko6UD3pCRW0iRKdZdA=
Authentication-Results: smtp2h.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-ForeignMX:  US
X-Yandex-Suid-Status: 1 0,1 0,1 0,1 1130000030716801,1 0
Date:   Tue, 07 Mar 2017 22:52:45 +0300
From:   Valery Tolstov <me@vtolstov.org>
Reply-To: CAGZ79kZbc394rmxYDUxCbysKNbEQCB7aLJkf6MGcCeXKAxiKhA@mail.gmail.com
Subject: Re: git init --separate-git-dir does not update symbolic .git links
 for submodules
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, me@vtolstov.org,
        sven@cs-ware.de
Message-Id: <1488916365.8812.1@smtp.yandex.ru>
X-Mailer: geary/0.11.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just noticed that there already is function that gives module list
module_list_compute. But purpose of it's arguments is not quite clear
for me at this moment.

