Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501211F405
	for <e@80x24.org>; Tue, 18 Dec 2018 12:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeLRMAo (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 07:00:44 -0500
Received: from mout.gmx.net ([212.227.17.20]:42047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbeLRMAo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 07:00:44 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LdKs1-1hHKEC2rOD-00iVOk; Tue, 18
 Dec 2018 13:00:41 +0100
Date:   Tue, 18 Dec 2018 13:00:41 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] stripspace: allow -s/-c outside git repository
In-Reply-To: <CAN0heSoekZ_vjR6DRjSAfw74hn_NU3-5TFf6-Hn9z2D_zE-mNg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812181258550.43@tvgsbejvaqbjf.bet>
References: <20181217165957.GA60293@google.com> <CAN0heSoekZ_vjR6DRjSAfw74hn_NU3-5TFf6-Hn9z2D_zE-mNg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1752322385-1545134441=:43"
X-Provags-ID: V03:K1:sHG1ug7pJ9PCjh192m0xCJWunjt1f8HV8zAizt8oMnSTdJmn6um
 uHqJTHrdUC7EuBBqVEzUpghZ2cfCnKp/lrnsMxD9bzp0XhMVOLE9pDyoELJt/Zi909ZPKnV
 MYYpqzCxB7MwgA1m70c/SA/Sz25VTC6/z5HOKvv2qys4NszLi5P8vXBNMVOQClF5CAmrWEm
 bOi6rg7ucxzlaChvDqYxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hmLSj7HzfjY=:UbwUQRQs9Vw2f5IlhgkI7x
 kjqvLrLdM4gsIcbzFPW9obK73yTqUt+qcV3WfTxZlRURoD6Qa5HuMtlAFFKkLlPaOcjZBBA//
 +ExmaHIyf3LyRTE8Gu0zIzwOL9At4O0TzEYxuo8AtwuBS7mKR/awOTn8qVqz0CXwL3De2cHsB
 0BmiamRTQNYNLIe6HnSm3sVSsLPvFl5+AflE88OgYzas/cX3IluJ3xSKb0BzxTIJTJB6D+3F5
 zowSSJ/9QAQGyjuUpIH3G9hucUuSGkQBuagRVBoRCAWSO/X1nvDgj0OJXJuxZkQAejzPX9YQX
 PPqwR60+qOMsYfAl1FkvL1bYkVmkUafeXoLNz6QMybNfSbSXnrhLaaxo1R1cTAkv3yEfbnKty
 7LKXvvhJJ0aLEGYTo8qoKqBA2DwKlJV/okbznZdK/T36KzQiMorS8wDwFaWrdSX7vtDFQ2xN2
 LuQxc5p7oyoyTUqVedvDNO1opNccPCW1pz/VT8MEmHF4YIM7lL5sWowfrbegj0aquXnJIvGjR
 B88Z+oKqjFagm/002WjaONd4ufkN4Gy2slHCNzDaOq03T/t2Z0OcglCZ4qwFKxqJaVMVwyMVo
 dMDlJkq4cX1+z27vZSOyH5I4a1Ah0kbONaJrPFj8frtUXv+uivlhIu9dwO10Nr9LB7NRcNdAP
 PgtWlwaOcViDlijlvqXPeHtjvTnJvIIOGN15d444VOitNvY6H7bD0vrhauMWRXlAO2aVktxMz
 AXNkaDPKj2SS2aJqpAifW9Z4eLjSBNrOUxN+8JXrN0DtQEuCyqX3meK0pjyj3AGKdOYJuqPUo
 afVioCKGMha7MPTsMRT1LM+iRBADFnt9TivcbTcSjkbJwDvn4QJtDFmI+YYuvEKCxfj9dTH9z
 K1t3Y/ZzyPbjbEyT703tkfu/YRcXoWwV3/lHU871lu9CheqgpXL6AsmE+tGNPR2Qk0IXGXF1b
 XO3jtHqOAYA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1752322385-1545134441=:43
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Martin,

On Tue, 18 Dec 2018, Martin Ågren wrote:

> On Mon, 17 Dec 2018 at 22:56, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > That makes experimenting with the stripspace command unnecessarily
> > fussy.  Fix it by discovering the git directory gently, as intended
> > all along.
> 
> >         if (mode == STRIP_COMMENTS || mode == COMMENT_LINES) {
> > -               setup_git_directory_gently(NULL);
> > +               setup_git_directory_gently(&nongit);
> >                 git_config(git_default_config, NULL);
> >         }
> 
> Makes me wonder if `setup_git_directory_gently()` should BUG if it
> receives NULL. That would require some reshuffling in setup.c, since
> `setup_git_directory()` calls out to it with NULL... Just thinking out
> loud. In any case, and more importantly, this is the last user providing
> NULL except for the one in `setup_git_directory()`.

We could rename `setup_git_directory_gently()` to
`setup_git_directory_gently_2()`, make that `static` and then call it from
`setup_git_directory_gently()` and `setup_git_directory()`.

Ciao,
Dscho
--8323328-1752322385-1545134441=:43--
