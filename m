Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E98D20248
	for <e@80x24.org>; Wed,  6 Mar 2019 13:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfCFN04 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 08:26:56 -0500
Received: from mout.gmx.net ([212.227.17.20]:42393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfCFN04 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 08:26:56 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mbx62-1giD2F1ntu-00JHue; Wed, 06
 Mar 2019 14:26:49 +0100
Date:   Wed, 6 Mar 2019 14:26:48 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
In-Reply-To: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903061426090.41@tvgsbejvaqbjf.bet>
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AGa8Z22gKQlnxLTm8hsFRQCrIrgtvSzKu3qiBB3/vCQT2aTYqAJ
 qJxTjGjG+AgpBzLt6cICRa837HVL9CO39EiJqfJG9h1EI4qGVxhb1MuqUEC4daDbpYoK5AL
 YtF6H13mjjRvLa6hDXTo3dtn+VzPllMnu9IM2wl+18UHWS8Wr6rDU4+YOvcPOU1pri7tclt
 8PUNmKDQVtj53WnpKmc+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/UKucvCtt0k=:At2Oy0+LK/JmN4ctwejiRu
 cu/4jBqMn/UBSF79Iv/jEuR7T71X8Q6PgW+6jvhhklJfrWq+5+KPVTdoHofvNR1Z6K9LVCfLo
 0+Uaqb5mcRIHldDDmRrMmQRK8vlEilqA9sghBSGq5zhZz7WOI69hVSolYGxtnY9bxnD4jtdrb
 WvSFG1ouoPBpBXu20Y+TrCH4uq0IHiAFThMSLSubbhsmIHRVKIXMTh8UA7hNf42A3wUFTPgll
 /v2aNI8jKjD6PshkeaywzZVglWD002N3UcIIUHEZWpZuM5gkZUxZ/qk5usbBqMTCnqfNcr0ww
 06yZCAFMmQWV4l3hEaAP5wgqHkWB6VhxVuJRP/NdEh6r/iQlTBLJMvc0Ce4hwNj6ST86PMFrJ
 14cT7Kba6zkn2m8tVy5zDEvihyK2HPSqiXmjD8Tw7JkUiEkmwdHp+0eMIfsa8p3uLr+H8r3Zr
 tj5NW0XdKQtOIMAGthzg/GO92J/DLU9VvRt935aE6VSx/eGw6HKR2cwQq8zEyi0XjPPag0o9+
 ttgEblQp41N5W9n3MerUUANgoxgFB1NF8xg+wukpyidoBGJovQN0VF20TlszrMlJo64MIQYTP
 YcTVuf34+k+NaszCC5VW+tAwsmaa44xFv6nxdURCTztr2FuENxfiB8WUtyq0wY4G0mr4GF9kD
 n4vDvS2W7WSlPgOXr1VEF7hSI625ZPhydZkCGT3209fIcxfWclZxsUNA8YCM6SAV6ngzeyOWy
 eybQa4MaFTpJQeuv1zWhHfykhoYGGnSc6zGQvoZb50/ieyh03mh3wwpX69N5v+NYKUkkOu+fZ
 dI5dCik2RLWri3F2HaPOW52A3B9uQU3cHSEe7PM/GU0wEq1gtdQkNc8ChPoGXfqVHJkPI4cYz
 Cf9cDpQhnPLgwXSPYVqQHxa7ihjc4WzSpTUvmK67C1RCaWzOAlRH4I/we1hYKdJsGPxu1wdyR
 eXNdn8jZMdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 6 Mar 2019, Junio C Hamano wrote:

> * ab/makefile-help-devs-more (2019-02-24) 6 commits
>  - Makefile: allow for combining DEVELOPER=1 and CFLAGS="..."
>  - Makefile: move the setting of *FLAGS closer to "include"
>  - Makefile: Move *_LIBS assignment into its own section
>  - Makefile: add/remove comments at top and tweak whitespace
>  - Makefile: move "strip" assignment down from flags
>  - Makefile: remove an out-of-date comment
> 
>  CFLAGS now can be tweked when invoking Make while using
>  DEVELOPER=YesPlease; this did not work well before.
> 
>  Will merge to 'next'.

s/tweked/tweaked/ (again, assuming that you'll reuse this description in
the next announcement mail).

Ciao,
Dscho
