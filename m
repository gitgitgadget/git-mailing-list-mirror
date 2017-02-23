Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 009D12022D
	for <e@80x24.org>; Thu, 23 Feb 2017 19:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbdBWTQi (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 14:16:38 -0500
Received: from mail-proxyout-mua-20.websupport.sk ([37.9.172.170]:48923 "EHLO
        mail-proxyout-20.websupport.sk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751210AbdBWTQh (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Feb 2017 14:16:37 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Feb 2017 14:16:37 EST
Received: from mail-proxyout-20.websupport.sk (localhost [127.0.0.1])
        by mua-smtp-cf.websupport.sk (Postfix) with ESMTP id DAC8BC2499
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 20:09:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=informatik-handwerk.de; s=mail; t=1487876960;
        bh=ol+zfZUYuYSCs0UQOUPwXS0k8/iiYdL8rPSnFdzAUPY=;
        h=Date:From:To:Subject;
        b=G0Gs6U/ot8f12Cj0YQDz9AWZNChDCDCkb1MSf8f7sHuw5aaw8gpo/eQV+7K9HsaF1
         QNWyRa8lhcwOc5EAs5XKCpB/wmkpJXEndTWMUDkIMWe+zp5GaWYrno8Z5gGbWiL0DP
         ZHNbTgBHchGwOw4zXUHdm7TlETJNAKzEYVCpTUCE=
Received: from lb-proxy-15.websupport.sk (unknown [10.10.2.15])
        by mail-proxyout-20.websupport.sk (Postfix) with ESMTP id CD591BE26D
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 20:09:20 +0100 (CET)
Received: from lb-proxy-15 (localhost [127.0.0.1])
        by smtp-cf.websupport.sk (Postfix) with ESMTP id 3vTkLS5TV8z5qsW
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 20:09:20 +0100 (CET)
Received: from localhost (edu241243.nat.uni-leipzig.de [139.18.241.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: peter.fargas@informatik-handwerk.de)
        by lb-proxy-15.websupport.sk (Postfix) with ESMTPSA
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 20:09:20 +0100 (CET)
Date:   Thu, 23 Feb 2017 20:09:23 +0100
From:   peter fargas <peter.fargas@informatik-handwerk.de>
To:     git@vger.kernel.org
Subject: usability bug: git-gui: keyboard shortcuts don't operate correctly
 on multi-file selections
Message-ID: <20170223200923.00007cd1@informatik-handwerk.de>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ESET-AntiSpam: OK;30;calc;2017-02-23 20:09:20;1702232009201788;D8D2: 
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ctrl+T/Ctrl+U add/remove only one file, not the whole selection - used
to work. Neither are access keys for menu underlined (Ease of access
center > underline keyboard shortcuts is on), so there is no way to
effectively work with keyb only. 

git-gui verison 0.21 GITGUI 
git version 2.11.1.windows.1
Tcl/Tk 8.6.6
64-bit installer
Windows 7 Professional

Originally posted at
https://github.com/git/git-scm.com/issues/939#issuecomment-276024341


peter.fargas @
informatik-handwerk.de
0176 / 458 67 358
