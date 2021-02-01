Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAA6C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 14:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD9F164E46
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 14:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhBAO1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:27:07 -0500
Received: from mr85p00im-hyfv06011301.me.com ([17.58.23.184]:50401 "EHLO
        mr85p00im-hyfv06011301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhBAO05 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Feb 2021 09:26:57 -0500
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Feb 2021 09:26:57 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1612189142; bh=x79ZqwEkfOgNduy18O2t6fUGZxNCry5bs2Fbcsc+6os=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=x4ojQWgMbjgsdGeKAQ6j7NFvL/6ILFl+oQNwK7j84LfQcHAFY15CPPe/zktXu11v6
         k45i23aF3hoMnNpMUNlzZ2MGgZ0q3iEHvwLAZqqlid4gFj3GkMQjusz/ByG3TD2DEq
         1Sut2HS+d19kkx8Hgn9ZOnTY1Z9c+hb6JYyi+ujYp5z2bKpKBewDW0G5nVYFWKKJ3L
         CWdBIgGRzWW5o164782Tv9EvBR0/mmIZHdAzvIrMTe0dstDhSVSno+gSTPyReAgDFu
         UpwPJdGNrpo4BoN9Mq8mtQJyHQSR4IGSg9KEaoB1LvJDLoPv/FWMV4+wb4QV+SIut2
         kv1yfCzsXFGmQ==
Received: from [192.168.0.108] (ip68-228-80-126.oc.oc.cox.net [68.228.80.126])
        by mr85p00im-hyfv06011301.me.com (Postfix) with ESMTPSA id 5804E5806BB
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 14:19:02 +0000 (UTC)
From:   Terry Warren <trwarren@me.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: git config file
Message-Id: <46D52CDE-15F2-4DA6-8E89-56E0EF86FFF4@me.com>
Date:   Mon, 1 Feb 2021 06:19:01 -0800
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.40.0.2.32)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_05:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=781 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102010075
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

can git environment variables (such as GIT_TRACE) be added to the git =
config file? The reason I am asking this question is that I am trying to =
troubleshoot a problem that only occurs when running git from within an =
IDE. Running from the command line shell works as expected.

thanks for any response
Terry Warren=
