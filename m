Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8A191F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 15:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJFWSD (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 18:18:03 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:50002 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727202AbeJFWSD (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 Oct 2018 18:18:03 -0400
X-IronPort-AV: E=Sophos;i="5.54,349,1534802400"; 
   d="scan'208";a="349885534"
Received: from 89-157-201-244.rev.numericable.fr (HELO hadrien) ([89.157.201.244])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2018 17:14:22 +0200
Date:   Sat, 6 Oct 2018 17:14:22 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     git@vger.kernel.org
Subject: git log -S or -G
Message-ID: <alpine.DEB.2.21.1810061712260.2402@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Git log -S or -G make it possible to find commits that have particular
words in the changed lines.  Sometimes it would be helpful to search for
words in the removed lines or in the added lines specifically.  From the
implementation, I had the impression that this would be easy to implement.
The main question would be how to allow the user to specify what is
wanted.

thanks,
julia
