Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E4D12070F
	for <e@80x24.org>; Sun, 18 Sep 2016 15:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935899AbcIRP3L (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Sep 2016 11:29:11 -0400
Received: from [195.159.176.226] ([195.159.176.226]:52460 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S933876AbcIRP3K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2016 11:29:10 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1ble1d-0005oD-CK
        for git@vger.kernel.org; Sun, 18 Sep 2016 17:29:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: Bug: pager.<cmd> doesn't work well with editors
Date:   Sun, 18 Sep 2016 15:28:53 +0000 (UTC)
Message-ID: <nrmbrl$hsk$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: tin/2.3.4-20160628 ("Newton") (UNIX) (FreeBSD/10.2-STABLE (i386))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All!

It can be useful to enable `pager.branch`, `pager.tag`, `pager.config`, etc
for some projects (`git` itself can be a good example, with all its feature
branches and tags).

But it makes commands like `git branch --edit-description`, `git tag -a`,
`git config -e` extremely unhappy. For example, `vim` says

	Vim: Warning: Output is not to a terminal

and then becomes unusable (just as `vim | less` would be).

I think, the pagination should be turned off when the editor is being
called.

-- 
Mit freundlichen Grüßen,
Anatoly Borodin

