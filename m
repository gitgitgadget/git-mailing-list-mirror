Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9B12021E
	for <e@80x24.org>; Tue, 15 Nov 2016 13:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932337AbcKONlD (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 08:41:03 -0500
Received: from [195.159.176.226] ([195.159.176.226]:39818 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbcKONlC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 08:41:02 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1c6dyQ-0000MX-VP
        for git@vger.kernel.org; Tue, 15 Nov 2016 14:40:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Christian Neukirchen <chneukirchen@gmail.com>
Subject: Re: git shortlog vs. stdin
Date:   Tue, 15 Nov 2016 14:39:59 +0100
Message-ID: <877f84dfps.fsf@gmail.com>
References: <20161115130418.GA28847@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
In-Reply-To: <20161115130418.GA28847@inner.h.apk.li> (Andreas Krey's message
        of "Tue, 15 Nov 2016 14:04:18 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Krey <a.krey@gmx.de> writes:

> Bug or feature?

Documented feature, but you're holding it wrong ;)

       If no revisions are passed on the command line and either standard
       input is not a terminal or there is no current branch, git shortlog
       will output a summary of the log read from standard input, without
       reference to the current repository.

(Note that you can use shortlog ala "git log --pretty=short | git shortlog")

-- 
Christian Neukirchen  <chneukirchen@gmail.com>  http://chneukirchen.org

