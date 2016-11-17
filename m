Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E06D1FE4E
	for <e@80x24.org>; Thu, 17 Nov 2016 10:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941853AbcKQKrS (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 05:47:18 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:36766 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1945958AbcKQKrQ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 17 Nov 2016 05:47:16 -0500
X-Greylist: delayed 928 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Nov 2016 05:47:15 EST
Received: from x4db0e6a4.dyn.telefonica.de ([77.176.230.164] helo=localhost.localdomain)
        by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
        iface 141.3.10.81 id 1c7Jyp-0005Gn-QA; Thu, 17 Nov 2016 11:31:45 +0100
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To:     Norbert Kiesel <nkiesel@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        git@vger.kernel.org
Subject: Re: [Bug?] git notes are not copied during rebase
Date:   Thu, 17 Nov 2016 11:30:43 +0100
Message-Id: <20161117103043.4835-1-szeder@ira.uka.de>
X-Mailer: git-send-email 2.11.0.rc0.85.ga45d488
In-Reply-To: <CAM+g_NvFhyReNREpTYKbXKm=8QmSH1tnrTCyFm9HusOnfAbCCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1479378705.
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1479379633.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I am currently a heavy user of rebasing and noticed that my notes
> don't get correctly applied, even if notes.rewrite.rebase is set
> explicitly to true (though manual says that is the default).

Setting 'notes.rewrite.rebase' is, as you mentioned, not necessary,
but not sufficient either.  See here, especially the second paragraph:

   notes.rewriteRef
       When copying notes during a rewrite, specifies the (fully
       qualified) ref whose notes should be copied. May be a glob, in
       which case notes in all matching refs will be copied. You may also
       specify this configuration several times.

       Does not have a default value; you must configure this variable to
       enable note rewriting.

       Can be overridden with the GIT_NOTES_REWRITE_REF environment
       variable.

Gábor

