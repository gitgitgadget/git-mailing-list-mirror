Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 411DC20248
	for <e@80x24.org>; Fri, 12 Apr 2019 08:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfDLI7m (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 04:59:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:33461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfDLI7l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 04:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555059575;
        bh=yUD+B/VM+MuPA76Ate0hrJXwIfQ6OBGo3sYD1U4iKHY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ixFf7v8uTpXsJxt7qLDWXiEqEilmHbYSclcbAnTd0zlCxiaT+zKgZOpJ+aJ3MflXp
         7vbEXXjUOGxX5XCRZWp3eQRFpgqT1gNvAOLY4R6Fte393pM+7zyNcSxy3eDFsl1nHP
         UDags54BLf4QnTaji5P4843zpXruCV7b9V9GBjRc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lx83d-1gmdnK0NyL-016fSo; Fri, 12
 Apr 2019 10:59:35 +0200
Date:   Fri, 12 Apr 2019 10:59:19 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] tests: disallow the use of abbreviated options (by
 default)
In-Reply-To: <87sgvabutb.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904121058400.41@tvgsbejvaqbjf.bet>
References: <pull.167.git.gitgitgadget@gmail.com> <04c36b1de9f22d7e0c64bb118eb424c1f64bd223.1553537656.git.gitgitgadget@gmail.com> <87sgvabutb.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1897170323-1555059575=:41"
X-Provags-ID: V03:K1:03O2seQwmYUBdZakVoKdGmzDjE/Ka/t9qLOr+8lQEEHEsFOMruh
 metCpK5mM+ZaCr5NBf15bHQgDz71xiVV4AjTU8ThAN4C+2n/O2WJw/BcDSChNP3jM69Nlzt
 Cy/etlBzjne5Cv0SSSNnHeeZFfO34O0F7+p55uYGNAaLLAHMoIrWU5a3hEKeTeFXifrixUo
 V8PfQ2e+CQ7yZ3kWKgvrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1PhtyXl+uqs=:CIXP5ZjLRfz+dLV1LD3SY1
 nSFkDFPdvdhnmcFvsGHvGBpVv48aFK8Z8lS4whCUJyZtwftDNudk4FVkLGbsNkoXsV4UbgAhj
 B1DhJbUO8LonJvbo4xN5pJ2HHScC/DzsLEjx9hM25fl4MVYbLbDX1NDn3Q53rhyhcXbB72SXe
 +3tfw0FU4aAYXF7XmoG8o7anRVLvyB3vSVkYzykNPQZSVmUVZRzw82Uwz8ROvk/oQvuVlAZID
 dbu0GqGKYM+11wu0j4w8MjNvtWoqoriY9xrISfWmaSCivDs6A69fACYf9PWtEWJMADiAJEmU1
 9Qx0Gn+igpHZZYkrMaxwU1QFEIAYe9+YGuurb3+s7/Zpk+UtnupUbmcME2dHOZXtEQzeTDuFe
 yfj1PDpJlRqs0Zno1RBwPNb7q+k1UCFPy7HxehTaqQSnCNJpQc3clezJzrCDoCc0VWoJhUedm
 /8rwH01oSntNvTdmEJaZCIIOmMhFGo5KdPqfkIkFrdPbwPj53XcGEpHYe8iKgscdbfaIskJ59
 ZVg9kyPQdfeJhGVh4K+cZqk/tx0bKwsVw9eUp2etqVkgURLrLWVkqSR8l30Tk0a+vKLTvkR5E
 oF9BZwbNv2qAxBy8XX8rvPIXPLhGHz7Lk0FeL9NVF6Oj146JPAlyBttCOwxtHJlDOxIzd2JNl
 3cOEgv9B4H7ZdnKSDmiS8uE1Vtkl0lLlWt3MY3Fvm1PGJGQ1PrJo78ueGSomcX8+gJPWSfe/6
 mv7TKU3B3EEQwBHhupXoI2pXqmTcNEZcd2zd6jwPkPkUATjmw1sCokeHALtmjvMS45wqkC0jJ
 QrJbGut7TXNt/Sv0O+m/TyLfMTnjDRrel5d6TzHQ3WyxUe9QV9PnWWIoYqViYDZFqBiC6yFhP
 DkwqYyLD0O6CQP1uvF73bM9t2t4LR5S91vV0mzuNH1vUOpqnto6I+Mn97BpDpPhyuz8t2qOoN
 da8jCh0Ej4Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1897170323-1555059575=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 25 Mar 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Mon, Mar 25 2019, Johannes Schindelin via GitGitGadget wrote:
>
> > +# Disallow the use of abbreviated options in the test suite by defaul=
t
> > +test -n "$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS" || {
> > +	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=3Dtrue
> > +	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
> > +}
> > +
>
> Just using the if test ...\nthen\nfi long-form would be consistent with
> our usual style & the rest of this file.

Yep, and we also use the `${...:+isset}` dance, so I imitated that, too.

Thanks for reminding me that when in Rome, do as the Romans do,
Dscho

--8323328-1897170323-1555059575=:41--
