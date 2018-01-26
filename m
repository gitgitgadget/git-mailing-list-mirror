Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08A301F404
	for <e@80x24.org>; Sat, 27 Jan 2018 21:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbeA0VL5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 16:11:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:37008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751467AbeA0VL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 16:11:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 00684ADD5
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 21:07:32 +0000 (UTC)
Date:   Fri, 26 Jan 2018 18:32:30 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     git@vger.kernel.org
Subject: git send-email sets date
Message-ID: <20180126183230.0ae0c76b@kitsune.suse.cz>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

git send-email sets the message date to author date.

This is wrong because the message will most likely not get delivered
when the author date differs from current time. It might give slightly
better results with commit date instead of author date but can't is
just skip that header and leave it to the mailer?

It does not even seem to have an option to suppress adding the date
header.

Thanks

Michal
