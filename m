Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E04121F4F8
	for <e@80x24.org>; Tue,  4 Oct 2016 08:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754013AbcJDIOg (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 04:14:36 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34375 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753803AbcJDIOe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 04:14:34 -0400
Received: from mfilter38-d.gandi.net (mfilter38-d.gandi.net [217.70.178.169])
        by relay3-d.mail.gandi.net (Postfix) with ESMTP id 41412A80C1;
        Tue,  4 Oct 2016 10:14:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter38-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
        by mfilter38-d.gandi.net (mfilter38-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id Py8K16QFumVy; Tue,  4 Oct 2016 10:14:31 +0200 (CEST)
X-Originating-IP: 46.232.148.34
Received: from localhost (ip-46-232-148-34.static.adsl.cheapnet.it [46.232.148.34])
        (Authenticated sender: strk@kbt.io)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 881B8A80CB;
        Tue,  4 Oct 2016 10:14:30 +0200 (CEST)
Date:   Tue, 4 Oct 2016 10:14:29 +0200
From:   Sandro Santilli <strk@kbt.io>
To:     git@vger.kernel.org
Subject: color.diff.whitespace unused on removed lines
Message-ID: <20161004081429.GC17002@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The color.diff.whitespace configuration is not used on
removed lines, but only on added lines.

As I'm removing trailing whitespaces all my diffs fail to
give me any information about the real action being taken,
due to this lack of support.

As a workaround, I've found the -R switch for "git show" [1]
but I thought about asking if this is a bug or intended behavior,
and in case it is intended I'd like to know why.

Thanks in advance.

[1]
http://stackoverflow.com/questions/5257553/coloring-white-space-in-git-diffs-output/11509388#11509388

--strk; 

  ()   Free GIS & Flash consultant/developer
  /\   https://strk.kbt.io/services.html
