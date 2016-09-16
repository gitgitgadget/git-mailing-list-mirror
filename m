Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 586E72070F
	for <e@80x24.org>; Fri, 16 Sep 2016 01:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756639AbcIPBk0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 21:40:26 -0400
Received: from [195.159.176.226] ([195.159.176.226]:36815 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1753441AbcIPBk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 21:40:26 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1bki8V-0005E6-NL
        for git@vger.kernel.org; Fri, 16 Sep 2016 03:40:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: Potentially misleading color.* defaults explanation in git-config(1)
Date:   Fri, 16 Sep 2016 01:40:01 +0000 (UTC)
Message-ID: <nrfihd$a4o$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: tin/2.3.2-20151224 ("Glenavullen") (UNIX) (Linux/4.4.0-36-generic (x86_64))
Cancel-Lock: sha1:lTROqxf1JJcYwuFYsncKLLbvD9M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All!

git-config(1) says:

       color.branch
           A boolean to enable/disable color in the output of git-branch(1).
           May be set to always, false (or never) or auto (or true), in which
           case colors are used only when the output is to a terminal.
           Defaults to false.

If the value false is the default, and neither color.branch nor
color.ui is set in any config file, one can expect that

(1)	git branch

and

(2)	git config color.branch false ; git branch

produce the same result. But only (2) produces colorless output, (1)
uses colors (that probably depend on the default value of color.ui).

The same story with color.diff and git-show, color.grep, etc.

Is it me being a non-native English speaker, or does this part really
need to be rewritten?

PS git version 2.9.3

-- 
Mit freundlichen Grüßen,
Anatoly Borodin

