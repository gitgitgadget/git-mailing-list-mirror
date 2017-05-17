Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.8 required=3.0 tests=AWL,BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MIME_CHARSET_FARAWAY,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA0BF2023D
	for <e@80x24.org>; Wed, 17 May 2017 00:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdEQAEC (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 20:04:02 -0400
Received: from m12-15.163.com ([220.181.12.15]:36795 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750775AbdEQAEB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 20:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=QIEI/
        24KdghS04jiU9udLtGJsatdaX+2AZBupE4YfPg=; b=hHGwEVOBzC7bjWTAjbOsk
        /FTnN3tA0nc+0ml/2AIlVZXXXvuOCm0xvleiw+46DeKRzhx+FGgDIGh7nLXzBYAD
        NMlz7Wv38gQtqewikXlZFzXnrISZFBhrBA7XfkjWDQvyObkdBXhMNkn2a3RLDxWb
        tJ6INneFjvDqggS+08ZkI0=
Received: from [10.202.100.8] (unknown [117.136.38.235])
        by smtp11 (Coremail) with SMTP id D8CowACXTWpAkxtZ2EjVFw--.31190S2;
        Wed, 17 May 2017 08:03:12 +0800 (CST)
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] send-email: --batch-size to work around some SMTP server limit
From:   =?GB2312?B?1dTQoce/?= <zxq_yx_007@163.com>
X-Mailer: iPhone Mail (14E304)
In-Reply-To: <xmqqd1b81hwf.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 17 May 2017 08:03:11 +0800
Cc:     git@vger.kernel.org, viktorin@rehivetech.com, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com, artagnon@gmail.com,
        avarab@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <146427F1-BD3E-43FD-8C42-D0784E592508@163.com>
References: <20170513015726.20281-1-zxq_yx_007@163.com> <xmqqfug6wz0s.fsf@gitster.mtv.corp.google.com> <xmqqd1b81hwf.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-CM-TRANSID: D8CowACXTWpAkxtZ2EjVFw--.31190S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4UZw18Zw1DKFyrAFW8WFg_yoW3GrbEgr
        Z5CFZaya4vgr17KFsFyFsruF9F9FWxXF4qqw1UJr9Iy3sIgFZ7Crs2g39xua1fGr4kCrZr
        Xw1vvrWrG39IqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU83rc3UUUUU==
X-Originating-IP: [117.136.38.235]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/1tbiOwDaxlXlYpRMHgAAsz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> =D4=DA 2017=C4=EA5=D4=C217=C8=D5=A3=AC07:49=A3=ACJunio C Hamano <gitster@p=
obox.com> =D0=B4=B5=C0=A3=BA
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> xiaoqiang zhao <zxq_yx_007@163.com> writes:
>> ...
>>> Note:
>>>   Re-authentication will happen every $<batch-size> messages, so it
>>> will be much more acceptable if you use some form of credential helper
>>> (e.g. the 'sendemail.smtppass' config option), otherwise you will have
>>> to retype password every time when asked.
>>=20
>> I think this deserves to be in the end-user documentation (i.e. the
>> part of your patch that updates Documentation/git-send-email.txt).
>=20
> Ah, this came out to be rather obliqu, but you do need an update to
> the documentation as part of this patch.
>=20
> Thanks.

Sure=A3=A1=


