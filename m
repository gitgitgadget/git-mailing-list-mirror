Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7B771F404
	for <e@80x24.org>; Tue, 27 Mar 2018 14:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbeC0OlC (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 10:41:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:47649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751316AbeC0OlB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 10:41:01 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lh7sF-1eFPOf1P5b-00oT2i; Tue, 27
 Mar 2018 16:40:50 +0200
Date:   Tue, 27 Mar 2018 16:40:47 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 00/10] Hash-independent tests (part 1)
In-Reply-To: <xmqq8tafe92r.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803271630210.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180325192055.841459-1-sandals@crustytoothpaste.net> <CAPig+cR==SNfGdhwqPdvW75fUxXg-VSQ5Tz_OR7Sy_c0L94axQ@mail.gmail.com> <xmqq8tafe92r.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IQz3keL5iuj2R41DAIAMtLltc2XKaRN/qLGpkMV8y/v6etD0N/i
 u8Xx1+vL2nTHBVxAxWasEW5emG39o/WJmY+LHQqdL8krEdrDldLika1u8hoEW3LDaAF7wr1
 YBTeFCOj6FdIDcNefG0xz5zAWrYGnRfck25WschIytpsFxj74NcgFyZ7++ZF0vp7PWUDLis
 Gwcm7Fov4Y4sFqkCT5I4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V6qooZ6Zi7M=:E5cyVSZWfcEKapV76MeQrU
 eV5L0ic9oiHM2LoTrAqwQn6wUls3W6d1wY0ucqDYufIjgv2VIpnVoWZNg/bEh00+NDF6/KYQn
 ZJVUHqvwD3BQfLFI26eO2n8GzRazfkDOL7kU1nxDrkj1CP/JQBWYUC2lBDOhTjJVowpe48678
 nvepgQ7I18iEjA4s/2TsyY0T0L5ePUgWAkmhceoBRCM3I2gztqTrq25T9VLj6CGl7eXFY347K
 7C9LaAEKDJt2vjkaXnH7MtPdT9k0W88bgcd4XIJYIbdpRJO7TGUCjXZGHKkwm8mTjw11EuaJ0
 2ZGIBRh9lV10s2PXEAr5fxpEm/fDO6X6byWAVJVN8oSKWR7tqxcVkV2rw1jyVLzJpBq/XVGT3
 klHESnUEpKFYeOsBRxuxP2M5BKuYzkFVqZKN8o0IbvPXADLoD8DGSAiD58I8DoBdyHuOFi6V6
 TaWD5KSFZXa4UiKU0/oEXKZy1sRZM1hEDDCTqduKazp2oD49jFfVGN/CZPDkLMG+gxT7giGuo
 TnUKp94kVatMa8ZHtokrq8ba7TC2jkwnf/YfJhZpI+lSq1dAAICLHgaPM8J78AjZGYXZZknnz
 HARQNboogewjoTutIBf0zridUP5ilsEQnnHBWzCoBAyMdXbxbewHqpfoNcBfHFCVoUHM0IgTO
 dSNsNHeKoZYEW74/Ia2ib2R8VSeGYNBnR1IDlwntotUO1sL+mt4z3fcq/7OmguBknDpaLG3za
 KMVI23tDdPwDQoOzkprIhm+xVmxm4ta9tSplD5UEf8QtDYj5vvXqYZa7UVaII9WWdTU79OWpA
 gDRY7Q9uUCuuBEmNHNI7KFoJRLmgs6u4W67sgWpGesk5vgKNlGRgn71YkPyBV6pVDP1UEiH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 25 Mar 2018, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > What's the plan for oddball cases such as 66ae9a57b8 (t3404: rebase
> > -i: demonstrate short SHA-1 collision, 2013-08-23) which depend
> > implicitly upon SHA-1 without actually hardcoding any hashes? The test
> > added by 66ae9a57b8, for instance, won't start failing in the face of
> > NewHash, but it also won't be testing anything meaningful.
> >
> > Should such tests be dropped altogether? Should they be marked with a
> > 'SHA1' predicate or be annotated with a comment as being
> > SHA-1-specific? Something else?
> 
> Ideally, the existing one be annotated with prereq SHA1, and also
> duplicated with a tweak to cause the same kind of (half-)collision
> under the NewHash and be annotated with prereq NewHash.

That's a good idea. I wonder whether we want to be a bit more specific,
though, so that we have something grep'able for the future? Something like
SHA1_SHORT_COLLISION or some such?

> It's a different matter how feasible it is to attain such an ideal,
> though.  t1512 was fun to write, but it was quite a lot of work to
> come up with bunch of blobs, trees and commits whose object names
> share the common prefix 0{10}.

Did you write a helper to brute-force those? If so, we might want to have
such a helper in t/helper/ to generate/re-generate those (i.e. it could be
asked to generate a blob whose ID starts with five NUL bytes, and it would
have hard-coded values for already-generated ones). Even if you did not
write such a helper, we might want to have such a helper. That would take
the responsibility away from the shell script.

Ciao,
Dscho
