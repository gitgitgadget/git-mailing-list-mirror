Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B09FC2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004E820801
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="QLbakE4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgDJRZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:25:14 -0400
Received: from st43p00im-ztfb10061701.me.com ([17.58.63.172]:51941 "EHLO
        st43p00im-ztfb10061701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbgDJRZN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Apr 2020 13:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1586539513;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        h=Content-Type:From:Date:Subject:Message-Id:To;
        b=QLbakE4llm+ptKfAnTccRjdc44Q48PKEYysF0lSI9cCFUlJKWATLvMhXNihVhZCdF
         rn7SMOic6xnDooXH/MDhcIQ3MMltUk686qnfGGza3id2Ysy0t8Xdb2Pp9N5EZyT9g1
         t5BLikhK2HUM/xlUBapaPab9ByQ1jx7z6aJ25Zh7k2m8MyA+nLv3E8qxqlmMiPYssA
         M0W5CHnyaJBOuIw9O0sxj3i8HQfDZDDiZ1nFiRUdJ70hg1ha5NBtXr3mEsUrNgmQNw
         /tPbJ8vKJYLxq0oxAgURQY7BUKX0pfA12B+Hwm/hUrtp5rFrA/85dA0YHHGLFlN7xf
         VRW1y4znrco1w==
Received: from [192.0.2.1] (unknown [8.21.10.21])
        by st43p00im-ztfb10061701.me.com (Postfix) with ESMTPSA id 09D76AC03F0;
        Fri, 10 Apr 2020 17:25:13 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Lia Rosas <rosaslia360@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Fri, 10 Apr 2020 13:25:11 -0400
Subject: Re: [PATCH] rebase -i: mark commits that begin empty in todo editor
Message-Id: <2457D864-71A9-4075-AB2B-0CBD9C752A15@icloud.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, newren@gmail.com,
        phillip.wood123@gmail.com
To:     gitgitgadget@gmail.com
X-Mailer: iPhone Mail (17D50)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-04-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=337 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2004100139
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
