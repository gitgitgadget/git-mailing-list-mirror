X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 0/2] Generate saner automatic patch names
Date: Tue, 07 Nov 2006 07:57:10 +0100
Message-ID: <20061107065710.10728.85618.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=fixed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 7 Nov 2006 06:59:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31047>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhKvm-00061P-Gu for gcvg-git@gmane.org; Tue, 07 Nov
 2006 07:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752653AbWKGG7X convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006 01:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753200AbWKGG7X
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 01:59:23 -0500
Received: from mxfep03.bredband.com ([195.54.107.76]:1259 "EHLO
 mxfep03.bredband.com") by vger.kernel.org with ESMTP id S1752653AbWKGG7X
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 01:59:23 -0500
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84]) by
 mxfep03.bredband.com with ESMTP id
 <20061107065921.MWTL25623.mxfep03.bredband.com@ironport2.bredband.com> for
 <git@vger.kernel.org>; Tue, 7 Nov 2006 07:59:21 +0100
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO
 yoghurt.hemma.treskal.com) ([83.227.180.148]) by ironport2.bredband.com with
 ESMTP; 07 Nov 2006 07:59:21 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
 yoghurt.hemma.treskal.com (Postfix) with ESMTP id CA5884C04D; Tue,  7 Nov
 2006 07:59:20 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

This series fixes some quirks in the automatic patch name generation.
In particular, it limits the length of names, and makes sure that all
callers generate unique names so that name clashes won't be a problem.

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
