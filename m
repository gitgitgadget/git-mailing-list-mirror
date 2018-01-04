Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6660F1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 20:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeADU2Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 15:28:24 -0500
Received: from mout.gmx.net ([212.227.17.20]:62737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751829AbeADU2X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 15:28:23 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTO3f-1eN7Le1CkR-00SK30; Thu, 04
 Jan 2018 21:28:21 +0100
Date:   Thu, 4 Jan 2018 21:28:21 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     "Kevin A. Mitchell" <kam@kamit.com>
cc:     git@vger.kernel.org
Subject: =?UTF-8?Q?Re=3A_Bug=2Ffeature_request=3A_Can=E2=80=99t_disable_?=
 =?UTF-8?Q?fsck_warnings_during_clone?=
In-Reply-To: <CAF1p0HimkxVydxL3cfRXX0=oaBrmARzYqCbqiarWn1yvh+H-EA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1801042125430.32@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <CAF1p0HimkxVydxL3cfRXX0=oaBrmARzYqCbqiarWn1yvh+H-EA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-154039943-1515097702=:32"
X-Provags-ID: V03:K0:oFaf9/gUq+tzYA0ibepdHFMHf+2dvYhQwEKWiov/ns0Ryqn2B/M
 7uhv0RQZG7XBAxSHElIdrpbAmvYFXMlkGoXES6P5xZacYOW4vr1671/5zCivpAXV67Gejd+
 MhMTlg1fWOdk+hEYFKM6rY1HAzbPb3jkwrYyOgtBtUHb4WIbbqzneDAjhrJdR1UdZA2i+0G
 DLKa4LDUaFJhFKDjbGj8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pGBngiqXqho=:lOeTABo00WZwZQmfM9KsjG
 YLfG2zh9YQOgvA8+0oQI5gBItiCaoK6Zy6D141vdfiD9Fw8Jiy+CJ0zFNnxSYGfEkXekVvIGz
 qD/gruYaCEVtfoi+xWpU1GYkUo63LX1NZf6TvLQ1vWW+M7259odVev9egNdYc6SJ50CAxxoVR
 TH1d0OaVeM/oDbzb2ZYSJ9fxxYCVgtpeMIhgDlqrkNmy0CibopRf7EeTu1Pd+wFGvTQ1Y/XPT
 42WZ7c8kWcBKR33xb0aCWXlMM+/4RiaX0UMQIApwlThKrj/NNEs+cOtxo5pVk4+DDtz029ydi
 J+QdtoFfiACVJL3gbyysWOgQR+9qjBzhFW9BH8ot+te9cBz9kRoN+MciraCH8NQh3sCiMY0y4
 iuLHevbcIFUrPlLw56NCNPvvJCS9+eoANua26DbeGbU3cnAcjI0mcAyvZ2mNQ205cCdEiI50N
 FrHVhLObThA/MYpxHdFpOi/EuqsR8Z9bABCUfi2pFKG21tIB8o512mGvqNt/x5qq6lz15o9Oz
 h2y2RSOM6dP3tSLqTTMrhIln593cs0rbhdH8+RELTSyBRewaLZ3CFQ0bsi6DxlFNG9yC6IEA/
 UTtfEyJA0TDZOR/uYfBCWanAjPIbb8eUwLpAFLWdsYEar6Lwp9zrwI7e1myXQFvWTgtA6jFDr
 wzAl7KpQaLfdQHdCDy8fedS5ZU2jtlbIXeLuju0CRVPyjkBQdJ9DTa4FDixp9G5imNiQnUkg8
 lvTB2ixfQxpZqb9bmuQa+LCLdQB8HBZjZBROb865T81OBoGo7/AUVfW/GxwFr9I9kpKScSXL2
 Bwc7oxeCzOyUbOfcE6TYEUYJrRh/qerSfNiSW6G21GANdRLblwMrHV1eOJTBVAjQNxFf726
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-154039943-1515097702=:32
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kevin,

On Thu, 28 Dec 2017, Kevin A. Mitchell wrote:

> I=E2=80=99ve set transfer.fsckObjects to true globally, for safety.
> Unfortunately, this messed up my Spacevim install.
>=20
> Doing some digging, I found that some of the repos had a warning. I
> can turn the warning off, but that only affects git fsck, not git
> clone. Turning off transfer.fsckObjects also fixes the problem. I=E2=80=
=99d
> rather have it on for my development work.
>=20
> Tested with the =E2=80=9Cnext=E2=80=9D branch as well.
>=20
> $ git -c transfer.fsckObjects=3Dtrue -c fsck.zeroPaddedFilemode=3Dignore
> clone https://github.com/albfan/ag.vim
> Cloning into 'ag.vim'...
> remote: Counting objects: 1879, done.
> error: object 65e1a0027644b6625b32d30ba5ccf1c4d483480a:
> zeroPaddedFilemode: contains zero-padded file modes
> fatal: Error in object
> fatal: index-pack failed
> $ git =E2=80=94version
> git version 2.15.1.501.g29533fb16
>=20
> but this works as expected:
>=20
> $ git clone https://github.com/albfan/ag.vim
> Cloning into 'ag.vim'...
> remote: Counting objects: 1879, done.
> remote: Total 1879 (delta 0), reused 0 (delta 0), pack-reused 1879
> Receiving objects: 100% (1879/1879), 1.23 MiB | 2.76 MiB/s, done.
> Resolving deltas: 100% (938/938), done.
> $ cd ag.vim
> $ git -c transfer.fsckObjects=3Dtrue -c fsck.zeroPaddedFilemode=3Dignore =
fsck
> Checking object directories: 100% (256/256), done.
> Checking objects: 100% (1879/1879), done.
> $ git -c transfer.fsckObjects=3Dtrue fsck
> Checking object directories: 100% (256/256), done.
> warning in tree 65e1a0027644b6625b32d30ba5ccf1c4d483480a:
> zeroPaddedFilemode: contains zero-padded file modes
> Checking objects: 100% (1879/1879), done.
>=20
> It would be useful to be able to turn off individual warnings during
> cloning. Is there something I=E2=80=99m missing in the config? Or, is thi=
s
> something that could be fixed?

Well, you can apparently have your cake and eat it too (see
https://git-scm.com/docs/git-config#git-config-receivefsckltmsg-idgt):

receive.fsck.<msg-id>::
        When `receive.fsckObjects` is set to true, errors can be switched
        to warnings and vice versa by configuring the `receive.fsck.<msg-id=
>`
        setting where the `<msg-id>` is the fsck message ID and the value
        is one of `error`, `warn` or `ignore`. For convenience, fsck prefix=
es
        the error/warning with the message ID, e.g. "missingEmail: invalid
        author/committer line - missing email" means that setting
        `receive.fsck.missingEmail =3D ignore` will hide that issue.

In your case, use receive.fsck.zeroPaddedFilemode=3Dignore=3Dwarn (or
=3Dignore).

Ciao,
Johannes
--8323329-154039943-1515097702=:32--
