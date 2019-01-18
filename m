Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39FAE1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 12:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfARM6a (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 07:58:30 -0500
Received: from mout.gmx.net ([212.227.15.19]:49787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbfARM60 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 07:58:26 -0500
Received: from [10.49.182.9] ([95.208.59.217]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LvlTo-1hIPPV0wGq-017UMH; Fri, 18
 Jan 2019 13:58:21 +0100
Date:   Fri, 18 Jan 2019 13:58:04 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] abspath_part_inside_repo: respect core.fileMode
In-Reply-To: <20181225104256.GA29443@tor.lan>
Message-ID: <nycvar.QRO.7.76.6.1901181357540.41@tvgsbejvaqbjf.bet>
References: <pull.104.git.gitgitgadget@gmail.com> <pull.104.v2.git.gitgitgadget@gmail.com> <3eaec10c46bdb1a4a1795ae16a76cef15d541ff5.1545690845.git.gitgitgadget@gmail.com> <20181225104256.GA29443@tor.lan>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-836164188-1547816301=:41"
X-Provags-ID: V03:K1:nj0r2ukjHg7mKXUBGkYqKjYZPvbKAH78PkSID/D6quz1LUai96j
 Tb7aOl6dg+a7UqB+Qzk/PeSHNDxRCYWYVPgNhqcP1Lb+rPNQSVDirMa2fBP4lgm3mgtP0Cj
 mMSCv6Tc4Y+5DbgysDxsPR3qWyNmdzbc3FR9IEnr2fuWnRuaSVfC+HPnw+x2BUdVg/qd9iz
 MokjlzxG39H5T5RgG9QfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bku0VgUDhVg=:gIkeW2s0uCgdADsls7I3X1
 TqKCwrW14+e/4sgTfTA1U3EogZTekCtBRRLJHt1YBqUKlxuAt2UoWI3OQlIRbFsmILYF3Vg2W
 k64OaRy9bsOjdS0Y9t8ZuWOFALxkEwEbE1Z24cwkb7eq1G4HbkwLxEWgSfeGw+FpRBWx2whoC
 FdWfGAYNHPcB666GcK9D1unyq1wHZtR5StMRFMKMuchOWgpVQZ4NG7u+nyw/5CIz9S5stXtAn
 Vr4tFMn2jsrmNXZoFUMybwjFtvGeaZogG7xYFinS8D83TRCrZ4Z1oo76zaXu/qBeLXdvwAoF0
 fM7nR3MN79Lig6mtAjxs4mLTB8r4Z/n8/XIZQptKWAwJHTs1v1Li426AXAkz/fvVHIhlOUJX0
 TYwrU6iPCLgJDyCPDfX5geMLxLO06QY46Vk8ZgSvo9Wp8X31kjJout12TTXykHxrVhxerYmO/
 GdEoOj5vXbv8JHsR6dEvyDOu21c5dJ9B5pJ2goe9FKrs+k95DiaMr1qtkoYnVUrtEkN/Fzxcw
 XIQAf1kCDbKuApugL57yCRiOvZ4s6GXOqtLzqUSpf44gmmrGm556UaI2NP1pjGiWZloDN7Sui
 WmMTw8gUHioIah5bKrwszHlt7yLR6Q345hoeuhCO2lwslCuCOwtBiEaNPpSRUQfueBUS3MoSC
 6NKDBYXDx8Xg+4iConI7AQBG+/cLV9Ku8Sy/k/Uz7U4TQbBDqTzrz+7gE7uz0lN2N2EUre/DN
 DIQe0c/MQ8qX6soJEtmqMw1GbJt/4kdMIuXleb3DFi9dPfrXsOItgyVnUNCpVlgkIjkrvqgO7
 mTor+T+hNKCAI/c3Z7KSKuyBzMCZqJ/hjTjjvbMKP5ToRBANiio8txTcjju+gLewP2oQG6NoT
 fnCIOMgD9i5RvdFEflA0u1hMUDlqHx6wpC5X3S0i4fFHnyTrvKjxMfiDZaep/aQWS+mJ3XJWW
 XkE/itDQT4w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-836164188-1547816301=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Torsten,

On Tue, 25 Dec 2018, Torsten Bögershausen wrote:

> 
> Should it be
> s/respect core.fileMode/respect core.ignoreCase/
> 
> in the header line ?

Yep. Fixed.
Dscho
--8323328-836164188-1547816301=:41--
