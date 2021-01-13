Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA51C433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 14:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5FAB23600
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 14:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbhAMO6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:58:12 -0500
Received: from pv50p00im-ztdg10011901.me.com ([17.58.6.50]:59512 "EHLO
        pv50p00im-ztdg10011901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727001AbhAMO6L (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Jan 2021 09:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1610549831;
        bh=jVUAvwEY+4eyGl2sFe/TUhKfH06N7lLkTHuO/bb2MMA=;
        h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
        b=0/DPmxJ1QkkujdgyjWHdOYjRupTxNbH6twmRUSNPJ/+SOop29x8Bt0Rd+Y0M9prm2
         iHEMGCekLQ4dej3hSJ26/9Sz4P+aMLAPkVkF4TsGsC1F+Ykc+107TqGheZ+q4uqPQ1
         LJQd7bx8uMByHGmsyfx7Jo5tjFU9+7iinY4gUiH4YAfwipVz3mLHAkVwaDeqq+XMX+
         k+avBK+nY3EK+hN2+hUlvC/16kk2l4enLEdFKg62K98MQUMjfEfIsTaFLVdbhf0QBH
         uVT/vVop1qud+AJPRjWA8pAfpHRS6rRhCukVSwhMLwiHMQwC9DpX2bmcaJvyUDVKhw
         D/auRHFLTBrlw==
Received: from [192.168.1.114] (unknown [90.129.214.206])
        by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id 89CA38002F9;
        Wed, 13 Jan 2021 14:57:10 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Daniel Troger <random_n0body@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: git-bugreport-2021-01-06-1209.txt (git can't deal with special characters)
Date:   Wed, 13 Jan 2021 15:57:03 +0100
Message-Id: <653FE799-B0D6-471A-8801-834C6CA409E3@icloud.com>
References: <20210109172301.qkxxeeqnyrr6nyc5@tb-raspi4>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
In-Reply-To: <20210109172301.qkxxeeqnyrr6nyc5@tb-raspi4>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: iPad Mail (17F75)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-13_07:2021-01-13,2021-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=571 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2101130094
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hej Torsten,=20

> To clean up the repo, you can do like this, explained in a dummy repo:=20

your commands to remove one of the versions worked perfectly, thanks!

> And I still womder, how did you mange to create the "decomposed version of=
 =C3=A5" ?

I created the directory with finder or atom I suppose, I did not find an mkd=
ir command for that directory in my 290MB of bash history.

> I digged some hours into the stuff, add lots of debug traces, patches and s=
tuff

If I understand correctly, you already came up with a patch? That's great ne=
ws! It's fine if it takes time as long as it gets fixed eventually.

Best regards=
