Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6142D1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 11:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbeKTWIX convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 20 Nov 2018 17:08:23 -0500
Received: from ufal-mail.mff.cuni.cz ([195.113.20.158]:57176 "EHLO
        ufal-mail.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbeKTWIX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 17:08:23 -0500
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Nov 2018 17:08:21 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
        by ufal-mail.mff.cuni.cz (Postfix) with ESMTP id CCF93382456
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 12:33:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at ufal.mff.cuni.cz
Received: from ufal-mail.mff.cuni.cz ([127.0.0.1])
        by localhost (ufal-mail.mff.cuni.cz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id InenSZrgHMAk for <git@vger.kernel.org>;
        Tue, 20 Nov 2018 12:33:35 +0100 (CET)
Received: from ufal-mail.mff.cuni.cz (ufal-mail.mff.cuni.cz [195.113.20.158])
        by ufal-mail.mff.cuni.cz (Postfix) with ESMTP id B9930382455
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 12:33:35 +0100 (CET)
Date:   Tue, 20 Nov 2018 12:33:35 +0100 (CET)
From:   Anna Vernerova <vernerova@ufal.mff.cuni.cz>
To:     git@vger.kernel.org
Message-ID: <1124582873.368304.1542713615728.JavaMail.zimbra@ufal.mff.cuni.cz>
Subject: WISH: set word-diff-regex for/in gitk
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - GC65 (Linux)/8.7.11_GA_1854)
Thread-Index: Ta6t/X5bK2ewN0JCXuRILUVHSdatiw==
Thread-Topic: WISH: set word-diff-regex for/in gitk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear developers,

I am a daily use of gitk; I use the "color words" diff option most often.
I have found no way to set --word-diff-regex for gitk, or to make the command

git config --global diff.wordRegex '.'

have effect on the diffs shown in gitk.

I think the value of --word-diff-regex is effectively discarded in the block at line 215 of gitk-git/gitk,
but it seems that other changes are necessary for the parameter to take any effect.

Being able to configure word-diff-regex would be much appreciated!

Anša
