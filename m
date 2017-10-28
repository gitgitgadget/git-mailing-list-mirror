Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 385112055E
	for <e@80x24.org>; Sat, 28 Oct 2017 12:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbdJ1MtK convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 28 Oct 2017 08:49:10 -0400
Received: from mail2.pdinc.us ([67.90.184.28]:42556 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbdJ1MtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 08:49:09 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id v9SCn8HW006586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 08:49:08 -0400
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Subject: Rules for backup discussion
Date:   Sat, 28 Oct 2017 08:49:08 -0400
Organization: PD Inc
Message-ID: <C29FBE3637EA47B9AEDD7895339AB8C8@blackfat>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdNP6yVhpNpARM+ERQOD6BlaluCrkQ==
X-MimeOLE: Produced By Microsoft MimeOLE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I would like to efficiently backup my project directories.

I am thinking that the backup of a git enabled project should only backup the following sets of files:

Files under .git/
The results of git clean -ndx
The results of git status

Does this make sense? Is there a less expensive way to calculate the backup file set? I ask because sometime git status takes a long time.

-Jason

