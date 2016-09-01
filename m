Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10E171FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 07:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754936AbcIAHzm (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 03:55:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:55178 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754581AbcIAHzk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 03:55:40 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MRoRF-1bYRzr44Ur-00StpZ; Thu, 01 Sep 2016 09:55:27
 +0200
Date:   Thu, 1 Sep 2016 09:55:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/22] sequencer: get rid of the subcommand field
In-Reply-To: <2ba846cc-0e0f-fc7a-27d1-3b8ad66ea72b@gmail.com>
Message-ID: <alpine.DEB.2.20.1609010953080.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <258635d3aa7f70cb1b20ea722e10ad439406b31e.1472457609.git.johannes.schindelin@gmx.de> <2ba846cc-0e0f-fc7a-27d1-3b8ad66ea72b@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-435314466-1472716527=:129229"
X-Provags-ID: V03:K0:Q1MZVMMol5eaiQtILn9GFlRh6555uUfLeAizeg8WiJ/qCcNsDLP
 +phKK0q8qCStEyMGFrrHCgShRQaGRT6CGqJ8OaCeECup/YDIIMHvZQD+LApbi3ivzVi6pWm
 leCHiFNmb0L9OX/sCTNDMtJ9+YMvajtI/+6kv+1hMmAvAMalcXh3o67bqUAaj0QMxZw8cks
 QCCoFQG1VW8uELjvHLWLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lMLTqoBzwdY=:QyIWcV65c9vAssnfqkK0rw
 8RrHH+G/vezvYIT1RYaHmr3XtWAislgyxhwOWJT7E041xPiCD6K2pZftoKHoM9qKLZsJmudJQ
 iAhtU6wxhcXfATnvR4r8FI3Dxg01frjQa30B1I+i2i3vM0UjEJmAi+r9DtFaMhXdbSo7mPiaL
 hfbixma1tvhlSgltAtw76ORZOtyU3BHj2o/glVihsSGGmCNpZdhkEZzJVavVF+S5ahkal13G2
 h3/l3tClMMMW77gN4EOBS5pG/VuNEUXe0bbByfSnOCmb7Vwb+h94+moHcn22Z5POD16iy/+G0
 YCq5GDdFX56s9Bc/KFt23liFriu/4zP/eGbVmr18EXOlmSigWrfNMwA8UqWFD51niZJcMvW5x
 +uxbCQyb3XOjCtUT6lDhuefYKu1bkYwPey2bsjg/xLhudMtItj22Gqysgh5s2N20W3Malsnel
 O3OkZQntj81ju7RL4wobStiGF7AfrMxT82/t08pMQ21VP4/nW8YD46Ip+CPx43Z3EvRKGlmbQ
 FFWhYYK2KY1gZBlNTTS8m4C/le3GwRICfKEFmJ+3jmtVf1wi5O9sxxRuMdwEVrAEjWLyG2xJ/
 at8IG+vVGPQB0vU+sKt7NyjkSrrPobKUTLhxUd267zO9+e/iPxohHNVkCdOtP8YLPPWrxtrdt
 MFQnSbhdh0cs5/14WgRkRMWEfJYgme9SSKIDtH/ZqdcobROACuz4KRGWMz6QFt845stjj3/O9
 P3uFxqgGV29kxXU/Vz9WTlSVuSwkC7EP2L0h/bF9Hstkc3kqe9OSJIQNWyd8jUyltaMmK2s0Y
 +oTG8Rn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-435314466-1472716527=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Wed, 31 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 10:05, Johannes Schindelin pisze:
>=20
> > While at it, ensure that the subcommands return an error code so that
> > they do not have to die() all over the place (bad practice for library
> > functions...).
>=20
> This perhaps should be moved to a separate patch, but I guess
> there is a reason behind "while at it".

Yes. It seemed like the logical thing to do: I already introduce a new
function, why should I shlep over a paradigm I do not want in the end?

> Also subcommand functions no longer are local to sequencer.c

They never were. All you had to do was to set a field and run the global
function.

The real problem there was that the different local functions needed
different parameters, and the round-about way to set those parameters as
fields in a struct and then call a global function with that struct just
makes it impossible to have compile-time safety.

Ciao,
Dscho
--8323329-435314466-1472716527=:129229--
