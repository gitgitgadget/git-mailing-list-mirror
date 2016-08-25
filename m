Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD1472018E
	for <e@80x24.org>; Thu, 25 Aug 2016 15:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757043AbcHYPn3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 11:43:29 -0400
Received: from mout.web.de ([212.227.17.12]:60724 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755716AbcHYPn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 11:43:27 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MV4TZ-1bdryk01Yz-00YTJU; Thu, 25 Aug 2016 17:42:55
 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 0/3] Update eol documentation
Date:   Thu, 25 Aug 2016 17:52:55 +0200
Message-Id: <20160825155255.28929-1-tboegi@web.de>
X-Mailer: git-send-email 2.9.3.599.g2376d31.dirty
In-Reply-To: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:n8Z7GFKZ0ftSvOITuL1fjh8WaiDUPNvDNKsn6zXhGyGcn23ac0F
 MKKYwzYOo+IOGu7lTgdNMIP6EM3SssYz1lr1waPJwZU5Di5C2B1AX3XptArS8itHKmcI0DP
 N3135N2h/fzfURSsGf+jcpL9MJWOemT6/OcRJ6tTc+aGwHhZ0B2KswTiTg1TaH0gJA+auXj
 NhIGbs1bjRpw2idSmt5sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HFg47W9bx7c=:OXS/shgG3a4Js18YI4J4QC
 8XXcchMdhwZ9dUfQLaSSy2OW5ejfPDgwuqIKL6ZQLovNiXlW4Yz12T0NBRc36cPhzLFMcBiVv
 MDqVZe6T6I7mrNT4SmJaePkQjHUxxsutxjclqO3fNdBzoV3YA4F7KjDONE0vvplzXOpjRZeBO
 x21ir0ZfnAe4++PwBM39bHj8QLWYY9nHwnK945TBWTatMhk7iJBMBn/oN1C8G0qFroGkuGI8p
 cvSJyHmIw3Gcb2K2eqW2eJ33HLx1qc1HOTDZ6Y1qC3k+to/F0k4cBAUhL9OsrVhgM+3DonPYc
 XSwxciOWV7TqVLzjo+N71lfC+PbevwoYxsvM/vhvH8D2ijPlAk3o62NjNfZ7CVUnzrLaDy7dD
 +3d1LpqYtF/DEN/tcdsGxGSKFpQtKoKhHeBNI4FeGGfUA5a/96SBeWkKtPohxS10oX+z5USIe
 NF4BQl3DJrlgBX7ifzM40V1TfpsSNX3QXPvJmPu1lEDSEhpHQmJZWN04mdb69v06TYVJ3nfWK
 5YPBoRPUDNVdxmtJRxnDrPiVLWVuFRizg/JhNYy7ptr/92r2JCowvkcl/TUjrPpxHRPEVbs2h
 Ag3wjR6bEzxXySNAFqjByCp89sfAWwHGbQ3uKuj2K3ngsfxs98ZsucCkCAQXK2wcNv4tTWxTc
 I9zhkGIE2D0gXMnaji9HIfxpjcHN/nyx/zagEbi76dlqevbbpUUCoir/du0PEx8s0Q0xHXONh
 gnuojihwztMeAa9aQkgXtgkknApC+WWf117OoPoyzD/C9TyA+5X4tksBwwEyaw2nrRHBYvZbM
 LypErlF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Sorry for posting this so late:
While reviewing another patch I realized that the eol related
documentation was not updated as it should be.

Torsten Bögershausen (2):
  git ls-files: text=auto eol=lf is supported in Git 2.10
  gitattributes: Document the unified "auto" handling

 Documentation/git-ls-files.txt  |  3 +--
 Documentation/gitattributes.txt | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.9.3.599.g2376d31.dirty

