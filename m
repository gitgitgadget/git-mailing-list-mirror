Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TRACKER_ID autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF393C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 05:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D9F2070A
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 05:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhA0Fmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 00:42:35 -0500
Received: from st43p00im-ztdg10063201.me.com ([17.58.63.182]:54342 "EHLO
        st43p00im-ztdg10063201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236244AbhA0Ddr (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 26 Jan 2021 22:33:47 -0500
X-Greylist: delayed 2695 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jan 2021 22:33:47 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1611713289;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=Js13RnwWiqqzxrCQIlj8CE6HLO/wW6sexmxss80PRBHuGSMn/GyJv2/kJa+fOL85O
         IG4eJYxUDTNxExPPbNkWNiyQn24jVzmKUU4OPrh7dasVYCRs3WQlkyWaf9WAycPi7M
         GnAQg2CNWrkKEeXC1897a1+i0T56AKik+wdYod1bZXEoBL6YsoGBEwcd5fOHf9wp//
         Ml+pu9waYKc6ZzNcANqowwNV/jmIPowx5n4FjAAN9frXwUAIC3gYM/sAHv6vQ1na8q
         H8qG2l0XO7cDwWaYJhjthurLbdBTfRtLByAQKgDsntITYkawgP5xtPMEPAOg2SoB/N
         dOwFyqrdI/AlA==
Received: from [IPv6:2607:fb90:7e20:3ccd:c51b:333:49df:f321] (unknown [172.58.239.182])
        by st43p00im-ztdg10063201.me.com (Postfix) with ESMTPSA id A48335401A7;
        Wed, 27 Jan 2021 02:08:08 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Kimberly AntleyFree <kim.neil.2017@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Tue, 26 Jan 2021 21:08:05 -0500
Subject: c82a22c39cbc32576f64f5c6b3f24b99ea8149c7
Message-Id: <DBD79A7C-66AF-4ADF-A658-DBCDD6012664@icloud.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (18C66)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_11:2021-01-26,2021-01-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=484 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2101270010
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
