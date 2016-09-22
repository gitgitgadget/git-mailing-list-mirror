Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98D0B1F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 19:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966394AbcIVTDc (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 15:03:32 -0400
Received: from [195.159.176.226] ([195.159.176.226]:38389 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S966387AbcIVTD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 15:03:26 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1bn9HB-00032m-Ac
        for git@vger.kernel.org; Thu, 22 Sep 2016 21:03:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: Bug? Short command line options
Date:   Thu, 22 Sep 2016 19:03:00 +0000 (UTC)
Message-ID: <ns19t4$s0t$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: tin/2.3.4-20160628 ("Newton") (UNIX) (FreeBSD/10.2-STABLE (i386))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,


is there a good reason why

	git fetch -vpnf

works like

	git fetch -v -p -n -f

and
	
	git commit -avem msg

works like

	git commit -a -v -e -m msg

etc etc, but

	git log -wWp

says

	fatal: unrecognized argument: -wWp

?

-- 
Mit freundlichen Grüßen,
Anatoly Borodin

