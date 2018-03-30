Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FFC51F404
	for <e@80x24.org>; Fri, 30 Mar 2018 18:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeC3Sqm (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 14:46:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:43527 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbeC3Sql (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 14:46:41 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKLeM-1f0KLg2Ouc-001fdM; Fri, 30
 Mar 2018 20:46:30 +0200
Date:   Fri, 30 Mar 2018 20:46:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 0/9] Assorted fixes for `git config` (including the "empty
 sections" bug)
In-Reply-To: <87h8oxwsui.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803302045190.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <87h8oxwsui.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-478156203-1522435590=:5026"
X-Provags-ID: V03:K0:ahcfgrszxITCNt5Orm3R4LYrYnYQO/jEVpbSae/G2GYnHHO5WNH
 2pn+mFEyC2w2x7gn9DDsnbUsf1+usjP8jV33XTkAYrcIpTqKagzKl0xgEDgQgHitKoB8BIi
 gAFVz2xUWbmmkW/JPk4RSyBKA0W7fIRXFIud0WOdAduNt2apiVvCQhoQSgRDqzZINXlb6Sn
 lA+g4QuF73fTvIyTqRbWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QjcfUWnLna4=:PKycKB804rnB0v93aU+wm5
 9omgLRsnS8RPei8Wzj6JEZX5zOgLqZ6vEnX8B8lviGMy3HXFNh8FlLNFQqvI5JR7wCgIoIBGr
 DhwqeSHD2P27NdMT4LXBkSDaPCvPqrJfmxniRqJ9XK+rGrHUPW7VFGjF6jW9s4d4ObJ9IAV7z
 gFRyeT+1p4TDw8vmLg48ZnrL+4aEUuA1TLFYKGM5pyyeiL3B2/U8gE/PktTAZSdSzGrgYfN20
 Gufa1Aspk8kSOepGNkKgJ5Hv6FbiMT9PuIt27/7IwOBnlUisj4cubcea+ptrEyCcjQFOqdUpg
 uMu8dyJcIKdhK1++ukfaOmoECjkeR+/hFasKqgpi5NR6OBdk9fpqBqX9xtjGp3+EbQjt6/f7f
 mZOmr/i7p5YKwhcuL7VzAneUptVr6MdeNswkhoi0GtJhIpVOnWBbKa3ezW9n1Rg7dfhVFwGZ2
 pe4W1p1YTwcwoEMnBjjWbA39CyFCu2veG7UWPUipPgTwEyjE2pFQi+VzFcgE4BlRH+syzM9tR
 RElCgGP7JbENUGaV0Him6gFhHW3jT3fDVKGEOBbzJ9lVJAtk39kiCLJ/DoA7Mzsw5mgucvnf3
 I+CilraUB6a2XcZ79yEeOJxjOW16JFKgUUBjUjwFbDqap+502T4ZSR1OFDjCmL7eL+ZirtPYt
 Rl/RrUqjStkbu5hm4Np+93KzxlAjgrVnZmJSvNdEk6kvu9yXFQWpTcWweMDfWYm3d8rFkJoKZ
 +dBlWj/pT4gMXkHnj42gfnu03M9BwYLgGCv1NLPWompddtB2ZMntHKneVkCef/X+8jEhOehGW
 YWscmhjMoLVnKY/OneylJqjUKDM0I+B5r8YhHSzwjc6DKgKWuS81Qx1EMUt/T04hwZrX70B
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-478156203-1522435590=:5026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Fri, 30 Mar 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>=20
> On Thu, Mar 29 2018, Johannes Schindelin wrote:
>=20
> > Nonetheless, I would be confortable with this patch going into
> > v2.17.0, even at this late stage. The final verdict is Junio's, of
> > course.
>=20
> Thanks a lot for working on this. I'm keen to stress test this, but
> won't have time in the next few days, and in any case think that the
> parts that change functionality should wait until after 2.17 (but e.g.
> the test renaming would be fine for a cherry-pick).

Obviously this was never meant to get into v2.17.0 (apart maybe from 1/9,
which however is so contested over that addition of the test case under
the assumption that anybody but me would dare to touch those parts of the
code).

Ciao,
Dscho
--8323328-478156203-1522435590=:5026--
