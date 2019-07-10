Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF3381F461
	for <e@80x24.org>; Wed, 10 Jul 2019 10:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfGJKIs (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 06:08:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:57701 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfGJKIs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 06:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562753323;
        bh=/Ip3YgQotBTgLGNHBdEcpEnufQTDL10oFR7VLgoq8QU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JbKrUsQCKIoYgtuXK/ThhiRDf/YGAlyBtWl+Dmx2lvOLDH9Xg2371rlQaQ4gkBAEl
         Jlt3syqrarz9Hlxy+KLCId3ZoRpsc6f1TfebQYbtTkp6Bh7cSO8mN2DE6cu2wRL7nB
         3Ks54RIiNnqeFo6YTLrWQtWGhvOgrSXxT4MgQKtU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4o41-1ih5Et3y05-00z0Tg; Wed, 10
 Jul 2019 12:08:43 +0200
Date:   Wed, 10 Jul 2019 12:08:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Avoid illegal filenames when building Documentation
 on NTFS
In-Reply-To: <xmqqef2zw9op.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907101202330.46@tvgsbejvaqbjf.bet>
References: <pull.216.git.gitgitgadget@gmail.com> <1f0f4fe6fbf0e7a7eea1f3d49db183c70693a895.1562231679.git.gitgitgadget@gmail.com> <xmqqv9wcxre3.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907091524460.5700@tvgsbejvaqbjf.bet>
 <xmqqef2zw9op.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zm8Gw+ic88oyiDwtsN7EYHhMXPkqQ0wOLBprif21Jby0ADTQpu+
 k7rJWxHroXLY9Tnn1oICDSJKN/zyqq8zputvLqV5DneOeCGZ8stqw4+nLA4lvaxtFIRnJxq
 aDBjbByDYdUVx2q+IddhYDGBEL1syFCyc5ZM0hlSR98qXt1mJC9V5iBIDLkjbCiGM9X04cx
 iojfvJX4wo4/qxzeXu5Ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DaM4GRTzLG0=:8Q91VjKdjBA6kbQv07NYbp
 pZtUmxI6/phElxYOdMMK1IxMm0KJHZKoMkWZkaGkWdsqtSzJR4UYWMTI11rhoyp2J0XALEn9S
 6EgtrD+5kYGI59UvOJadbMzGXWuXoLXJX8UbOOj5YWN4BPz/c6T+MOP6LuV60602K8sQiz/2T
 oXvo8IQeKyCJGBF18mLih+G+OR6x19v6E1erlczdhv5Hgz8JzuN+tFpEnP4BSC08wdVVRu9hE
 DW+sAsOQbDAmTh99I6V0JJcRk7PDx3RLrUeNhR1zBIwZXQsbfYeAe4+7VrnUdIkFxt9FzrAIW
 uXKh3Rf/pWaAbaJy/rToHMksO6QfP8wuuI2c+9wUzHtGmeyDUR55j9yqHXuoyGFCXSHA5basW
 HosQyRCorigPGei4Lp9yCYRqzZbNfF1jfM02sGgHNf1Ty9Dvb7u7XC2/ajos9IVpQ7EzEnN5O
 pZkMlvP1x1fwP0Nhm3OAThf1xcvbv77gvdTHRjkNxJ3n6HPXxX3Z9HC0l7+v29MsIlT/Inmc7
 uEUx+Jb+v/ktfUeQP+XSKXGSjuXwXFo94cRYA8GcJmrWLj2nlDTkseR6130pSrOWeT5kNiSGZ
 ubSReueDz6R3taYzga5U1s48SFUZwTFAjJPv4oYUWNmztvtPdMyL2RLGkycKJJlE9/nzoorwa
 mjsIYfL98+tl4oXYPQ4ZhUWWzOwOGFArVa+gXsoLurfRbIoHI2f+FSuAMMww3h7CHZts73bMo
 5nZHN3wTrlz+RMFdk/Wfvfzve3lS43NaS79P1/zt9Mv6U7yLmkHtqy0ma5QYXCSBREkrAaJKf
 G2D9Ggah2TO0eBSBICorVl79dPuAMVFv0fgXoiacBQH0nqFXfRu/24gFoZhyPgAZI9G2a/kmx
 lozZadPQVaEsovZP5ne/Sn2Skd9iy31B+LZLWIyj7q4j6Awps9PYWUYdu7JS8NsG2REyf7NVs
 /pRW0mkMjg/X0WuLErYQ1XHnGyqMG10nXTPDzjiUqg0btWKUwu/1+oCYfyNTcgHutWJpXTSD0
 /3sSv7Bdwcq34Wk7nH9NTiXGCbRiO0QwvlYR2MxKnaxL6BnR9aN9NvncmAV6up4FWnWMuoIwr
 /iLSbxI7T85Sst3yR/9zK59WwlfL9B1CUNU
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 9 Jul 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > In addition, your `+` scheme will break on Windows once it uses
> > `git.exe` or any other non-MSYS2 helper...
>
> I am not sure what you mean here.  Is your git.exe disabled not to
> be able to do this: "git.exe add hello+kitty.txt"?  I think that is
> a more grave problem, and not limited to the Makefile in the
> Documentation/ directory.

A `+` character is not allowed as part of a file name on Windows.
Therefore, it is not so much `git.exe`'s problem, as the Git build's
problem that it uses such an illegal character.

It _just happens_ to work at the moment, by virtue of Git for Windows'
SDK _by happenstance_ using only MSYS2-programs to manipulate those
files in question. And MSYS2 programs use a derivative of the Cygwin
runtime which uses a dirty trick to pretend _to MSYS2 programs only_
that `+` (and other characters that are equally illegal in file names on
Windows) can be used for file names: those characters are mapped into
a private page of the Unicode range.

Needless to say, only MSYS2 programs know how to deal with such file
names. If you ever use any program that is not based on the MSYS2/Cygwin
runtime (such as `git.exe`), things will break.

This strikes me as a fragile setup, hence my attempt to fix it.

Ciao,
Dscho
