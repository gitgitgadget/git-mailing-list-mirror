Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E4D41FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 20:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753313AbdBIUpF (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 15:45:05 -0500
Received: from [195.159.176.226] ([195.159.176.226]:36236 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbdBIUpC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 15:45:02 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1cbvZb-0005ui-WF
        for git@vger.kernel.org; Thu, 09 Feb 2017 21:44:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: gitk bug: file select in the tree mode
Date:   Thu, 9 Feb 2017 20:44:02 +0000 (UTC)
Message-ID: <o7ikae$jds$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: tin/2.3.2-20151224 ("Glenavullen") (UNIX) (Linux/4.4.0-47-generic (x86_64))
Cancel-Lock: sha1:B6/cnGTyXlxjSmBpdRUMp1pKyu4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All!

There is a bug in gitk (e.g. 2.11.0):

1) Choose a repository with files in a subdir (git's repo for example).
2) `cd` to a subdir (e.g. `xdiff`).
3) Run `gitk`.
4) Select 'Tree' in the 'Patch / Tree' panel.
5) Select any file with 'Highlight this too' or 'Highlight this only'
(e.g `xmerge.c`).
6) See the short file name (`xmerge.c`) instead of the full path
(`xdiff/xmerge.c`) in the 'Find commit touching path:' edit field. No
commits touching the file can be found.

-- 
Mit freundlichen Grüßen,
Anatoly Borodin

