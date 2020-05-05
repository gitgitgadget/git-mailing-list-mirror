Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E828C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 11:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533C4206A5
	for <git@archiver.kernel.org>; Tue,  5 May 2020 11:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="oFgvzCH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgEELzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 07:55:52 -0400
Received: from st43p00im-zteg10071901.me.com ([17.58.63.169]:49491 "EHLO
        st43p00im-zteg10071901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbgEELzv (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 07:55:51 -0400
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 May 2020 07:55:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1588679360;
        bh=L1/OItWd/BFbnR8rQL/kNv1oZK7rbb67jy8kzUqPMtM=;
        h=Content-Type:From:Date:Subject:Message-Id:To;
        b=oFgvzCH96iQSWJ6ds0Cmrv2SvIzCENjbDjzuUg/jn2KJTfv5Gvce/DO+g6WvV5SUq
         /LfDz2stB9seomFaAv85GxSaD3LIRGHRwlNzjL7XbtjGY9c5yZdTNxVGDhxz+whwiO
         8A6I8BOqxUeVfbE/NZTiMeo95Lf1dlrRxI7rJ5E5+h7soQ2l3mUpxDOGdJvbMkvNRY
         qRo/DbAGS2h4IBeZzR9TP+qkAdmWjeTApvNwAl1l+73fuOY7aIK/sshiZkHj5MHyXs
         p7iuYuFxJDTmYXQEjvkQ1B1Dc8TFfSH7RbXO60ahuDhkUJoLXx0QrKF0mGF7irNgyu
         zWst+rtjD60qg==
Received: from [192.168.178.38] (cgn-213-196-212-242.nc.de [213.196.212.242])
        by st43p00im-zteg10071901.me.com (Postfix) with ESMTPSA id 853D9D816D0
        for <git@vger.kernel.org>; Tue,  5 May 2020 11:49:20 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Edona Demiri <donabeli@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Tue, 5 May 2020 13:49:18 +0200
Subject: Moodle Anmeldung klappt nicht???
Message-Id: <01A717E8-32A0-4212-AEEE-F3E06448D7B8@icloud.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (17D50)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_07:2020-05-04,2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=305 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2002250000 definitions=main-2005050096
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Von meinem iPhone gesendet
