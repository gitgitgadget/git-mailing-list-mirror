Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 481C01F597
	for <e@80x24.org>; Wed, 18 Jul 2018 06:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbeGRHOp (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 03:14:45 -0400
Received: from wp232.webpack.hosteurope.de ([80.237.132.239]:60256 "EHLO
        wp232.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726110AbeGRHOp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 18 Jul 2018 03:14:45 -0400
Received: from app01-neu.ox.hosteurope.de ([92.51.170.135] helo=null); authenticated
        by wp232.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1ffg6V-0003I7-Cd; Wed, 18 Jul 2018 08:38:27 +0200
Date:   Wed, 18 Jul 2018 08:38:27 +0200 (CEST)
From:   Frank Wolf <webmaster@frank-wolf.org>
To:     git@vger.kernel.org
Message-ID: <1536686621.139255.1531895907281@ox.hosteurope.de>
Subject: Receiving console output from GIT 10mins after abort/termination?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Originating-Client: open-xchange-appsuite
X-Mailer: Open-Xchange Mailer v7.8.4-Rev24
X-bounce-key: webpack.hosteurope.de;webmaster@frank-wolf.org;1531895908;0df45cd3;
X-HE-SMSGID: 1ffg6V-0003I7-Cd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi @ll,

I hope I'm posting to the right group (not sure if it's Windows related) but I've got
a weird problem using GIT:

By accident I've tried to push a repository (containing an already
commited but not yet pushed submodule reference).
This fails immediately with an error of course BUT

after 10 mins I get an output on the console though the command exited!?
(... $Received disconnect from <GIT serverIP>: User session has timed out idling after 6000000 ms....)

Does anyone have an explanation why I still get an output after the command was aborted?

/Frank
