Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3B4D1F600
	for <e@80x24.org>; Sat, 22 Jul 2017 11:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755221AbdGVL27 (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jul 2017 07:28:59 -0400
Received: from mout.gmx.net ([212.227.15.19]:49512 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755095AbdGVL26 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2017 07:28:58 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LhOSG-1duxmf0UoS-00mfeO; Sat, 22
 Jul 2017 13:28:53 +0200
Date:   Sat, 22 Jul 2017 13:28:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
In-Reply-To: <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1707221323420.4271@virtualbox>
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr> <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com> <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com> <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
 <xmqq60epfy27.fsf@gitster.mtv.corp.google.com> <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com> <alpine.DEB.2.21.1.1707191456010.4193@virtualbox> <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com> <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com>
 <CANYiYbGSaaFOq7iw=ON1Oo87bSA96o=zyzym5RDT32kMae7bsw@mail.gmail.com> <xmqqvamlfm6s.fsf@gitster.mtv.corp.google.com> <CANYiYbF+XDANNbpZJ-jL7y81QhggW_snBuWeONSCUc4CPn2zMw@mail.gmail.com> <xmqqr2x9fjpi.fsf@gitster.mtv.corp.google.com>
 <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Zm+DU4nKniz1RokywX4O9qF9whWR0qoCLsDhajkK+ljtSJNKLtX
 k9Z7Z1GcfOhgNWkr3OBURf7OmGy8YWTHqc35styjzu2NpZSZpLEjBsX9c1cdPrx+ZhZR20T
 MHHER5RJjyS1tgsGC8om181U6E7V4KCIpijALruPzxfNHvp4y+rGaP3jmoFuyXh16ub0so7
 h1YCgtfivm+0RBTfIoD0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LW+v2vNjj/8=:ga0BcDYdE2IVtuLTnzOMVH
 7Jql/Z2cWRSeSkiSw8XFySmbll1wArEGE8r5PqFG9mLN2hx8iBhT0HUPDo4lmuK11vniRVQYl
 g2FMSjNPrFA28ZhEuZAW5k3ueG5frear+WiujfsruGByG94zEl+YICANEw9Bhght6Rho0kueD
 kMNIGMl4bYT3IVN8Cif81yXakX0ZwdsY2Ze5nKzD8PqyOr1biSZErh9MYXOkB24ZEfWIV8IqC
 YdzpfQ2fkJC1RYqWtmdedc/45DxlSdScBrgNWtXuodZJ6hqn+FwE+7iwXMGHCgM0jnYUmIyPY
 sCsoiCemkoblhZ+rBU6XsWry4jo9n5R/Ty93dkdI57KWBTmNduzE3YsyIN0OUc9xs9bYeZq1j
 loH4Pz8cH3WhvDc+unPpVxH7Ucg1vWgvcGNLHenM/FySNXBbGy1ZhIUwNjFApeXNH55UfbsCM
 z8pWyuhSdMJM4bRD5D44uyrvgclp3iMxYSlezjhg7IYZXDamyMIB3NF33TO0OoJwHj0CFbjRt
 rCPYIFBtXwRClxRL6IW9SyBRov9WfCBSTcksYhMtIqU5dSlD8z9nZU36ANonwX4TysPz5AAma
 +WPHF8I9Q9uscevxazs/sV4DrjvXC9SLJ7EttqOzhI3L4GLeMLROGc2iI43tyWrUV8AyWxbYN
 6PnpTBlp5XeM/xKhGs0ZNvorupTBlMWGywRj2i5LiqLPJHXTOB82uspEpygE4ie9tW02PoSjJ
 TsRg6XKX5SpBvPbhFHDQAKZr6uCnfgkdQPe07jlDcdKggSFImrirwedsMYl40AvOtWIdhJjSF
 u5OaYmtKNq/dVbCpFO0ilume//d/f04UybLyLiDjyi1e6UKWX4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 22 Jul 2017, Jiang Xin wrote:

> 2017-07-22 7:34 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> > Jiang Xin <worldhello.net@gmail.com> writes:
> >
> >> A very small hack on gettext.

I am 100% opposed to this hack. It is already cumbersome enough to find
out what is involved in i18n (it took *me* five minutes to find out that
much of the information is in po/README, with a lot of information stored
*on an external site*, and I still managed to miss the `make pot` target).

If at all, we need to make things easier instead of harder.

Requiring potential volunteers to waste their time to compile an
unnecessary fork of gettext? Not so great an idea.

Plus, each and every Git build would now have to compile their own
gettext, too, as the vanilla one would not handle the .po files containing
%<PRItime>!!!

And that requirement would impact instantaneously people like me, and even
worse: some other packagers might be unaware of the new requirement which
would not be caught during the build, and neither by the test suite.
Double bad idea.

So let's go with Junio's patch.

Ciao,
Dscho
