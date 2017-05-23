Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF0B01FF30
	for <e@80x24.org>; Tue, 23 May 2017 09:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935485AbdEWJRs (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 05:17:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:55422 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935239AbdEWJRj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 05:17:39 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPDaC-1dHTfK2NJg-004Rp1; Tue, 23
 May 2017 11:17:34 +0200
Date:   Tue, 23 May 2017 11:17:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: BUG: The .gitignore rules can't be made to cross submodule
 boundaries
In-Reply-To: <CACBZZX41yrAtBvkVeL9Q=2_TxcwrDXh55gu3qLN54P_go318OA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705231103220.3610@virtualbox>
References: <CACBZZX41yrAtBvkVeL9Q=2_TxcwrDXh55gu3qLN54P_go318OA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-614509214-1495531054=:3610"
X-Provags-ID: V03:K0:wl0S6yWNdH9aj/Zrjoa/4xq9ty2BJY8kOu2jwZ9eEAWLeiOWLN0
 Nj6r8BUSwfD+fbh9D2xJ9ZmVEzjlEH1OoMUb2cdJLhxmLbIUnHkyDyicBccf49CoYjW0Tkm
 /8M+HkVs672IvoksuejztKEvH0LoMST4rm1EretpMDaQWLlxZSGkmHMJ9eQUkDqQha2/AZe
 GhdtJhB0PDIAKGyfOvu7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tIPOcsf7eGo=:qZSyHnSvDXeG7FeeAq4mUP
 XGu2Jrqk0naTEEenzXVh9v530TcnkBCHkyyN+zGTQf7EwpwjKVyBsTq8HczI2pYnB8nsKDrT2
 0jkaO/8E1ZPLMwL9oEWUqPgRexA4ul5Q0JNkj0QqlYeQVt1yD+WtukbQqnPPym04tk2C8Y7Dg
 TkZc8xdbO8mpMpAnIhpPuiO5MrlTuXjytNTLIeVnMv7DeHsWg8GA0/40orRs2BoAvB/ZLaU6z
 e1Y0CbL2Z6Oq/XQouEp8CDIPLint6rZD2fnXOk42WEzpinlVgb+SNb0UMSegOe33IUGLQZvgb
 XM0R3X9ayLiFA2yDPWZPThQcbG85FfzNHzarXu67aiU099a01VArvFhg5+wh6YbpTbFqJOjOP
 O81FPaZXZdAg5apwZPuEmQUTU8cc+ceLqJLo4qCT17HKjp/GceUNis4im0emZ92T4Rc1dzhxY
 DHvBXZIMZtl6MpJbp9yZPplTCuHKViYviLxP7L/H+p2nQtMQv2PY4xF/o8aKaWJR3I7JBpGyU
 OkXoYqYcxae5p4wX3pZwlWI+OYAPmCCw6MEYSxed/v5f0HwoEjc2inXMvSXzmcOR29BtU+k9G
 kFudsHpmAR76pUhfsZy40RInMtQnogc5XomZ5XAWX2dDviWSy0p23H31Djsn2Kbve/ife9qae
 G0vSA+8AbYguy38hzAH3/m2YjO8GKu/hx0S/ONKjmZgngTpf8x4JP0N3tlKrW6nLyZLaCbqLB
 v3tfjttXN/snSgfQjl33KE4GHlZu0aGGDExqFf3t6MGRQNJD+tTQiq1uPJUD4za0i5MP1xabs
 9bPWmYx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-614509214-1495531054=:3610
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Mon, 22 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> When I was adding the sha1collisiondetection submodule to git.git I
> noticed that building git would dirty the submodule.
>=20
> This is because our own Makefile adds .depend/ directories. I hacked
> around it by just getting the upstream project accept carrying an ignore
> rule for that around:
> https://github.com/cr-marcstevens/sha1collisiondetection/commit/e8397b26
>=20
> A workaround for this is to have the Makefile add such a rule to
> .git/modules/sha1collisiondetection/info/exclude, but that's less
> convenient than being able to distribute it as a normal .gitignore rule.
>=20
> The submodule.<name>.ignore config provides an overly big hammer to
> solve this, it would be better if we had something like
> submodule.<name>.gitignore=3D<path>. Then we could have e.g.
> .gitignore.sha1collisiondetection which would be added to whatever rules
> the repo's own .gitignore provides.

While I have nothing but the utmost respect for Stefan and Brandon for
trying to improve submodules, maybe it would be a wiser idea to imitate
the same strategy with sha1dc as we use with git-gui and gitk, i.e.
perform a subtree merge instead of adding it as a submodule. It's not like
570kB will kill us.

Ciao,
Dscho
--8323329-614509214-1495531054=:3610--
