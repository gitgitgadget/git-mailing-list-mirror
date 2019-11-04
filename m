Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95F661F4C0
	for <e@80x24.org>; Mon,  4 Nov 2019 13:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfKDNl7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 08:41:59 -0500
Received: from mout.gmx.net ([212.227.15.19]:41607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfKDNl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 08:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572874912;
        bh=ZgROd/3B6nC1anAEg9/O+CiTlwRZll+zGH8vuvXTc7g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HWSdwc4lsKdskjSLd4NQhUsGpo6EylWdVWKbYGsZW95ghZ1ZYcYstPgaHkGE3xyZJ
         5FfKfaTKLFingVBZoFBT/oJc/p8NvouBkQILJzLvEjk0frnsXH7tZbktWxkWGxBPF+
         VelkAGNU8Ggk7ESKRuwt1qKlxOlbV/QPKoyw3/hQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.3.68] ([89.14.244.142]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6e4-1i0ozG2bny-00hiMJ; Mon, 04
 Nov 2019 14:41:52 +0100
Subject: Re: Windows Git Status doesn't see files on WebDav, everything else
 do
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>,
        git-for-windows <git-for-windows@googlegroups.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <6c355683-726d-c497-d5df-bb7f8ea770d2@gmx.de>
 <20191027175850.b6le5r3jf3cxtnah@camp.crustytoothpaste.net>
 <fb194341-f7b6-d036-95f1-441c0cb59ed0@gmx.de>
 <nycvar.QRO.7.76.6.1911041326480.46@tvgsbejvaqbjf.bet>
From:   Ingo Wolf <ingo.wolf@gmx.de>
Message-ID: <af2692a1-79b1-566b-ed3f-56d5232c62be@gmx.de>
Date:   Mon, 4 Nov 2019 14:41:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1911041326480.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:foowpaIjkYZ8r3rX8pwm83HerznoPJ+5Pm5KYTH/3ZNflabbOx6
 CnGHc9UPjQ9y5QFdj2PTasNVhdk2EaNwVNXSCZB2wbuasGATC3KvNyhhBctxtGjRd7kyEgm
 uMw7Xz2RDgJmQcyO4j+AlJF2X/RsDCGv0oneFMJX2H5xMBDp+5y4+mgEVktfKrwHRhmg+i8
 OMy3ebSTkIzmUP6qnZWkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BF0TbxU3bkk=:zcC1KDNcNpIVSXGwiBLOLc
 B0xux1bBIwXxiiYYobcMLHR/dS9/wpeM4Jtvig5FPncIpSpgAwEGZ/7OlPcDNbgXEwfffitaV
 6QRNssBgk7IFQVEG7Zq7Ko7HA9nnUr7qymmMrmo01yLK4gEJz1fXzsAGpQO+cekSJsJyJXXmI
 ylci69ExUicsHzs3qilV88IONw1x06hH6NvWaVrimCW3Vl99HOuLgsAXoVu1aHWh/b10PWx13
 qVm3JNqrrOk3CzEgi14Rw2SGtrOXfmmkLHyMh2FPWOHlSmQ6AM0m2w8DNjrekvYY12Yvfwzh2
 FfcQK/PIhNudLubDoa5vY70eKheJ4xU8bKsXF7l4QMdBgSbBdiGvP/06wsV0qJSrjlbeLe0O9
 eX5t+E1zlNF8PP5ObTAZyE6IEcESJKAN09frkfsSx9+Q8eNw/vhUmjeocmiYsfOZkWiyadwDJ
 42+MR43qe+Po+rGXNFkxlL//xoMzei7pO7Z5pVfBLbyb/BTgK44qCwoZYEvwZxtkSFYG78pds
 BNEopzU6lq+1RAKeQmCLT9wzD/2DXXVFlh7866fYcZb0e5qt9bo2+ESN5dzBDcj3uYuEZ9fdM
 4edKcyiyVrNmsMFmlWgog8tpSKXoP8yvlJHnprBt9knQ5TIQDMi4w9sh+1V3plgz6FAHLzZHS
 HWT0rvl102STYGJ4ID9hX9+oZgdTr6T3J7L2fERbPfnIFnbgPuc3LMuCVmR1GZUZWoQdZzy/a
 R2tbsWXJaZC7hpVMpzLgBG0peSKC0VKLPjvCad06teUTurFsd+VTwvzyL6ni8+gjttx/Q8olF
 gqUunuW086HNwp35HR+Smuxold3Eu2Cv9ML+lwRjxNTwvM1Oe55rrdgq7tQQgP5ndYPd2QQ7B
 6uNOPW03cRpGKDTTAt6B+iXpPIxmBEAmLel2aFLbmlTyWOyqvqS8y5HscFSd1fcr8Bsk0dzZL
 tbiZyy0Rnn5b1lFqJh7mNKN97QTaVB2xQHorfSaZhO5vBrS176IBCkoS6qvDjpJFUdGE4DPwm
 F9C6YBB5gzITGUdCyhEPs7AMqW66GtiPb/mIktpohKiqWfAqUxd9zvkYNAnLt4lZAFNv/8Bwy
 BQgp9iH/toD+szYBhMxoDZpyD/2jnVTtTkueFwW73BHAZ16TPKDHbwHF9qiiifI+djL33HgmF
 WPeZOQYCsxDCVs7PGS2rlDBpOIMh/L3xeRIA8Kkv7gHUW5YKDAlERBG7OPMGAcuLIrOvT54Xf
 SRONXqj2JWd50ghpEFvbDVr0mHZJzNDiyXGtehHlfL11fxpnClYKmVzBQZo0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Am 04.11.2019 um 13:29 schrieb Johannes Schindelin:
>> Are there any more ideas what git configs I can try to make Git
>> Windows Status see the files in a WebDav workdir (and not as deleted)
>> like any other program, even git commit commits them and
>> checkout doesn't checkout prompting already there.
> It probably has little to do with Git configs, if at all.
>
If git commit is able to commit the file, git status should also be able
to see it's there.

It seems like git status does something special, so may be that is
configurable.

May be the problem is just thinking to complicated.


