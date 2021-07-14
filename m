Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007BBC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF61B613AB
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbhGNJPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 05:15:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:60311 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238123AbhGNJPv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 05:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626253974;
        bh=xl08Oc4Y20bujV5kLl6myg4mOI9J9dKsN3ufIgg1tjc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iR6XhDlakpi+lTVhVEGMYsE+hKf1WFi9tPl/WKlBVM24Nw/TNImUkvRPYHUZZ5ZsN
         zbNC4EIrfqy96hzmDF/ffDPhZxubq/OkRyOIDbbVvAtnoXiGXh7RCW6V0bLzJFQlpF
         cVM/Hms0xyRQIggn9ohtwlG9x1xVWjfo1EYTJ+7Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.219.153] ([89.1.215.141]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBm1e-1lrSPK13TY-00C9YT; Wed, 14
 Jul 2021 11:12:54 +0200
Date:   Wed, 14 Jul 2021 11:12:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] ci: run `make sparse` as a GitHub workflow
In-Reply-To: <YO3FelB47QrZwSa6@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.2107141109420.76@tvgsbejvaqbjf.bet>
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com> <YO3FelB47QrZwSa6@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-727180886-1626253974=:76"
X-Provags-ID: V03:K1:K1eZtE2bqiWBaQWqcA3Myt09yze3bSpxoHizwvsqbIE+OdN7RE7
 b7t4SD6wWHivXWZXop7435IewlAuS/tPDrxhCspuNuC5mLu87PPHXCHr7a873AlaZnFhWYL
 JnDzW17RQ6rkChTY+SS9AXRPczZDMID2kIlBzAcUocE//dSqb7l6uWeOYCLvNaOWnp3Qng3
 n+/ixmL18QAYYC6ct/CXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5wQSDGaMzsY=:We8JFafFgyIOJHh8e3I0KU
 po5me7iW08mcvJIBSJDvGBUNPieWwljraxM1hKQQChu5u320uLMHFhyNd7y5l7SpjcJM5gkqW
 gz93v2KXA4vMlYn9a3ZiKaWMTh+2fOeFYxMrwyVNSW41e/ao3f/4qHUzzWUfPTbw9+YGMxACz
 8lTV13bHiVSNRVwtwvvsGNByQsp9Lt+ytMG7k4UsIpUBkTF0hh+Pg8oLHJ1sQYxc86RMxhU2W
 968C0wSvYgNKMeBs05/16HHrjnKowmLkHsMyJO69hqGHpPiAKqSOhCuktBqB3XZ/elltr74Kd
 UrX0CeD+e90sg//TwBNs6z74dzgMqKyvTBmy0JuzRHkPwXRSkV4Qtb9beaIl4ZpUHD/eKh4sS
 gth+RzqoRjLmwaJzxtEGtr8hUWtjur3EY8AZ9kuMMxYfHZQh98loKfcEwaPuAXeLoXEsibafT
 XiXdRd0MsxxvvU1DBj8EZHTkQu5ug/67+GN/r5brqACagkLEeGI56ev0tBOvW0SQc+Nh/rZ8g
 v1GyHECj1BudzldoGM2+8ME1WbyrqFkp8ZL14I7koF9olgr5EX508dCxWu1TwkkmfTx2GWAXG
 99C2xch92zg4o8ZKtwbfOqbjc1SK+3Z9gY+JkmDEc3wKDXKGEUWBBoMil9CYPYdqpuXZAMMnD
 FvP2xMhlXR0Ed6bw5iQk2Aj1deQucK77dVv96FdjlPRUKojvIYsCzXewt5HKylstA+zrDgEjd
 4RZxjv/dWLlFogI6vq/GIUpQ5AgeSsv/oOvJt2mtPFALesq9p6rbtDm1aW6p2cVuYefIc2a/a
 b3FclCxub2AOM3hfDp/gcYPCo4UIDwaU8t0eQPHZ/dlwPixI6/TkQcMx2PjU/Q5q7B1K/SyZ4
 8QPUB+tEawQXUww55kIYQJhLXBhTiXd9N4ThJO+qwZGKLHZcdH8AVmhoCE8dxSpFrqTsZ89i3
 Vm3EOiiBR7bHW+WMsMZHr+k6HzJmscCDn+RuY0Xs/UDiS10J4oetXd1M8mIfi8S98l2Ejqj4Q
 ptbIpFuM4PShK4fvUx8ng76fK19XvOCWtaMlfcG7Sv33voW+SBc3IcUXd3MoZsSg9p72q16oK
 VHRFDmx5fidmgHd6D2eRuEjVCj2MrO5BnZuzw/2mhuLWwjLVp+3ENSO9Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-727180886-1626253974=:76
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Danh,

On Tue, 13 Jul 2021, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> On 2021-07-13 11:51:26+0000, Johannes Schindelin via GitGitGadget <gitgi=
tgadget@gmail.com> wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > [...]
> > diff --git a/.github/workflows/run-sparse.yml b/.github/workflows/run-=
sparse.yml
> > new file mode 100644
> > index 00000000000..25f6a6efb40
> > --- /dev/null
> > +++ b/.github/workflows/run-sparse.yml
> > @@ -0,0 +1,22 @@
> > +name: Run `sparse`
>
> Markdown doesn't work with Workflow's name.
> Please remove those backticks.

The backticks are here not to render this as Markdown, but to make it
easier to parse what is said. "Run sparse" is technically an English
sentence, and a grammatically incorrect and confusing one. By enclosing
the word "sparse" in backticks, I make sure that the reader will
understand that this refers to a programming term.

FWIW I use backticks on this here mailing list all the time. And I am
fairly certain that no reader renders my mails as Markdown before reading
them.

> > +on: [push, pull_request]
> > +
> > +jobs:
> > +  sparse:
> > +    runs-on: ubuntu-20.04
> > +    steps:
> > +    - name: Download the `sparse` package
> > +      uses: git-for-windows/get-azure-pipelines-artifact@v0
> > +      with:
> > +        repository: git/git
> > +        definitionId: 10
> > +        artifact: sparse-20.04
> > +    - name: Install the `sparse` package
> > +      run: sudo dpkg -i sparse-20.04/sparse_*.deb
> > +    - name: Install a couple of dependencies
> > +      run: |
> > +        sudo apt-get install -q -y libssl-dev libcurl4-openssl-dev li=
bexpat-dev gettext zlib1g-dev
> > +    - uses: actions/checkout@v2
> > +    - name: make sparse
> > +      run: make sparse
> > \ No newline at end of file
>
> The last step's name and run is the same. We can just drop name, it'll
> use run as name.

Good point.

> Anyway, remember the newline

Right. I edited this in VS Code, which does not care for that trailing
newline, and ran it through GitHub Actions, which also does not care for
that trailing newline, and the `check-whitespace` job also did not point
out any issue, therefore I missed this.

Thanks,
Dscho

--8323328-727180886-1626253974=:76--
