Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B10891FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 15:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbdJ0Px6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 11:53:58 -0400
Received: from mail.javad.com ([54.86.164.124]:55384 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751145AbdJ0Px5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 11:53:57 -0400
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Oct 2017 11:53:57 EDT
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id A734E60E23
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 15:44:22 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1e86o1-0008CH-0E
        for git@vger.kernel.org; Fri, 27 Oct 2017 18:44:21 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     git@vger.kernel.org
Subject: How to re-merge paths differently?
Date:   Fri, 27 Oct 2017 18:44:20 +0300
Message-ID: <87wp3g61ez.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Is there anything like this:

$ git merge b
[... lot of conflicts ...]
$ git re-merge -X ours -- x/   # Leaves 0 conflicts in x/
$ git re-merge -X theirs -- y/ # Leaves 0 conflicts in y/
[... resolve the rest of conflicts manually ...]
$ git commit

[*] I do mean '-X' above, not '-s'.

-- Sergey
