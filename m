Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D0C1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 18:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeC3S4f (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 14:56:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:43053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752171AbeC3S4e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 14:56:34 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqQzp-1eOXqS3Koz-00e3iW; Fri, 30
 Mar 2018 20:56:10 +0200
Date:   Fri, 30 Mar 2018 20:56:07 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        William Chia <wchia@gitlab.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Draft of Git Rev News edition 37
In-Reply-To: <CA+P7+xoEquzyFFtpsmHb4WDLJiaDb1r5fDTsHk=4qyj4sVXm0w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803302055440.5026@qfpub.tvgsbejvaqbjf.bet>
References: <CAP8UFD35QP0jwQ22jfUaNgo92o3vG8bV5n=iYnmn1ichxndphg@mail.gmail.com> <CA+P7+xoL6TRP0NZJR7gQrVeLoQwK_1D_iDmG18Y=_i=U4uttgg@mail.gmail.com> <CAP8UFD0wWiivjzJ29-RPVyOxkmbFACXTwHLyPrMdsUsW__RsYQ@mail.gmail.com> <nycvar.QRO.7.76.6.1803301059450.5026@qfpub.tvgsbejvaqbjf.bet>
 <CA+P7+xoEquzyFFtpsmHb4WDLJiaDb1r5fDTsHk=4qyj4sVXm0w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LLiQ0CkoWaILAM7xCtMF6z6Ebn0ICJaso8vUE80RzkAhEfqTAH/
 Q4xgFlVYQ/VIXsAnELxwsPRr7VGnpfiO66Xo7O4Gt/CyjcDnHRjM7UxWTSYt1Yu2ixdtqNa
 gNViXfa2XkeTr/G3xWJarQO/oJWYEtHAKqY6bppoXKM05F/Fg5VrzTNeEC4qagXQwsV0R91
 qanELSjphHy4c3r8d/QWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QfmI0M9xBtA=:t/06mzRuncuvOFs8CvxsLT
 j8iYw8ip3TuLZoQ19OoOkHPSYPqrXM85Q/ObFStZqmt+ebUdQfgl99Jaacn7gF4STFgwx8803
 aHR25fjLetbwFn3VvU2Dkv4E7zvjjBSurEl4LJaLLfLUKk9ybitz8eCfP8UxI2XKoIpgE02xu
 hUm9Ts6oYE50eP2mGpFXCM0XBDZKFAKI31hHqumr30yptF4Q3IM4HvsPxnqoqbzi2rTMyYYav
 xYyNcdt7z0J1kI2wEMPmCxPb/MpytNdj1mHLkMlMANIolUS45fS4ItkD+fODDfb5Mj/rwcccZ
 gtgH0UPfkM7FVC4uwQG+dWeaJqwPfU8jSILnM2PFI/jN3f3A8HwFwbD2z2D7z5/B83hKmggOB
 0dUDGvTz4kLXCL5SR4csljUCF0WMK/ECB8gzQeeH5XzY0VfQWkaZ66oRKTFn9VcqiTq1mz3BH
 ySC4+S7hKoBdtDdrDW/dkGxo+bqdadzXOmh2L/VIYekqxoHSQdMpkA71Tg8TNcb84nO3kXRaB
 1k8Hcgag8oPlYU8e9CCqAGm1o4dUm4aM98NtHbPDOOIhFCBESeZ3hA/1Ef9dRLe5Jkn5ILeNj
 sc4hTly00CX2eqSOMTwxRIYHd3ph/KlLqEGcIxba58ymEB5Oarv/QPItkRS6M8vss4hJYQhO3
 fhk7mo0zaHaW/YUvoxlD8ue8dP+aScUiGuxAe3T+P1SKHGvmKL62+dfjFdE6i9u7WU8Gk5CLL
 thGv+tZQNJMN15g2oFsVINMhr7OzKOjwYOBRUmzYM+cPmelfmAy/dd147zJLdvpA7Z9hYFNd2
 CsxgOnfMocXk9pkSQlLlQKZ7CYHo3nqyzZPEBBk8zSFoI/VdWkcAGBowVMfCLr66q5udXlD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Fri, 30 Mar 2018, Jacob Keller wrote:

> On Fri, Mar 30, 2018 at 2:02 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Jake, I do not know about your availability, but I would love it if
> > you could take a stab, as I trust you to be unbiased. I would not
> > trust myself to be unbiased because (as everybody saw who cared to
> > read) I got a little bit too emotional and should have stayed more
> > professional.
> 
> I hope to be able to make a summary of the discussion as best I can.
> It may take a bit as there is a lot of mails to read. I agree that a
> good summary should come from someone outside the discussion to reduce
> emotional bias.

Thank you so much!
Dscho
