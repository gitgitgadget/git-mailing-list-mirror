Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA83C2D0CE
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 00:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA032253D
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 00:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAVAmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 19:42:04 -0500
Received: from filter03.dlls.pa.frontiernet.net ([199.224.80.233]:46428 "EHLO
        filter03.dlls.pa.frontiernet.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727969AbgAVAmE (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Jan 2020 19:42:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by filter03.dlls.pa.frontiernet.net (Postfix) with ESMTP id 7AF01ADD36
        for <git@vger.kernel.org>; Wed, 22 Jan 2020 00:42:03 +0000 (UTC)
Received: from relay02.dlls.pa.frontiernet.net ([199.224.80.245])
        by localhost (filter03.dlls.pa.frontiernet.net [199.224.80.233]) (amavisd-new, port 10024)
        with LMTP id wtnFIk-iBISn for <git@vger.kernel.org>;
        Wed, 22 Jan 2020 00:42:01 +0000 (UTC)
X-Originating-IP: [50.53.161.182]
X-Previous-IP: 50.53.161.182
Received: from AHSNB1 (static-50-53-161-182.bvtn.or.frontiernet.net [50.53.161.182])
        by relay02.dlls.pa.frontiernet.net (Postfix) with ESMTPA id 950E07F62
        for <git@vger.kernel.org>; Wed, 22 Jan 2020 00:42:01 +0000 (UTC)
From:   "JunkYardMail1" <JunkYardMail1@Frontier.com>
To:     <git@vger.kernel.org>
Subject: Sparse Checkout Trouble (2.5.0)
Date:   Tue, 21 Jan 2020 16:42:02 -0800
Message-ID: <062301d5d0bc$c3e17760$4ba46620$@Frontier.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdXQvL6DcIdZ6GHfTmW7PRUXFUlkyQ==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a shallow repository clone and using sparse-checkout of just a
handful of directories.  When I upgraded from git version 2.24.1 to 2.25.0
some files not in the sparse-checkout were staged to be deleted.  The
directory path of these files contain the Windows reserved name of "prn".
Ex: "japanese/prn/. . ."  Unable to un-stage these files and reset the
changes.

.git/inof/Sparse-checkout:
!/*/
/*/directory-*/

Reverting back to the previous version (2.24.1) allowed to un-stage the
files and reset the changes.


