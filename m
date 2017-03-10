Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A494F1FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 19:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932769AbdCJTau (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 14:30:50 -0500
Received: from forward5h.cmail.yandex.net ([87.250.230.20]:37348 "EHLO
        forward5h.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755351AbdCJTat (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Mar 2017 14:30:49 -0500
Received: from smtp2h.mail.yandex.net (smtp2h.mail.yandex.net [84.201.187.145])
        by forward5h.cmail.yandex.net (Yandex) with ESMTP id B89E120F31;
        Fri, 10 Mar 2017 22:30:45 +0300 (MSK)
Received: from smtp2h.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp2h.mail.yandex.net (Yandex) with ESMTP id C825F781226;
        Fri, 10 Mar 2017 22:30:43 +0300 (MSK)
Received: by smtp2h.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id ibwgMe9J2p-UgHesmjT;
        Fri, 10 Mar 2017 22:30:42 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1489174242;
        bh=lMVjtLjp3iiQevkKPzmawMmHPZwnDW0Wp7j1V4l0Jog=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=sOB4VCoPG5NsjIgMoq7ym3V8G4ScDsfsdIUZs9Km1jxRlXppAJ338yK1kVnuiU8CR
         N0YmpQcCvjWnMGhSKrR8Ix34YatUqR1C1uKEK6615ukiMHNgDr39ngrX1IEmSwTV0S
         7PhuYSV6KlpRej3CFR2TTftgtZQGYEr8Dsti0+tI=
Authentication-Results: smtp2h.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-Suid-Status: 1 0,1 0,1 0,1 0
From:   Valery Tolstov <me@vtolstov.org>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, christian.couder@gmail.com, bmwill@google.com
Subject: Re: [GSoC] Discussion of "Submodule related work" project
Date:   Fri, 10 Mar 2017 22:30:40 +0300
Message-Id: <20170310193040.16816-1-me@vtolstov.org>
X-Mailer: git-send-email 2.12.0.192.gbdb9d28a5
In-Reply-To: <CAGZ79kZHjpptQAF4NM5y47PF+YXHRADAhzFUYG_+CSwRozo+qQ@mail.gmail.com>
References: <CAGZ79kZHjpptQAF4NM5y47PF+YXHRADAhzFUYG_+CSwRozo+qQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So... I thought those items listed in "Submodule related work" are
considered too small to be complete projects separately, and they
are just "subprojects" of bigger project (maybe I have this thought
because I can't estimate complexity before truly digging in).
In your response you talk about them as independent projects...
This means I can take only any one of them as starting point for
my proposal? Or maybe I misunderstood you?


Thanks,
  Valery Tolstov
