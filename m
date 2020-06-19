Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F05DC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 02:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC6320890
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 02:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="fNxajsg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgFSCe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 22:34:57 -0400
Received: from mr85p00im-ztdg06011101.me.com ([17.58.23.185]:52267 "EHLO
        mr85p00im-ztdg06011101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729926AbgFSCe4 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Jun 2020 22:34:56 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jun 2020 22:34:56 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1592533693;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=Content-Type:From:Date:Subject:Message-Id:To;
        b=fNxajsg+6NsZYqo4QUIKFPg6kF6cF/IB8+sUJTOPkOKppL43G+tixctZX2TrbA7re
         QJlOmKx+rtImYLzMUQaSTRTmISL74b8e/zBK4DSV+1AvNRQ4b2yF+zTaJ6XIgzeV6g
         JdRi8dNRPlxsoWY417zRAvWFkRNaX/qo856NUfLe3GpU+S/N/g4WaRD8xVL7ni2xij
         oUi7DtgWCPgu3IlqAgFo1VKT5lVQcG+qtV5sYhEIz6W8orxPHUD38kMMOqoPUx5ivr
         +BCWtC8ZRN4NI3jRcSQUjp9wzFpWJkNxHDubydDdM2qTgV+DMMyg8bh4Kh6YpJhcMd
         kMzUKwIsQgfVQ==
Received: from [192.168.1.96] (cpe-172-112-139-148.socal.res.rr.com [172.112.139.148])
        by mr85p00im-ztdg06011101.me.com (Postfix) with ESMTPSA id BCAEA4A0620;
        Fri, 19 Jun 2020 02:28:13 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Russell Crume <rcrume22@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Thu, 18 Jun 2020 19:28:12 -0700
Subject: Re: [PATCH v2 0/2] Sparse checkout status
Message-Id: <0A824C69-253C-4F0F-B31B-9B82B6E5279A@icloud.com>
Cc:     dstolee@microsoft.com, git@vger.kernel.org, newren@gmail.com
To:     gitgitgadget@gmail.com
X-Mailer: iPhone Mail (17F80)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=269 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2004280000 definitions=main-2006190015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


