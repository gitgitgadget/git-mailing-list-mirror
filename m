Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CC901FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 20:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbcHZU0h (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 16:26:37 -0400
Received: from mout.web.de ([212.227.17.12]:60707 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750869AbcHZUZw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 16:25:52 -0400
Received: from atze2.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0M5wrF-1atPqq3a5h-00xwLg; Fri, 26 Aug 2016 22:19:13
 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 0/2] Adjust the documentation to the unified "auto" handling
Date:   Fri, 26 Aug 2016 22:18:42 +0200
Message-Id: <20160826201842.28293-1-tboegi@web.de>
X-Mailer: git-send-email 2.9.0.243.g5c589a7
In-Reply-To: <xmqqpoowlgpv.fsf@gitster.mtv.corp.google.com>
References: <xmqqpoowlgpv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:hvsW3ATAXqiwxrVIHY2xZE0dfkYg2LtyKWqacVPj5JgLxXQg0Ro
 9Bd83ZX1NaKZxyci1BINaMA1Gs/u8h70RjansPGVCkRZjSqdG6xQMwwR5UCBDDWQtS4g4zM
 xF9yDKPjrp3NfLht9TWOruNzSKocPMPnZy4RWNwmNxvG7MJPRjl3PBEtT1CaJ2XIK9XeMRp
 c0eTIQ+pk2AYoSowmP0sw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ls1GuDqsdF8=:vxk1VFRHE2Ner5ymVuBbBl
 B1ZCYKfFQb/bMvz8btl/PNZfA9JtQJiapvyfrvK9WfhyfYzdFoa167lLBo+bjAMsY0ZgnvwkA
 YGcLYvcbkjo9dhfmP4qqrS0rfx2NOXyTDdGdgz92d5r82L+NYFu3EcFIgXkywvYPzQ+yHshOY
 45w/LUFpcERF2nplc9jZfE11jn28JhOIxcOVGjWrw5eo6UXHRUd1SKFR63DhokGAg50+AN/kq
 RU+0MKAkW8XdP1JFmk/cZZaSGQRuiB6OY6oTP8DyTlkpM41WF+Ii8uIsxLTgNqF2O5VZnMDM3
 cz4nOrav8QH8PE4Md2Fxsi32xUhavAQJYNOhi3shhSbnoow4bnQ2yR41Yd7d/M1PTaV3hGByM
 g1Px8ZMzLHs++5TU1wlqpwstrA20qYog3c7DAozaPJTm5qkWJNqwsYqW19JrRMbTa2D/rWJJK
 JhsquIlUVxllfsPaNmLbvDJksdg4ZNpEfZTj7HrJbV6aQDO7QSm3G+QakZb/WLm6QMRhyP7pD
 bQJOO+Izh4xKXiKl/fRM1pdT38xrDjMXr+l4slKll0If6TEg7tDvWk3kmKNnE40PKpMSiF4yz
 8W4y3pu1zMvk3LgwqElYHotnLhWsDqdKwGMPy99RMCSVODBAd/HqE2Bjwf7Jgij4v1KAvreKG
 zbNagfZ23l/6TC/qGKzCLHhmi9oipjFuwWPpqDHAd2w6IPVjWbgjf9A/3K0gDVFcr6FSmnM41
 ynWNaVoA4hUX9sbSXlOD1BMxKGMAR0FXm5kwPmcjy2GA9ruMU02fu5ePFQc4TaqmaNqLOD4Y9
 Sxq9mVz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Changes since v1:
- 1/2 is left unchanged
- 2/2 is re-written and should be more consistant to read.

Torsten Bögershausen (2):
  git ls-files: text=auto eol=lf is supported in Git 2.10
  gitattributes: Document the unified "auto" handling

 Documentation/git-ls-files.txt  |  3 +--
 Documentation/gitattributes.txt | 58 +++++++++++++++++------------------------
 2 files changed, 25 insertions(+), 36 deletions(-)

-- 
2.9.0.243.g5c589a7

