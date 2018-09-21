Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C0D81F453
	for <e@80x24.org>; Fri, 21 Sep 2018 13:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389742AbeIUThu (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 15:37:50 -0400
Received: from h3.fbrelay.privateemail.com ([131.153.2.44]:40142 "EHLO
        h3.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389264AbeIUThu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Sep 2018 15:37:50 -0400
X-Greylist: delayed 881 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Sep 2018 15:37:50 EDT
Received: from MTA-09-3.privateemail.com (mta-09.privateemail.com [198.54.127.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id AD51680BF6
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 09:34:15 -0400 (EDT)
Received: from MTA-09.privateemail.com (localhost [127.0.0.1])
        by MTA-09.privateemail.com (Postfix) with ESMTP id 9EA2D60043
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 09:34:14 -0400 (EDT)
Received: from APP-02 (unknown [10.20.147.152])
        by MTA-09.privateemail.com (Postfix) with ESMTPA id 8868260047
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 13:34:14 +0000 (UTC)
Date:   Fri, 21 Sep 2018 09:34:14 -0400 (EDT)
From:   Sebastian Gniazdowski <psprint@zdharma.org>
Reply-To: Sebastian Gniazdowski <psprint@zdharma.org>
To:     git@vger.kernel.org
Message-ID: <315083291.15466.1537536854535@privateemail.com>
Subject: Very simple popen() code request, ground-shaking functionality
 openned by it
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.1-Rev36
X-Originating-Client: open-xchange-appsuite
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

Git default progress indicator for clone is very unattractive, IMO. It does its job in providing all the operation details very well, but I bet most of users strongly dream about a gauge box!

Have a look at my gauge box constructed as git-stderr pipe script: https://asciinema.org/a/202401

The main point of my feature request is: git can add core.progress_pipe option, where e.g. `/usr/local/bin/mygauge' will be set (a script like the one in the asciinema), and then simply do the ground-school-known `popen("/usr/local/bin/mygauge","r+")', and write **unchanged current-progress data** to the pipe, then read from the pipe and forward to `stderr', where the progress normally lands in.

This will allow users to free their creativity and provide probably dozens of custom Git progress bars.

--

Best regards,
Sebastian Gniazdowski
Blog: http://zdharma.org
