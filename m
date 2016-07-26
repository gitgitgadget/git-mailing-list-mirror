Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9D88203E2
	for <e@80x24.org>; Tue, 26 Jul 2016 01:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbcGZBYz (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 21:24:55 -0400
Received: from zandvoort.avirtualhome.com ([96.126.105.64]:33136 "EHLO
	mail.avirtualhome.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbcGZBYz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 21:24:55 -0400
X-Greylist: delayed 1108 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jul 2016 21:24:55 EDT
Received: from [192.168.1.120] (c-69-255-168-40.hsd1.md.comcast.net [69.255.168.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.avirtualhome.com (Postfix) with ESMTPSA id 08A9617565
	for <git@vger.kernel.org>; Mon, 25 Jul 2016 21:06:26 -0400 (EDT)
To:	git@vger.kernel.org
From:	Peter van der Does <peter@avirtualhome.com>
Subject: [Bug] [Git Gui] git-gui commit gpg signing problem
Message-ID: <bc4132ef-5f4b-85ce-19f5-581fb0aadd24@avirtualhome.com>
Date:	Mon, 25 Jul 2016 21:06:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It seems that git gui does not adhere to the config settings

git config commit.gpgsign true
git config --global user.signingkey <KEY>

Commits done through git gui are not signed while done through cli they
are signed

Peter van der Does
