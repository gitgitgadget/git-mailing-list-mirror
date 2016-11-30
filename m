Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6EFA1FBB0
	for <e@80x24.org>; Wed, 30 Nov 2016 11:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755201AbcK3LIE (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 06:08:04 -0500
Received: from mout.gmx.net ([212.227.15.15]:51336 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754813AbcK3LIC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 06:08:02 -0500
Received: from virtualbox ([37.24.142.44]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9ra4-1c11Bw34LQ-00B3pe; Wed, 30
 Nov 2016 12:07:52 +0100
Date:   Wed, 30 Nov 2016 12:07:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] difftool.c: mark a file-local symbol with static
In-Reply-To: <4ddad7ea-5ac8-20b2-da9e-5843c486878a@ramsayjones.plus.com>
Message-ID: <alpine.DEB.2.20.1611301204020.117539@virtualbox>
References: <4ddad7ea-5ac8-20b2-da9e-5843c486878a@ramsayjones.plus.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1672880910-1480504072=:117539"
X-Provags-ID: V03:K0:legwzjduebPJVz9Xkr4HGsy4NAQslRW+b3xKdwp/OzlvC0aeIRu
 1cjtHH7kEcpMJRf032b6CcT91/zMxFERsWRCX22jK9X4yM2PQSzJSQl1NYy9tMK70qq1Egz
 lqIKzjwWZ3VQ4AosY3Y0vh8/slmPdbrFiu8/ffW+t1OSn6ArUcwN5nzHDqZhjeM/Hf0WsNj
 ta6WIKRpwgoOiaurWxckA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pBxyur0yOBo=:/arDrqyO7sHHjRwzinXWna
 t8e2GXlWRdZPoNZn/1CXrLdfg63KVb1jIcxVkVlr2t5daGHK8fhTjdul/jQdmwPL/AlY+0Sgr
 bBmY17nPNBt3XYryrllxBTSnPaMJQK+ewxYv+1BsQ20q1SPRfwfFHT9Z9FiNq4sdBT8lrKIuE
 qDSvcuPdzlIAoGnczHbDnaMq4YhnV+WfO/7vS/1AgxkpHvnV/r9gBhaqxX/O4wh7bDYnPJzzw
 ifPjGv+RLtqUMarY2jQiXOHtM//tOBcHR9DCMDUaJgfXmLv+djJuJznn3MpwmW53o3WRVJm/7
 5E+2FZg73r912D0D6/JC7VsA2zxh2N9r6hbljeXpnuDIbzBq30ovdoOslS3cRHZ1fIsZKTkhb
 fRiu1+7mUzM30IgLhV7NheFYmQlvKrds6ijAKs3NV1hTM7ZVBJiF0eUdg3mUYVbXhFIEG8fMR
 wsK9Mk8M9gFNKlAG40f0r5+54ZkkLH1Dl5xBBJewvd4TrFuMS4W6ILB4L1hg0WCJqFHzYvJ9R
 7MsfGo3ET2MV1EhqLKoJBXm0Xct9b2z76/mXi0xzQzVLT1RIFG9jpIPrYYnoYp0I+zOl36NF7
 ho/8wxWhkj49qgAEG32bY/tQzVi87fJWf2vbGpkhwz7MMxQkzFmW0MdlNFYGtlF4UzzRHVDsA
 792vI6IXrjD5kEoc391i9/9nIXzj+BBRXrXcapn/yvd7X0Jp8rjHWXei5gXNm2z19JvDrIJre
 CPXN+BAmdYrb61+nlL468fXu7qfBoFY5HJfAstXecJcwZTGIKMXCo1i8JW+SWg6TbpqkxmamP
 krfqYFl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1672880910-1480504072=:117539
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ramsay,

On Tue, 29 Nov 2016, Ramsay Jones wrote:

> If you need to re-roll your 'js/difftool-builtin' branch, could
> you please squash this into the relevant patch.

Fixed. Thanks!

> Also, due to a problem in my config.mak file on Linux (a commented
> out line that had a line continuation '\', grrrrr!), gcc issued a
> warning, thus:
>=20
>   builtin/difftool.c: In function =E2=80=98run_dir_diff=E2=80=99:
>   builtin/difftool.c:568:13: warning: zero-length gnu_printf format strin=
g [-Wformat-zero-length]
>        warning("");
>                ^
> I am not sure why -Wno-format-zero-length is set in DEVELOPER_CFLAGS,
> but do you really need to space the output with an an 'empty'
> "warning:" line? (Just curious).

That `warning("");` comes from a straight-forward port of this line (see
https://github.com/git/git/blob/v2.11.0/git-difftool.perl#L425):

=09$errmsg .=3D "warning:\n";

I could see two possible ways out:

- warning("%s", ""); (ugly!)

- do away with the "prefix every line with warning:" convention and simply
  have a multi-line `warning(_("...\n...\n"), ...)`

What do you think?
Dscho
--8323329-1672880910-1480504072=:117539--
