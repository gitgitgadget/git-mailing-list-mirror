Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D75DC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 14:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD3B64F59
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 14:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhCSOn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 10:43:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:56659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhCSOn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 10:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616164996;
        bh=YwX52HO7kOJVULzMiFuC2GiNGMFRY2s429qe5hP1IXo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Pv+1dDTJuYmtqXdFULX0PXAeOLvFX85+0b4q7sEpsewhK6gcmXYbq/9c2/H36cp+R
         zALjOwjtYjhAxk9WiCQ52Zts/gCE7FzKZxk4GIBN/ZtvWt4bOj5EWQgkPgaOyJLkjT
         +AR8p2bZN1mV+mk3qyfu2PAg46hn5AkwH/01yeO0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.24.97] ([213.196.212.127]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCKFk-1lWa180mxO-009LpK; Fri, 19
 Mar 2021 15:43:16 +0100
Date:   Fri, 19 Mar 2021 15:43:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 01/22] fsck.h: update FSCK_OPTIONS_* for object_name
In-Reply-To: <20210316161738.30254-2-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103191540330.57@tvgsbejvaqbjf.bet>
References: <20210306110439.27694-1-avarab@gmail.com> <20210316161738.30254-2-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1149508110-1616164993=:57"
X-Provags-ID: V03:K1:ahZch2Y7L1vWSQHiMtAMk22kSzg+1iiDP3JIrujbfp4jAdqy/at
 INt5W0rnM9Ua/TpSmhwJrj9S+d2/gPf3s9eGOsh4FEdbeXV/oG8+Fi7qmefKcy6obX1ZNMu
 P64bLS6DwN+2zMqkNSe4ztBVUvMCIQickA59ZbTSu7a18934rJbvHDsHcN/AmlQRheyYUv1
 SJn048kRAdOSrrLCaf/Pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B7MQm8HeKyE=:iJ9LtMKNYPIH4RQqVAGwjh
 Bx4+USvQmfPZAueqfdRVG4O/BaCLSzPXkFsq/g5wvSkyJN1ycxgHjArBJRoBLtFuXC/q19N8z
 fdtP9nyBVG+1M51Y1qReG2b1vc3zkD1ZiY+wtgeaPf5EnQ4U3eU1MDlHutk1B5uO0IQDuDD8j
 PYU0eyfILOrDZF1OCboCf12OafoWuVpVAvaDaDxgNBzOoXPWG683JQtW7JbSi1rFNqweKcjoW
 kGubs4R/OP8cfSK3NKT5u5qqICmUbheUTUTY00rULp96HTHzIXUplMOYQvloJoMV0pMuqKV/h
 sxcpLF+GAqwoWbRU1O/1ttqrTu9zPNRlkxgSTfS4S62lfVMrq0IW1HKnaLJIur0QsLEA5VMkU
 7cF4sHlGdSh3Ele7Ho9NldJNm1Mpk+reeLkezQhZmUUDFrPg8buDIfSRDCvKEu5FfztB6W59Y
 JDFpdp8OcIIRw7VUPtf9ZVZOb1f22H5INEys0Zd5NXppxcNQY2P5Ocp7ZPu0BrHzb0XkmGl8D
 zLEYe4ALdpFEeQC7+P36ywdUInNXKvxDlavFkt0yZPSCiOUJ7EqQH5qx6fKOkGPQexoDXlOia
 9xDELfjZu16AwJq9RtWD9J2B5RGMBCsInKDYpBnfTfFe2fQffiFnZiQpJ4XFANSEcA9fzMsYA
 KTVzJcQzrDTiB7PfCeBtzafl8AXOXZ34BSFFQos9GbhygAuMgokmoSR1/aX7tCY316vjbBasO
 Fwbeh1bURhyxJCMqEmIgoPlU2ciTWgO1uk8EKrU08O8VJsF+Jc6LFdMag0BCemuOTLh7QSjRZ
 vaT1v5/bupygEaEmfWDD4+s2R+3SDa0iWBPTcWKyjoyR6WzUtTpxreEyiLex7dP/e4RRDJCfM
 PXiLSCyygKezkPS/vxxLHxkVm8yWXjlT+9P1tbOJSI0OWVR0uN4sWz+lrzyIEl6gWdVEMAMdc
 s6BsMmHV281TC9bniAu6VMwMNimQt7oB4KUitNuyTV3awdxo3o3Ln20HGcWfjcPeuk9A294Hf
 Z3WJ8A6kpISkZbmBg1skk+zPiabdbIbR9pkN2Sy1svTA25yxcrE/s5Nl485Fi/vnOhhpdImaE
 FW+rBUJhzgHSB2pTv8FIc1ReBDgIZR61QddNcgdexIZTceVqOVnO83+Eu4peTfKF4FtmIy+1U
 +V4UdiOVU4iSUR5VcbA2guAh35To8Yqkrc9J5xGJnhtiW80ZfK5t5Xd/ApEYpBuYck3aEbmMa
 5JgU8xNvYMjKF+Fy4
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1149508110-1616164993=:57
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

just a general note: this patch, which is the first of v4, is marked as
replying to the cover letter of v3. That feels quite odd. If you use
threading, why not let it reply to the cover letter of the same patch
series iteration?

In other words, would you mind using the `--thread=3Dshallow` option in th=
e
future, for better structuring on the mailing list?

Thanks,
Johannes

On Tue, 16 Mar 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Add the object_name member to the initialization macro. This was
> omitted in 7b35efd734e (fsck_walk(): optionally name objects on the
> go, 2016-07-17) when the field was added.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  fsck.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fsck.h b/fsck.h
> index 733378f126..2274843ba0 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -43,8 +43,8 @@ struct fsck_options {
>  	kh_oid_map_t *object_names;
>  };
>
> -#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDS=
ET_INIT }
> -#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSE=
T_INIT }
> +#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDS=
ET_INIT, NULL }
> +#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSE=
T_INIT, NULL }
>
>  /* descend in all linked child objects
>   * the return value is:
> --
> 2.31.0.260.g719c683c1d
>
>

--8323328-1149508110-1616164993=:57--
