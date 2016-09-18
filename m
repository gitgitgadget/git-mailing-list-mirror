Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46B512070F
	for <e@80x24.org>; Sun, 18 Sep 2016 15:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753712AbcIRPwL (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Sep 2016 11:52:11 -0400
Received: from [195.159.176.226] ([195.159.176.226]:55558 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbcIRPwK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2016 11:52:10 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1bleNx-0005q0-Sa
        for git@vger.kernel.org; Sun, 18 Sep 2016 17:52:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: Re: Bug: pager.<cmd> doesn't work well with editors
Date:   Sun, 18 Sep 2016 15:51:58 +0000 (UTC)
Message-ID: <nrmd6u$imf$1@blaine.gmane.org>
References: <nrmbrl$hsk$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: tin/2.3.4-20160628 ("Newton") (UNIX) (FreeBSD/10.2-STABLE (i386))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think, the pagination should be turned off when the editor is being
> called.

... even if the `[-p|--paginate]` option is used explicitly. Is there a
case when pagination shouldn't be ignored with an editor?

`git -p -c core.editor=gvim config -e` works, but the pagination is not
effective.

`git -p -c core.editor=vim config -e` doesn't work and wants to be killed.

I've tested it on FreeBSD and Linux, have no idea, how it works on Mac or
Windows.

-- 
Mit freundlichen Grüßen,
Anatoly Borodin

