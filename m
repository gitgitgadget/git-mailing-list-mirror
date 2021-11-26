Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CAFC433FE
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 07:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359409AbhKZHqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 02:46:32 -0500
Received: from st43p00im-ztfb10063301.me.com ([17.58.63.179]:36258 "EHLO
        st43p00im-ztfb10063301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359311AbhKZHob (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Nov 2021 02:44:31 -0500
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 02:44:31 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1637911924;
        bh=8DpLVrZzr0/UZ191QjjbF3anKCuUEegJcV5Tpvc89d4=;
        h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
        b=pKWPwN6QglOqSF6UQcUVl3oAF4PfwsYMFnRfYLoxg3p4DP3OeZECL+Pyo9X7PPETF
         3W4IjKuCJBBwusEmr01nJY/YemaS3TR7ZbmspWpJGhEvWTMB0B0k3qG0GkASqQ4KGV
         5TyfRt2UOogmm1nBOVWvS9ApcRXaGqB77TSkUFTaM9KAoE7/AcAHiuoV1ALBs42AF9
         YmZgtfy8/Bsh0KJOf/yoFNXOZ1nlhTXES9sPfLGei6O1UNvAhC+0KEWHrU4jT0vXp5
         HnITaCIdN37SL+U4+bqQqJ4tfJKNNsdqWbtwR3ECo+0/4rmvcr/tQVMFBdBWQ1Ncb+
         JBKLNxF1JthFg==
Received: from smtpclient.apple (49.sub-174-251-209.myvzw.com [174.251.209.49])
        by st43p00im-ztfb10063301.me.com (Postfix) with ESMTPSA id D7F85A404D2;
        Fri, 26 Nov 2021 07:32:03 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Leon Dingman <dingboss69@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rebase, cherry-pick, revert: only run from toplevel
Date:   Fri, 26 Nov 2021 02:31:50 -0500
Message-Id: <1E49E0B6-7789-4CDB-AC85-5B9FE69361F8@icloud.com>
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
        newren@gmail.com
To:     peff@peff.net
X-Mailer: iPhone Mail (18H107)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-11-26_02:2021-11-25,2021-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=579 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2111260042
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fu

Done
