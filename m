Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3EF120229
	for <e@80x24.org>; Sun, 23 Oct 2016 11:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753760AbcJWLL7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 07:11:59 -0400
Received: from fw.sigpipe.cz ([213.192.55.98]:1452 "EHLO isis.sigpipe.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752767AbcJWLL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 07:11:59 -0400
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Oct 2016 07:11:58 EDT
Received: by isis.sigpipe.cz (Postfix, from userid 1001)
        id EA8211130A4CB7; Sun, 23 Oct 2016 13:03:38 +0200 (CEST)
Date:   Sun, 23 Oct 2016 13:03:38 +0200
From:   Roman Neuhauser <neuhauser@sigpipe.cz>
To:     git@vger.kernel.org
Subject: git clone --bare --origin incompatible?
Message-ID: <20161023110338.GA1486@isis.sigpipe.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hello,

what is the reason clone --bare prohibits --origin?

  % git clone --bare -o fubar anything anywhere
  fatal: --bare and --origin fubar options are incompatible.


-- 
roman
