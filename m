Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45B661F576
	for <e@80x24.org>; Mon,  5 Feb 2018 11:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbeBELyT (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 06:54:19 -0500
Received: from mail.javad.com ([54.86.164.124]:46088 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbeBELyS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 06:54:18 -0500
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Feb 2018 06:54:18 EST
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 69DC140C9E
        for <git@vger.kernel.org>; Mon,  5 Feb 2018 11:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1517831201;
        bh=1widxYaZ8enLs7CM2xow0MfjTPF+YPVHMwuwqRrypPs=; l=363;
        h=Received:From:To:Subject;
        b=gqjQfd+lsH0gOOXpGlfUYkkbh7VBbfehvvZtJ/XnLlbHVLheS0P12rlBIuGQWOTOz
         8N4tetUZCZzIO/FlW0xxHnjKgfb+xtiQ3/z7UKVVl1aMHRzgOBOCjpccof+JpMTPE4
         kRyaSs8iS+X7zvL4hU1vK2A+5ejFAoENdaJVUmOE=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1eifEN-0006Fj-NI
        for git@vger.kernel.org; Mon, 05 Feb 2018 14:46:39 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     git@vger.kernel.org
Subject: cherry-pick '-m' curiosity
Date:   Mon, 05 Feb 2018 14:46:39 +0300
Message-ID: <87wozry7z4.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

$ git help cherry-pick

-m parent-number, --mainline parent-number
           Usually you cannot cherry-pick a merge because you do not
           know which side of the merge should be considered the
           mainline.

Isn't it always the case that "mainline" is the first parent, as that's
how "git merge" happens to work?

Is, say, "-m 2" ever useful?

-- 
Sergey
