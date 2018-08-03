Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,URI_HEX shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E2371F597
	for <e@80x24.org>; Fri,  3 Aug 2018 12:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeHCOfb (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 10:35:31 -0400
Received: from n2.nabble.com ([162.253.133.85]:61087 "EHLO n2.nabble.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbeHCOfb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 10:35:31 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Aug 2018 10:35:31 EDT
Received: from n2.nabble.com (localhost [127.0.0.1])
        by n2.nabble.com (Postfix) with ESMTP id AF90B5241143
        for <git@vger.kernel.org>; Fri,  3 Aug 2018 05:29:44 -0700 (MST)
Date:   Fri, 3 Aug 2018 05:29:44 -0700 (MST)
From:   dxt29 <duxiutao@gmail.com>
To:     git@vger.kernel.org
Message-ID: <1533299384683-0.post@n2.nabble.com>
In-Reply-To: <alpine.DEB.2.00.1311272237400.17037@tvnag.unkk.fr>
References: <5291F70A.7070508@googlemail.com> <20131124133356.GA3507@sigill.intra.peff.net> <529214D7.1030203@googlemail.com> <20131124155439.GA8047@sigill.intra.peff.net> <52922A22.2090109@googlemail.com> <20131125063945.GA16313@sigill.intra.peff.net> <alpine.DEB.2.00.1311250815150.27300@tvnag.unkk.fr> <20131125143213.GA22642@sigill.intra.peff.net> <20131125144321.GA23779@sigill.intra.peff.net> <alpine.DEB.2.00.1311272237400.17037@tvnag.unkk.fr>
Subject: Re: [curl PATCH 2/2] ignore SIGPIPE during curl_multi_cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have curl 7.35.0 installed on my ubuntu14.04, version infos is as below


I have recompiled git against openssl. the git version is 1.9.1. I
encountered this error "error: git-remote-http died of signal 13" when I
issue `git clone http://github.com/tensorflow/tensorflow.git`. Should I
upgrade curl to a higher version? Or is there other easy solutions?

Thanks.



--
Sent from: http://git.661346.n2.nabble.com/
