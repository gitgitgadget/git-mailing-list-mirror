Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB5A1F462
	for <e@80x24.org>; Fri, 31 May 2019 18:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfEaSCt (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 14:02:49 -0400
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:56658 "EHLO
        resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbfEaSCt (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 May 2019 14:02:49 -0400
Received: from resomta-po-05v.sys.comcast.net ([96.114.154.229])
        by resqmta-po-06v.sys.comcast.net with ESMTP
        id Wio4h6Lw5uZnZWlrchAw04; Fri, 31 May 2019 18:02:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1559325768;
        bh=FCH7QG/E6Fxya24GRmD6gOhCrI52HU/JCM8VpxcBuII=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=kbiJUU6n3BCRFj6bb0sDzZEev/8bhOaoEYzppwrdhFMaKyvuRpyI8qQTTLS17NVlA
         jbHFOBS2axUOemD1IotXSvYOppxKefkq8AesHP4zWlH+hNn4AUWSLzU9nRp1Umghrd
         7IK43ly2pp2e1RKkSN7kbVkCiziVd8OthsIR5bc/llkfy8E3FNJD9pwXIOz7o+ElQz
         w+WtJzVEd48gUsSEnwRpzqIgPXKeGNMXkyJxQmiX+Wiq8Bp+8REiC2MgkQpvBgoWVJ
         B5OV6JVHpfK9EsZHYLBDOcCugvsCNu4M23gTbmRDbdnL1UHG6eEpWUX399HSGHLiiA
         Fw4q9kBd+MNYQ==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:a4f1:9a8c:7e29:36eb])
        by resomta-po-05v.sys.comcast.net with ESMTPSA
        id WlrXhy1XRDlddWlrchMhYc; Fri, 31 May 2019 18:02:48 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Fri, 31 May 2019 11:02:43 -0700
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     emilyshaffer@google.com, matvore@google.com
Subject: [PATCH 0/1] Trivial fix: make a user-facing error localizable
Message-ID: <20190531180243.GA7663@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a patch that I'm separating from a longer patchset previously sent.

Thanks,

Matthew DeVore (1):
  list-objects-filter-options: error is localizeable

 list-objects-filter-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.17.1

