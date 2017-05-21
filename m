Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3BE3201A7
	for <e@80x24.org>; Sun, 21 May 2017 03:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754531AbdEUDBb (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 23:01:31 -0400
Received: from csmgtwy.ucc.ie ([143.239.74.200]:55450 "EHLO csmgtwy.ucc.ie"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750873AbdEUDBa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 23:01:30 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 May 2017 23:01:30 EDT
Received: from localhost (localhost [127.0.0.1])
        by csmgtwy.ucc.ie (Postfix) with ESMTP id 4DB421B66958
        for <git@vger.kernel.org>; Sun, 21 May 2017 03:54:00 +0100 (IST)
X-Virus-Scanned: by SpamTitan at ucc.ie
Received: from csmgtwy.ucc.ie (localhost [127.0.0.1])
        by csmgtwy.ucc.ie (Postfix) with ESMTP id 1B3E21B66957
        for <git@vger.kernel.org>; Sun, 21 May 2017 03:54:00 +0100 (IST)
Received: from neptune.ucc.ie (neptune.ucc.ie [143.239.153.183])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by csmgtwy.ucc.ie (Postfix) with ESMTPS id 0CEEC1B66955
        for <git@vger.kernel.org>; Sun, 21 May 2017 03:53:59 +0100 (IST)
Received: from csmail.ucc.ie (csmail.ucc.ie [143.239.75.220])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by neptune.ucc.ie (Postfix) with ESMTPS id 19F8820101
        for <git@vger.kernel.org>; Sun, 21 May 2017 03:56:04 +0100 (IST)
Received: by csmail.ucc.ie (Postfix, from userid 4060)
        id 19A8E6A13C; Sun, 21 May 2017 03:56:04 +0100 (BST)
Date:   Sun, 21 May 2017 03:56:04 +0100
From:   Neil Cafferkey <n.cafferkey@cs.ucc.ie>
To:     git@vger.kernel.org
Subject: Options to avoid docs generation/installation
Message-ID: <20170521025604.GA8068@csmail.ucc.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The INSTALL file says that docs are not built by default, but that's not my 
experience. "make all" results in the generation of several Perl man pages, 
e.g. "Git.3pm". Is it the case that the behaviour documented is not 
propagated to the perl subdir?

Also, setting --mandir=/dev/null still results in the pages being installed 
in their usual location (at least in combination with setting --prefix to 
avoid disturbing my production git installation).

Regards,
Neil
