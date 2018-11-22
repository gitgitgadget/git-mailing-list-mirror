Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 380B11F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 06:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeKVRRJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 12:17:09 -0500
Received: from mxb2.seznam.cz ([77.75.76.89]:14476 "EHLO mxb2.seznam.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbeKVRRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 12:17:09 -0500
Received: from email.seznam.cz
        by email-smtpc10a.ng.seznam.cz (email-smtpc10a.ng.seznam.cz [10.23.11.45])
        id 60ac7afe727e899560b8e159;
        Thu, 22 Nov 2018 07:39:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1542868747; bh=CHAWGmyzvGg8LN0UHI154HVdbg9jS1dgADEAPnIsvN4=;
        h=Received:From:To:Subject:Date:Message-Id:Mime-Version:X-Mailer:
         Content-Type:Content-Transfer-Encoding;
        b=jjVncjgPNJaSjB2Xha1hPz/aWOr4pz+9hBLS6rVqNIn3crXa6LPbFq4WWcDRyKI5k
         bTtjFNuKIcSj5qpvChDOfj6q9REOrYsAqMDdXERRVaKXrYMKFrMxRt+ZWumvdHe2B6
         ZpoY5p8PRx6aZKfe9RcyVUxyXYyneCxGPqFn8/pI=
Received: from unknown ([::ffff:194.213.38.186])
        by email.seznam.cz (szn-ebox-4.5.346) with HTTP;
        Thu, 22 Nov 2018 07:39:05 +0100 (CET)
From:   "Mgr Georg Black" <georg.black@seznam.cz>
To:     <git@vger.kernel.org>
Subject: How to propagate critical fixs from master to develope branch.
Date:   Thu, 22 Nov 2018 07:39:05 +0100 (CET)
Message-Id: <FTG.5ClN.5saZnXxVpgT.1Rzay9@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.0.42)
X-Mailer: szn-ebox-4.5.346
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone.I red git manual but I can't figure out how to propagate cr=
itical change from master branch to long live develop branch. I red chapte=
r about rebasing that I think could solve it but at the end of this chapte=
r is written that it's not recommended for pubic repositories. I don't kno=
w how to do it without merging develop branch to master.
I'll appreciate list of orders very much. :-)
Thanks for any info or link.
GB

