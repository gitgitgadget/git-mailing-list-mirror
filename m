Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4696220958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755384AbdCTQmn (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:42:43 -0400
Received: from mx1.riseup.net ([198.252.153.129]:33803 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754312AbdCTQmc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 12:42:32 -0400
Received: from piha.riseup.net (unknown [10.0.1.163])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 0BA101A1BA3
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 16:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1490028127; bh=EYTpsahmTQZ7C0HhWhOK92y0Gs5RLI3696m3Uerp6OY=;
        h=Date:From:To:Subject:From;
        b=M/Pcm1CRWQoPVbW2e4wP9iwNZ/Y9bVk0dumsfw5AeBUQFzraUcaoVAQeyVYd2nYcw
         UCjBvC//c3jsJaTUDlISpVNHkfjLne+Y9IOGxqApaaxRtZ7kvlhjHtJ6QsId49R3sN
         Zo65ZQZNdeJKFtnM+cTvl8iN+p6XH8qXR0lwwhX0=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: pickfire)
        with ESMTPSA id 148AF1C0345
Date:   Tue, 21 Mar 2017 00:41:54 +0800
From:   Ivan Tham <pickfire@riseup.net>
To:     git@vger.kernel.org
Subject: GSoC Project | Convert interactive rebase to C
Message-ID: <20170320164154.xBcU6rG0C%pickfire@riseup.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I am Ivan Tham. Currently studying in Computer Science in APIIT Malaysia. I am
interested particapate in Google Summer of Code 2017 under git organization. I
would like to attempt "Add more builtin patterns for userdiff" particularly for
shell for my microproject.

I am interested to work on "Convert interactive rebase to C" aiming to port
most builtins stuff to C in which we can reduce the size of git. Additionally,
I would also like to convert scripts to builtins as an additional milestone.

What do you think of these projects? Would it collide with
[Valery Tolstov's Shell to Builtins proposal][0]?

[0]: https://public-inbox.org/git/1489145258.10535.0@smtp.yandex.ru/

