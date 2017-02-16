Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14C442013C
	for <e@80x24.org>; Thu, 16 Feb 2017 05:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750744AbdBPFFm (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 00:05:42 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33002 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbdBPFFm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 00:05:42 -0500
Received: by mail-pf0-f182.google.com with SMTP id c73so2628841pfb.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 21:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PnqMYliJRjl5ldU/E6b7UfHLFOigoM3dhh0stiqOuZM=;
        b=D0ZVunayejz9ywmIG1UKPX23XDxV9FAAZ9zHKyjNsz1hNhuYKYQX9iBiBn/F93rGij
         LakmJfq+eXC+Gc+LVeufG84lQqBD7ZTKSFcXDjY9+AugwPXJmPMB+bFl+zhwRJFSVW5R
         Y5ceQYlOSD7fXb1jkp7/0IobN1QLrSo9MQ4z54EnqTPDrVhsvAVJ144Pgn97y4Pjtk9D
         Lvm9mzSc7JYzW6+YWuj+LIlLlFiu0PrwQOuoebOTuQG0fHUSc9RW124wUVPzCPMn59cV
         erM370xN2cLedpnOG5aGjhkOAlrkMgX+wa/9wriKXlP8ZbxermLmyVerxE/X1irHD5XD
         GWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PnqMYliJRjl5ldU/E6b7UfHLFOigoM3dhh0stiqOuZM=;
        b=KXfy6/TVR33roR9iVjW031zjTwFIrxOtoj2b4KjuMZ+U/8z1ViVTlOu8gBVzKWSCt5
         9otOtIAVJFmqUT+V1fv6eFfxJAO8uq14T/dAcFEG03DAxGnTUAcM9v6ZLRMYABD9FDe3
         bfaouhI1+RqBn/cPNG3qb+YwBI1CRDkJSSVQuTGoEnvsESNiRa5qB+ErNUisI9cqDofX
         6JovzPOYlG3INoZ2v0SU+mAnDrBtb0LHovC8sgI9njuDjpKmTh4dRnUFTunCb12aUJrr
         Ej6pGEHdlilxL8camAJ7P5cbxkncOu/w6AO/xXnXCLbsHodBwVwKfhQsa4VxXU5YW1Pw
         b9TQ==
X-Gm-Message-State: AMke39nrQETsL4NNm5BFf/IgOoLwJbruxn3O36GXWT8PULfzFeWDIap/kL2bPoIAWoa6ng==
X-Received: by 10.99.36.7 with SMTP id k7mr462326pgk.199.1487221541272;
        Wed, 15 Feb 2017 21:05:41 -0800 (PST)
Received: from localhost.localdomain (x084097.dynamic.ppp.asahi-net.or.jp. [122.249.84.97])
        by smtp.gmail.com with ESMTPSA id k76sm10398835pfg.42.2017.02.15.21.05.39
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 21:05:39 -0800 (PST)
From:   David Pursehouse <david.pursehouse@gmail.com>
To:     git@vger.kernel.org
Cc:     David Pursehouse <dpursehouse@collab.net>
Subject: [PATCH 0/1] config.txt: Fix formatting of submodule.alternateErrorStrategy section
Date:   Thu, 16 Feb 2017 14:05:34 +0900
Message-Id: <20170216050535.64593-1-david.pursehouse@gmail.com>
X-Mailer: git-send-email 2.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Pursehouse <dpursehouse@collab.net>

Fixes a minor glitch in the formatting of the documentation.

David Pursehouse (1):
  config.txt: Fix formatting of submodule.alternateErrorStrategy section

 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.11.1

