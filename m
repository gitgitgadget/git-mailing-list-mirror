Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739C2C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 19:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbiGNTfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238661AbiGNTfh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 15:35:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9A1564C8
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657827321;
        bh=o+3g42nO16RlHJ5Ecdh3q/EXbMJCWunwQSh+FA26VfI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HsOU+ke/15URn+2nBIfGMJLdRmtX77N+7z+n96OXmqDbNzFNNCTjWcipT/iwaBpRa
         kGxNX74hwR8lx3EewbsLu9EpOmI3psq2wfSqP5wvZDfv9L5rvujtGx+I0lAMyrWvVm
         cvo440z9J4TSYxb0zfYj7lGwPUzs+UW2aY5PWCZs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.23.67] ([89.1.215.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYXs-1npc1f2onO-00m061; Thu, 14
 Jul 2022 21:35:21 +0200
Date:   Thu, 14 Jul 2022 21:35:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: js/bisect-in-c, was Re: What's cooking in git.git (Jul 2022,
 #03; Mon, 11)
In-Reply-To: <xmqqtu7ldmrz.fsf@gitster.g>
Message-ID: <p8srrprq-s23s-711n-n452-34qr856qso29@tzk.qr>
References: <xmqqo7xufee7.fsf@gitster.g>        <s3726r9p-r96o-7793-0qrq-o54rs4npr972@tzk.qr>        <220713.865yk1456z.gmgdl@evledraar.gmail.com> <xmqqtu7ldmrz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1067471182-1657826882=:184"
Content-ID: <83s8qrsr-2q90-o2s5-8r9r-r280qq549n81@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:KFGTv444Qiq2RyuXIuWsp8ooDPvNajh4WE+obsLOtbsAXiEQkjS
 Al5rFmWtBtrJiJA3eFAYSLb7E0iR7d37OOgWGmXQTfbWlFmUCnSn3e4FCxmBQECY+38qxF4
 lrsesgGbD2hynr8pTOmOhk25Uefp6ZdQKKOXnVLIGRxT7NSD5rcpvAXL+suV4kp7J9ZgC03
 PaZ+gbRxftVCF73LkjfZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T2D6Y8hdx2s=:dy9mONXWKJ6d3VyqMO9Iwv
 mcd8qjidTsvAM8xUgiY85O+3pt5n5d7gyI+L8DTZPrqJ0+K5QytlZz8jSC3/zAOVsc7LKmmq1
 +rMlKEF1r4n6JtQxYEEj7SJpS+ZK71CVAFqwGtOD66oIs0EcjLalO3wBiXZ5sPWyNDcmavOSP
 9A8khb5+stUOPOJy/2/kL+Zj+yXHVgXXxFEWxGwAmKkBjn6q/5sqDJ7XKYlTHH2SbDc/pvOly
 Z4xwh0byWsH3v0TEM4q3zcftetEWoUb4FB4A3+9HugEyk/YhO13BscVumrVZ3SkLYOZfBjKgt
 QSRyZFvS7n6EiEtXGT3ltzt0MEEkXa9xQJ8yNJLFGNWmYZWKoNoEWv2ti5e4GEvM2wonYOHWs
 Bsiwy0qpUCT6hIwy5QvNPGfyxF8pexsDpW80xf0iZ3ZEgDRHl6h/F+/+BjmOmRROkocEBT4Kj
 +Ady9RRr5P5m6BDZEQ9i+PBC27WXqiOPVUbvPhVJfuflyN7jO4RoKVbvkQzhyfT5xLErxolPp
 CxiPHbA5r9iinKZbQGYNug32oO79cvMgedj11yV51MZuWLJNAeYD8TtOS0U5i6sDdOjjweNRP
 2ue1fqqcopnVGXVLE7iukRtAgSJ0nAMmK4hk0ESAtyGMyUjw9aGtTg2UAehXpUA6uds67m71E
 ZpEHbrPnbi3NBMFo45ckOSG7gAMLFT5BgrYc9xQGfwliFw7wAWOj3isValX/Ud3W+5Xk9625R
 JhZIFu5S7t3ClNlX2v6xrH9d0gAFnYrhw44uM6PNNl0yztJqb74gIH8qzWSCUhyllY5IT/KlH
 SM/RYESNSnGxz/NyKJvyXyscJq/v7bgdothry7w0wj6uftHgHvlSv5QMm1x0euXSYRnCZDV3i
 6YbEdMAEdHru42xBXNVBrr6rCt1Ftro2Z6zGuWuWjGNq7vtongM8fDN1HcF/DmHpcfLtH7ob2
 UJqpKUL7N/Ognq4zLwHv5gQSinKvEAELWrDGWbFgIctnc2dYrjkclpfBJre3+h3hY3dHNM5OC
 XT9805VvCf3XGUAIl75l+1wFADtL77u2IhYPivcZUIG6Z9JU9cUwVY23uTm/4axenAyaPK0jL
 hVS7ZsIMBYD8hUdDX2g/roa+yIvqR7vwA5RPx9JHy2bKgTbZwxl6ZEC5w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1067471182-1657826882=:184
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <n6ps5s2p-3p5n-5544-o4n4-18p1837n3106@tvgsbejvaqbjf.bet>

Hi Junio,

On Wed, 13 Jul 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > I'm not claiming that we always use 129 when we're fed bad options etc=
.,
> > but rather that that's what parse_options() does, so at this point mos=
t
> > commands do that consistently.
> >
> > 	./git --blah >/dev/null 2>&1; echo $?
> > 	129
> > 	./git status --blah >/dev/null 2>&1; echo $?
> > 	129
> >
> > But yes, you can find exceptions still, e.g. try that with "git log" a=
nd
> > it'll return 128.
>
> Yup, that was my understanding as well.  We may have existing
> breakage that we shouldn't be actively imitating when we do not have
> to.

This patch series already implements `git bisect` in the desired way:

	$ ./git bisect --invalid; echo $?
	usage: git bisect [help|start|bad|good|new|old|terms|skip|next|reset|visu=
alize|view|replay|log|run]
	129

Ciao,
Johannes

--8323328-1067471182-1657826882=:184--
