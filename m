Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA45A1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeH2BIl (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:08:41 -0400
Received: from mailsrv.ikr.uni-stuttgart.de ([129.69.170.2]:38048 "EHLO
        mailsrv.ikr.uni-stuttgart.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727098AbeH2BIl (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Aug 2018 21:08:41 -0400
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Aug 2018 21:08:40 EDT
Received: from netsrv1.ikr.uni-stuttgart.de (netsrv1-c [10.11.12.12])
        by mailsrv.ikr.uni-stuttgart.de (Postfix) with ESMTP id 853CF19C002D
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 23:05:29 +0200 (CEST)
Received: from ikr.uni-stuttgart.de (ingress2-c [10.11.14.11])
        by netsrv1.ikr.uni-stuttgart.de (Postfix) with SMTP id 6D0BA1A205CE
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 23:05:29 +0200 (CEST)
Received: by ikr.uni-stuttgart.de (sSMTP sendmail emulation); Tue, 28 Aug 2018 23:05:29 +0200
From:   Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
Organization: University of Stuttgart (Germany), IKR
To:     git@vger.kernel.org
Subject: Trivial enhancement: All commands which require an author should accept --author
Date:   Tue, 28 Aug 2018 23:05:28 +0200
User-Agent: KMail/1.9.10 (enterprise35 20140205.23bb19c)
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201808282305.29407.ulrich.gemkow@ikr.uni-stuttgart.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

A trivial enhancement request:

All commands which require that the author is set (and complain if
it is not set) should accept the option --author.

At least the command stash does not accept this option. We are using
git version 2.17.1 (Ubuntu 18.04).

Thanks for the great work!

Best regards

-Ulrich

-- 
| Ulrich Gemkow
| University of Stuttgart
| Institute of Communication Networks and Computer Engineering (IKR)
