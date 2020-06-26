Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AED6C433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 19:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595AE2070A
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 19:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgFZT30 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 26 Jun 2020 15:29:26 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:46304 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725768AbgFZT3Z (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jun 2020 15:29:25 -0400
X-Greylist: delayed 3082 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jun 2020 15:29:25 EDT
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05QIZejR023551;
        Fri, 26 Jun 2020 13:37:55 -0500
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
        by mx0a-00010702.pphosted.com with ESMTP id 31uusm8kmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 13:37:55 -0500
Received: from us-aus-exhub1.ni.corp.natinst.com (us-aus-exhub1.ni.corp.natinst.com [130.164.68.41])
        by us-aus-skprod3.natinst.com (8.16.0.42/8.16.0.42) with ESMTPS id 05QIbsJA029824
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 13:37:54 -0500
Received: from us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 26 Jun 2020 13:37:54 -0500
Received: from USAUSLT-XB7F4SC.ni.corp.natinst.com (172.18.68.32) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Fri, 26 Jun 2020 13:37:54 -0500
From:   Neil Stoddard <neil.stoddard@ni.com>
To:     <simon@bocoup.com>
CC:     <don@goodman-wilson.com>, <git@vger.kernel.org>,
        <gitster@pobox.com>, <sandals@crustytoothpaste.net>
Subject: Re: Rename offensive terminology (master)
Date:   Fri, 26 Jun 2020 13:37:53 -0500
Message-ID: <20200626183753.52288-1-neil.stoddard@ni.com>
X-Mailer: git-send-email 2.27.0.vfs.0.0
In-Reply-To: <'CAOAHyQyn_ow7_nCJ+Jorr76_=1=_kuBAD1KhqReqVfRQQbmgiw@mail.gmail.com'>
References: <'CAOAHyQyn_ow7_nCJ+Jorr76_=1=_kuBAD1KhqReqVfRQQbmgiw@mail.gmail.com'>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_10:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Would it be possible to get a summary of the current state of the
discussion?

In addition to the ongoing patchset to enable setting a different
default initial branch name:

1) Are the git maintainers still considering renaming the initial
   default branch to something else?
2) If yes, is there consensus among the maintainers on the name
   'main'?
3) If yes, how will this change be rolled out?  Will the change be
   delayed to align with a breaking release?
4) Are the maintainers waiting for more discussion or input from the
   community?  Are there voices you feel are yet to be heard?
