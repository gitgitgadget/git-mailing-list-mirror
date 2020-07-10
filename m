Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TVD_SPACE_RATIO autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF33C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 01:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 683B820708
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 01:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="OeIWVxJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGJB72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:59:28 -0400
Received: from ms11p00im-qufo17281301.me.com ([17.58.38.50]:39970 "EHLO
        ms11p00im-qufo17281301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726615AbgGJB72 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 21:59:28 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jul 2020 21:59:28 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1594345901;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=From:Content-Type:Subject:Message-Id:Date:To;
        b=OeIWVxJfOSPlsZTjimYaY15yMl2G9oR1FgAH8SmApVl82A/7WvR5H+PwiQxlttecz
         PLEJ7a6MlqZi4LS5vhWhZzPQr7SnJ/C2KLsYMU5ZvohzAhW830kGvRYPvXvitCnzLq
         l3kOqaGs10EZ6b6wzuss9nR6nd2xeqvV0AH5jo2rruvWz1U9D5Dcy30BqyLEBkN9s/
         Hq77WLEUCuJKQ5IbrKbqWDpYF6xD/JXdBGgWk7igvdA8DWuXC8YYPF6s2FBGCqsOiL
         7bgPPrvwdwYhgO1F6mm86SSpHVsK8FROuHLTDZCH1XeGwKR2VhOqaYFPlNzAxozaIb
         E2WNRY4PZ2MpA==
Received: from [192.168.0.3] (unknown [177.236.51.111])
        by ms11p00im-qufo17281301.me.com (Postfix) with ESMTPSA id 3B6B6AC01F0
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 01:51:41 +0000 (UTC)
From:   jordy SP <audiorganiclucid@icloud.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: mailto:git@vger.kernel.org
Message-Id: <21920B96-EA2E-45BB-939D-A35A7691C19A@icloud.com>
Date:   Thu, 9 Jul 2020 18:51:39 -0700
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_11:2020-07-09,2020-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=1 suspectscore=52 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=1 clxscore=1011 mlxscore=1
 mlxlogscore=228 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2004280000 definitions=main-2007100007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

