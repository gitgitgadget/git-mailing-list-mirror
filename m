Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BA5C433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 21:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385CF61056
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 21:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbhILVsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 17:48:32 -0400
Received: from st43p00im-ztfb10073301.me.com ([17.58.63.186]:44928 "EHLO
        st43p00im-ztfb10073301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233942AbhILVsa (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Sep 2021 17:48:30 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Sep 2021 17:48:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1631482746;
        bh=UWL76e9X1ZkFKfa2OnNUW2ZFf7JXlpXZAjKrTZFsBFM=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=OR/GxWfExnLuRGLrGeiqUf70la/A2NPGRoCl8ZWMa8aDE1ydR01XsDsEiAfvi6jZw
         TR/Thwjate2g2KofpRCYWG+7oPwkWXpjW/JNkXC7CI4Ophg0ApN8vsTmstlEs9rTek
         ISZpCY4OAathFa64EmtL2IN6/QPmH32dsvBsvmDv6u8EqHAC9Yrn1/9Wam/vW2MqbA
         Txrs7J5Xu4lbkGqRDJ0N9UniAm5KgDsscavTu0nwIL8WSc5KpW2RGP1OvO8DqSdeDT
         l97BAqgopOlPCOHlnv/WaGn34h3AIYpn+7UFwG9NaycKXZfAm34gfT9pnasUSVh+V0
         StQrXYOvDYOSw==
Received: from smtpclient.apple (unknown [212.70.110.213])
        by st43p00im-ztfb10073301.me.com (Postfix) with ESMTPSA id 59ECF2A05EC;
        Sun, 12 Sep 2021 21:39:05 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   nu ja <nnn2271989@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Mon, 13 Sep 2021 00:39:02 +0300
Subject: Re: [PATCH] git-diff: Introduce --index and deprecate --cached.
Message-Id: <F3EB698F-7495-441D-A4DC-A8CFDB51905D@icloud.com>
Cc:     ae@op5.se, git@vger.kernel.org, junkio@cox.net
To:     jakesteward0916@gmail.com
X-Mailer: iPhone Mail (18G82)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-12_09:2021-09-09,2021-09-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=587 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2109120160
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



=E2=80=ABiPhone=E2=80=AC=
