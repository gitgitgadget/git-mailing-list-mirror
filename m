Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98C9920966
	for <e@80x24.org>; Wed,  5 Apr 2017 14:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755335AbdDEOhO (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 10:37:14 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:43800 "EHLO
        homiemail-a95.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754615AbdDEOgn (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2017 10:36:43 -0400
Received: from homiemail-a95.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTP id DC4D06000503;
        Wed,  5 Apr 2017 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=subject
        :to:references:cc:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=jupiterrise.com; bh=i
        TsnNjGvVYGPgzEjAaMbQZvN+E4=; b=yIVFfZ9/F2W00rR4TuiPfLAPcu3AC9x81
        4AhCW20zZnDNOMaUJB4IcEgYxQr9rfn9Tg716LbyS0agjyGy8OD03scKJ1+ev6ws
        Sad5deU3jfXYslVFsP/JvQ2SIxeu4Uv3fBv3AheJoaQDEndLW96pz/1KyWafntVT
        5DbWNegVM8=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTPSA id 960B66000501;
        Wed,  5 Apr 2017 07:36:42 -0700 (PDT)
Received: from odin.tgcnet.jupiterrise.com (router.tgcnet [192.168.20.58])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTPSA id 1AFE4612D5;
        Wed,  5 Apr 2017 16:36:40 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by odin.tgcnet.jupiterrise.com (Postfix) with ESMTP id 4C8BF480929;
        Wed,  5 Apr 2017 16:36:39 +0200 (CEST)
Subject: Re: [PATCH 3/7] Allow svnrdump_sim.py to be used with Python 2.2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170405130424.13803-1-tgc@jupiterrise.com>
 <20170405130424.13803-4-tgc@jupiterrise.com>
 <CACBZZX7_tH-Q6PWdj=2BryLnSw-dX__fuR8hvbwXG4sSaM61bg@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Eric S. Raymond" <esr@thyrsus.com>
Newsgroups: gmane.comp.version-control.git
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
Message-ID: <53a2d323-bbae-88b7-b0fb-aecdc36b8eb4@jupiterrise.com>
Date:   Wed, 5 Apr 2017 16:36:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX7_tH-Q6PWdj=2BryLnSw-dX__fuR8hvbwXG4sSaM61bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/04/17 15:40, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Apr 5, 2017 at 3:04 PM, Tom G. Christensen <tgc@jupiterrise.com=
> wrote:
>> This allows running the git-svn testsuite with Python 2.2.
>
> +CC-ing Eric S. Raymond who added these version limitations in a33faf28=
27.
>
> Also, in his patch contrib/svn-fe/svnrdump_sim.py,
> git_remote_helpers/git/__init__.py & git-p4.py is set to >=3D2.4 or
> later.
>
> Are you skipping those tests & they don't work under 2.2?
>

I don't know what git_remote_helpers/git/__init__.py does or which tests=20
would run it.
I know that git-p4 tests require p4 which I don't have hence the tests=20
are automatically skipped.

-tgc
