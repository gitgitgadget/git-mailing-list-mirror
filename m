Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3A961F462
	for <e@80x24.org>; Thu, 13 Jun 2019 16:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392601AbfFMQna (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 12:43:30 -0400
Received: from mail.farhan.codes ([155.138.165.43]:57709 "EHLO
        mail.farhan.codes" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbfFMGiI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 02:38:08 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jun 2019 02:38:08 EDT
Received: from mail.farhan.codes (rainloop [172.16.0.4])
        by mail.farhan.codes (Postfix) with ESMTPSA id C2C93F338
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 02:32:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=farhan.codes; s=mail;
        t=1560407523; bh=dryVvXFSZ9hSF9zPPVrNJHsv3uLBjLktaLbZF6mzWqc=;
        h=Date:From:Subject:To;
        b=pxMTG0TiyV8wCVETbfYoCg4D3URbJI94wnGcjEiBEPnZ7LWiFJTMVjba++pl33A9M
         TYjp8fxvoYKA7VcDYff85O6kKPXSAH/e4gTrXLVCBTBLhak0d4An9FdwL1oJo5yQx/
         Df3Vrj8QtPI4gOqOm88Zv1cEY5lQBy6BGsu668LQ=
MIME-Version: 1.0
Date:   Thu, 13 Jun 2019 06:32:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "Farhan Khan" <farhan@farhan.codes>
Message-ID: <c7c9012143e0818d332d0a9967c1a3e6@farhan.codes>
Subject: Understanding last ~28 bytes of index file
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,=0A=0AI am trying to understand how the index (.git/index) file wo=
rks. When looking through extensions, it loops until it reaches the last =
28 bytes (SHA size + 8). This is referenced here. https://github.com/git/=
git/blob/master/read-cache.c#L1933=0AWhat do the last 28 bytes consist of=
? Where in the source are bytes written?=0A=0AI am trying to understand h=
ow to reproduce the index file and am not sure how this part works.=0A=0A=
Thank you,=0A---=0AFarhan Khan=0APGP Fingerprint: 1312 89CE 663E 1EB2 179=
C  1C83 C41D 2281 F8DA C0DE
