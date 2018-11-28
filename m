Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C093C1F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 07:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeK1SHV (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 13:07:21 -0500
Received: from mout.web.de ([212.227.15.3]:51127 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeK1SHV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 13:07:21 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MN87U-1gLH9f1m9o-006hU3; Wed, 28
 Nov 2018 08:06:19 +0100
Date:   Wed, 28 Nov 2018 08:06:18 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Haaris Mehmood <hsed@unimetic.com>
Subject: Re: [PATCH] tests: avoid syntax triggering old dash bug
Message-ID: <20181128070618.GA25168@tor.lan>
References: <20181127164253.9832-1-avarab@gmail.com>
 <20181128014740.GU890086@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181128014740.GU890086@genre.crustytoothpaste.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:lTXtOPgVvy7JpJEZ6BnFUW8d2r2OSRH/DmK7NrmGeJ6Kr8xePJu
 68En2k68f96D78A+mh79O0ZDF8re9OWjaZE5B8301qLywe5DgP8hwKyVnuR8qpeY7spMf4B
 CI8NSp2wjeTKT1aIVRntXL9+IybFmEUXOGPOn14QyjE9k82LLefJhNoLxxa5GvSAF5FDNDQ
 nVdVg6+hcVVR3lj3tGJUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pcodouqsHag=:ior1leatpoit9qmlKk+tvC
 2cfKcKw/ATezvKD/4HDHG/9GSNuUINKNkQ3qn1a0xqXXalYfTU/zJG+yvpOwI2LHCpGCUxSto
 8htCFRSNuJnuSA9HPU5l3/EDBBliamgKvK19fGP8LCzJDJkCZdQmgvLSI2xs3fS68HgxbU2Kp
 PvZJybT6yM4svXN1os68Frw48eu51BFSiblYHs9fEBGEiO0CYhcxIbVZn3GcnbUZSuj1KDmhL
 sgtt28oX5/zRFHbNGm96Upwnt6ahv1Bcd4wPN1PlOGkFhjs9It7bZ7/w235R7/tKEF0OpIhiE
 352Muk6YJpuVnptMoFdJk0tyX/FaQanaDlUW1Bza/gmOv9OfI+0wIZ+8CF3Noing2shOFJ0qn
 a6L0Swpl5g0h8bmXYodeJ9v5VJJ4RB+g028RgOGX43JZ4G1f1hfvWMtPaOa/snTfcREYhymo7
 0wQNqUdO7+tZ6K05oliuKxgsBbFi9nxrgnMpqPs4W+KQSYbrwH2pXAoBXJIDqRVOdPDr1TTaQ
 S/1W8PzXAlmt/WbKqmI7nT+DkTV1c39wh54DZdnbu69KOHNO7UJDhlgXRMbWof/35zdcMyD0B
 lI/77h0UTUd8lznv3Z91X9KundXXdWa5WITajyyjzJB3gGilB3PmPHQi2/F4wD63wMqoR+7Pm
 PoFUlQ/BXcG8imfsa7rdZ+bpqvz5OtysOgPeAFnAOltlSs50XvMFX3Bx7rGVPUcEPXWiBD5BP
 ZD4x9V7H0oeMyYUcLhCEEyM3hINFcQRt/gf4O1CsV0Ssgt76VZjNmpRXdz52hLce9x+ScgaSL
 jm+ld9+Di8A7KaNKJqTyPqPFL9LZK6s5zO1pRbkcUx7IaHBHbCiuxYYh6pX6uCtMNq8gftxlB
 jGkGqKzr5C9nHnYo5Z6HRLbi+UlrH+qdsfj4ZNWPk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 28, 2018 at 01:47:41AM +0000, brian m. carlson wrote:
> On Tue, Nov 27, 2018 at 05:42:53PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > Avoid a bug in dash that's been fixed ever since its
> > ec2c84d ("[PARSER] Fix clobbering of checkkwd", 2011-03-15)[1] first
> > released with dash v0.5.7 in July 2011.
> > 
> > This fixes 1/2 tests failing on Debian Lenny & Squeeze. The other
> > failure is due to 1b42f45255 ("git-svn: apply "svn.pathnameencoding"
> > before URL encoding", 2016-02-09).
> 
> Are people still using such versions of Debian?  I only see wheezy (7)
> on the mirrors, not squeeze (6) or lenny (5).  It might be better for us
> to encourage users to upgrade to an OS that has security support rather
> than work around bugs in obsolete OSes.

Yes, I have an old PowerPC box to test if code handle endians right.
And to ask people to upgrade does not conflict with supporting older
versions (if that is as easy as this patch).
I think we can have both.


