Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 747DC1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 23:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeH2DsH (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 23:48:07 -0400
Received: from mx.sdf.org ([205.166.94.20]:63544 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbeH2DsH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 23:48:07 -0400
Received: from sdf.org (IDENT:aedifex@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id w7SNrthl019137
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO)
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 23:53:55 GMT
Received: (from aedifex@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id w7SNrtHt023258
        for git@vger.kernel.org; Tue, 28 Aug 2018 23:53:55 GMT
Date:   Tue, 28 Aug 2018 23:53:55 +0000
From:   Tacitus Aedifex <aedifex@sdf.org>
To:     git@vger.kernel.org
Subject: avoid "Set preference list" during make test?
Message-ID: <20180828235355.GA10708@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While running `make test` on the git source tree I keep getting asked:

  Set preference list to:
    Cipher: ...
    Digest: ...
    etc...

Is there any way to turn that prompt off so that `make test` completes without 
any keyboard input?

//tæ
