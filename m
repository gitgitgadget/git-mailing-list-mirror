Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42C6520C32
	for <e@80x24.org>; Thu,  7 Dec 2017 00:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbdLGAHR (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 19:07:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:52224 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751610AbdLGAHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 19:07:16 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mcmmn-1eegEs1wp7-00I0av; Thu, 07
 Dec 2017 01:06:59 +0100
Date:   Thu, 7 Dec 2017 01:06:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
cc:     git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>,
        =?UTF-8?Q?=C5=81ukasz_Stelmch?= <stlman@poczta.fm>
Subject: Re: [PATCH v3] git-gui: Prevent double UTF-8 conversion
In-Reply-To: <20171205142326.6140-1-l.stelmach@samsung.com>
Message-ID: <alpine.DEB.2.21.1.1712070106160.98586@virtualbox>
References: <20171202122046.6033-1-l.stelmach@samsung.com> <CGME20171205142341eucas1p2b30072c799c8787f1b66db2fd4bac1a2@eucas1p2.samsung.com> <20171205142326.6140-1-l.stelmach@samsung.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1933563052-1512605219=:98586"
X-Provags-ID: V03:K0:prDM7JcV5GT3PlcOjKzuX96mD6ndU0RaEe77vtLRVr785rnfLEU
 gpEMvT25jHM7ppSgQIiumX3RaCrp0IKdAyXDkOUhD2hdXt9DYGApqg2j6TmNGfhytLtZ1tT
 CBiw+3o2LM6uP56Ek42Y5Fgoo5VEZgjpizJidmrs0rqp/4E4AyLxo9sXzxGCfjor+4FyuKU
 BpeBk7o/hBWPmX7QwrDFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fslMDtbFn4Q=:MvUyQJCh0BWW+yXh8FZIi7
 eFi2EcuJ3xi5NajA815Jy2szx4/C0eEYyBycojzaMVzkzHj6VQcPthG1zl9HEvJbchbBxRETC
 9s/Wy94JyETQtSUbDpaBjV4HojKtUL93Xj/5LM/ZHIEVZXtOzsgbvwE6dEtY7vhhO/zl5obnW
 5TtmRLARN9rFwg8UbcYbZgT4B8TlOzVh41gtNaiBaVsjvrXP3NidlKaTxLPEiLIttWTHF+x4S
 9rZxmL7QKPI15Mn9dDVRhWWBJe+cCal+4JmF1D8wnx4Fowp+k+5Omk8O6vlhoxCmyfnHb9Mfm
 AaXkmyewBHLeyBBYKXqKwGosj0O0LCB8zlO1p+Up230VLN2fLiHBUIY3Y7GLFhw/1KNdjGFcy
 De1NfJFDH2BEq56CJ4DcmjWzwpFgkrVcfpvXw6dfbm98rt6JbscY3hadQh6DiHMdZOlgpUWt+
 /w3iQaqe8F9d2347fff/S6UtG1FIuzfouFYp1I48BS/T+0nB4gQHmz3uCm2rBLUEce25KtJMz
 6Mh5nmI/a113v+oDdr+GG+ibZuFEO6v5jr6Oe6bmdI0A57ubAGu3h6KEy72J9dKRhlZYSrCDV
 EdVRYyipuKFtACHu3si0FKf4JYRZTEubpAUvlargqqXnKjWRfKloFX0rnumr2Wsc179HUNfJq
 IYLdrA8xeYRY1U1JS3tKP7rDxrqaOiU2OaC/mb0+kGKEh5Xfbv5SY4kQmhy6e4nCB1/Wx5lVb
 83SD2jCpJap1lz06SnZSO6RdpOJkxH5B7CUZrgjozTicqO14GLl+opgHZogZYxXGTxqqqmuUX
 3ykf+evfeN1KG5SYets3vyZRFKtwMx+D7q9qXdzh8vYQ6PFWBw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1933563052-1512605219=:98586
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C5=81ukasz,

On Tue, 5 Dec 2017, =C5=81ukasz Stelmach wrote:

> Convert author's name and e-mail address from the UTF-8 (or any other)
> encoding in load_last_commit function the same way commit message is
> converted.
>=20
> Amending commits in git-gui without such conversion breaks UTF-8
> strings. For example, "\305\201ukasz" (as written by git cat-file) become=
s
> "\303\205\302\201ukasz" in an amended commit.
>=20
> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>

This patch looks good to me.

Thanks,
Johannes
--8323329-1933563052-1512605219=:98586--
