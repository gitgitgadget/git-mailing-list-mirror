Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1581FAE2
	for <e@80x24.org>; Tue, 27 Mar 2018 18:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeC0Sqt (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 14:46:49 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54049 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750937AbeC0Sqs (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Mar 2018 14:46:48 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C99EC2140B;
        Tue, 27 Mar 2018 14:46:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 27 Mar 2018 14:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        aaronjgreenberg.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=c8Kg872wgzokkwjh0
        RORViz0OWSF+zWcgaG/DvbP+Eo=; b=c8PEfhu1bf8vxJIC6wqjMlE3QG8gjjFlq
        pqgF2lLBrK1PSVHO4mqULpBfKoAsMLTA89JYPg2j5e23PIUZUk4shjklxCA0pxCP
        acuAJllaHAQD5UehNLLhl4PL6Ea5IT2a3F5MK7jaOcdWn+jB7lvNNzjPaA6VhDTX
        hbLC3Bg7sXn9ZW8Q1k+DJXXRt9VB3qNzXCtL7xiOb06HiPNEaP3DvOo+iK3XSBd2
        7AGyuE62DiHFEtcmkbBv72abbzbFdGqJHB2O3tspwGAEZrPJ5U4F7XpvlsZH1HTf
        FBMnZPD7e1LDHWbrW13DMRL6OMm334pidIQbNN4wnrKgW/BTH4xew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=c8Kg872wgzokkwjh0
        RORViz0OWSF+zWcgaG/DvbP+Eo=; b=QErr5DorvQnjIslcnBkUkK/Mpbm2I3KRQ
        l+0vsEqxb/V3uQz69B1tdw9Sq6aReS85a7zXCdBfKrIdk5yYa7uW2xBkQ842YMVb
        clLCGqIiOBH4UPLNDWQYomQIwCjMWka5nUGE4vAtbBsAUF/cgXaVyvZn0woizkzv
        6Oy+0rusRBnmKPXEwokdlyY0a2DS+6NK0kNUlcZ7p3zd7M/WiHMq8vcbU06LNhyx
        FVskdrWxKoPl2ntPiVnZuuxxy4t8sR0YfH6zf5E5QhAqxAtg8hZHDjqhh/0g0tAb
        wLxPG0CyqoPaxpbJZsQO5hjmp/ismRappoM6Yitmy1bzLRUmxZfZg==
X-ME-Sender: <xms:l5G6WqZXdbz6R4Wj1niTgt-Paih_8PDkddmUaW44l6LuHvnPXErCbg>
Received: from localhost.localdomain (unknown [159.203.64.218])
        by mail.messagingengine.com (Postfix) with ESMTPA id 80BBBE50B1;
        Tue, 27 Mar 2018 14:46:47 -0400 (EDT)
From:   Aaron Greenberg <p@aaronjgreenberg.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] branch: implement shortcut to delete last branch
Date:   Tue, 27 Mar 2018 18:46:29 +0000
Message-Id: <1522176390-646-1-git-send-email-p@aaronjgreenberg.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the approvals listed in [*1*] and in accordance with the
guidelines set out in Documentation/SubmittingPatches, I am submitting
this patch to be applied upstream.

After work on this patch is done, I'll look into picking up where the
prior work done in [*2*] left off.

Is there anything else that needs to be done before this can be
accepted?

[Reference]

*1* https://public-inbox.org/git/1521844835-23956-2-git-send-email-p@aaronjgreenberg.com/
*2* https://public-inbox.org/git/1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com/

