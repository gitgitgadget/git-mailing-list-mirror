Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA94C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 02:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EE52063A
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 02:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="GruJpdhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390204AbgDCCrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 22:47:46 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42]:36580 "EHLO
        pv50p00im-zteg10011501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731842AbgDCCrq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Apr 2020 22:47:46 -0400
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Apr 2020 22:47:46 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1585881554; bh=Bw5natrXGBtiREOBwzu34tcW8AJ5JeqGFPFPUfczy/k=;
        h=To:From:Subject:Message-ID:Date:Content-Type;
        b=GruJpdhUO7nSTG+FvJekWLj7h8RZ46boGKtG/QmEbg58MLpdHhFFzMV3bQt1CC9kG
         Cz8ZrIqliZ2FPdaPG5twXKEh0tiSeH3zYgalU/ABfW8i3AU7vqEh/nNfIEb7zmAdgY
         bk3X32R142kdT6oVRklV4pbzqR7AbXEVsaJ/1PXtIZ6snEBd+o8WVOyinlaDyeMl/X
         MvN+JqjuMHzsNy69mRZP4XxpPlbz2tKtU+cq+26yUHq3Rsyqvqri3fcrrIawbrxUyZ
         gQqJ8KGLkVlsM4PNHYsJguzARFjhrY+uEBPvLy8zxKyBSXERTsuAkwGOv8bQQwrw1y
         MtbNHe+aocdew==
Received: from [10.0.0.7] (unknown [110.7.216.3])
        by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 91CB5B0011D
        for <git@vger.kernel.org>; Fri,  3 Apr 2020 02:39:13 +0000 (UTC)
To:     git@vger.kernel.org
From:   number201724 <number201724@me.com>
Subject: The closing bracket is missing.
Message-ID: <8d439c14-6b39-bbb7-a558-61c1e79ff1f3@me.com>
Date:   Fri, 3 Apr 2020 10:39:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-04-02_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=576 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2004030020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

command-list.h:53:69: error: expected ‘}’ before ‘;’ token
    53 |  { "git-apply", N_("Apply a patch to files and/or to the 
index"), 0};

command-list.h  The closing bracket is missing. In the master branch.

