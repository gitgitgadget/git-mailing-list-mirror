Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 918641F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 21:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbdFEVlM (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 17:41:12 -0400
Received: from mail.pdinc.us ([67.90.184.27]:56762 "EHLO mail.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbdFEVlL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 17:41:11 -0400
X-Greylist: delayed 921 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jun 2017 17:41:11 EDT
Received: from blackfat (five-58.pdinc.us [192.168.5.58])
        (authenticated bits=0)
        by mail.pdinc.us (8.14.4/8.14.4) with ESMTP id v55LPno9002584;
        Mon, 5 Jun 2017 17:25:49 -0400
Reply-To: "Hector Santos" <winserver.support@winserver.com>,
          <git@vger.kernel.org>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "'Hector Santos'" <winserver.support@winserver.com>,
        <git@vger.kernel.org>
References: <5935C999.5060801@winserver.com>
In-Reply-To: <5935C999.5060801@winserver.com>
Subject: RE: Git "Keeping Original Dates"
Date:   Mon, 5 Jun 2017 17:25:48 -0400
Organization: PD Inc
Message-ID: <1C2B896999CB4549BCAC61EB369E932E@blackfat>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdLeQXJb14+fWVUNT+enP/RzxIjayAAAHBOA
X-MimeOLE: Produced By Microsoft MimeOLE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Hector Santos
> Sent: Monday, June 5, 2017 5:14 PM
> 
> I'm implementing GIT.  If there an option or compile/version that "keep"
file timestamps?

That is not in the tree data structure, see below.

root@blackfat /projects/tipsoftheday
$ git cat-file -p head
tree 4ca3c2a853c8e817d7de8563c331899cace8ee85
parent 2a33f293df6df0d3978612e41fb1ecd52e2450a5
author Jason Pyeron <jpyeron@pdinc.us> 1496424815 -0400
committer Jason Pyeron <jpyeron@pdinc.us> 1496424815 -0400

add JDK to CM

root@blackfat /projects/tipsoftheday
$ git cat-file -p 4ca3c2a853c8e817d7de8563c331899cace8ee85
040000 tree 76094b81b3877b5b27cd4fe518fa0708af3cefed    admin
040000 tree c66a88871c285e1485f92be0f8fa47185d94d0b3    client
040000 tree 460495af209a580e65b5d0b38132d774ddb283b7    database
040000 tree 264b191b036180039f3fd8c5d56c2b6800cb2ca2    doc
040000 tree dd128195971f7bafa56371aa6027d7c6bc80f351    middleware
040000 tree 7861fd39923950d501d4e39aeac4762f7daaca6b    reports
040000 tree 2ad3dedf0313ae775321c88c53741a4b4a7e87b0    tools

I wish it was an allowable extension, the date could be between the mode and
object type. 

v/r,

Jason Pyeron

