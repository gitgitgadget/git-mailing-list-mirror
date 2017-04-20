Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 376EE207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 10:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943041AbdDTKrh (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 06:47:37 -0400
Received: from mout.gmx.net ([212.227.15.19]:57284 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S943019AbdDTKrg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 06:47:36 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVdfD-1cWBHs3xRX-00Z03n; Thu, 20
 Apr 2017 12:47:28 +0200
Date:   Thu, 20 Apr 2017 12:47:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, e@80x24.org,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 02/11] t0061: run_command executes scripts without a
 #! line
In-Reply-To: <20170419155659.GA132229@google.com>
Message-ID: <alpine.DEB.2.20.1704201245420.3480@virtualbox>
References: <20170417220818.44917-1-bmwill@google.com> <20170418231805.61835-1-bmwill@google.com> <20170418231805.61835-3-bmwill@google.com> <12add885-b56d-4707-57c1-1073fbb7786c@kdbg.org> <9c562827-78f5-ab8f-bf04-5f403672a32d@kdbg.org>
 <20170419155659.GA132229@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1nCiOiOu7YW4zpZwMuVOSrhlZxD8WAQj/wtoPvxuBOKYYCBQfFV
 rsgdglYPxfHmBLr+b4ddjYB+skAS/PCGthzKYfVJI5iMVNgX3YnyfCVJn3UKAkvtBn1BS0Q
 1OEy/QHWbIfLcOyHM8v88wW5e/L7BWyplZjE0FUGKP0cj81wfe8mFaM4YrvsKDX5IQDfYKT
 pMWRMFwTYBfuXQ3o82GVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7IwLpyxOwT4=:YEm2uaT74Y5RjG8kM+Qk+R
 jrYeBI0LckJ+9hogdq7+moFnrqTs+qwDbEBieIgejhNzdUT+FONZ02bkhQcp6JtqGBdNJ6Jb+
 JRZpNLf0lccwHFOqBJz8qUEBgwLcfwaJZDCRdL2VQ47OqAJiHOfFYoI7zRaSrJtf4X+soJVlz
 zAvVoJPWbcVkjDlPReYjbg26lKe8+vDKlSD6ChimPuvybCAgpJfFTgyDcKO0DQBK3iVczj3s5
 UdidhlcQ9AgUiLuXhi43vm8BW+NGZ8mlkoyGbiU56QJxt1oa1+Zndm0iZfBNyxP7Kbx5fr2We
 c0Jt/9j8M/6qjWQNMLY7FcCEXaaKtRkDFBkZFeaXg4pfFQMK2uyIE17yVT9+YBS9tkH36P3kf
 jOmbj7bfolMHY09gWHFZjEXDmnPR7GGxtfeL+UtknKzVlYbdttfb18T+2IwkC/QXZpeJy8Ae9
 Ubv2IIlbMJ0gARrYTNEPFQRVAmbHvEjXkiTvAxS3h3uPReOaVK+Tv5PhAKSEewoSAvIsSFA6d
 cqRu3tozjstmrCKGhqM9RQ2nkf+VVbF1hqSFsUKoYFoNdy9UjflJvCTtDUaOSvoAlxOcOzlVm
 GthkmP/7t746n+zqO53mVUZKQrBR0+r55kPzYA//QD7pGFphUL3h8SI6f34H0oSRjnvtl+33/
 tOJuoguB+cW2N9GHPF6SRNRO+FuUb68wWXA8Fyc5+9gmP6B8X0egYFWBACcZbZM4RAnW1b+IN
 DRvkWR6kjGTeH/j0nQSIPD2W+8ziiQB6P4TWB8tz+ntboSIh+5fvaljc0g5Xw/ycHPh5ENtwi
 u+pzr8O
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Wed, 19 Apr 2017, Brandon Williams wrote:

> On 04/19, Johannes Sixt wrote:
> > Am 19.04.2017 um 07:43 schrieb Johannes Sixt:
> > >Am 19.04.2017 um 01:17 schrieb Brandon Williams:
> > >>Add a test to 't0061-run-command.sh' to ensure that run_command can
> > >>continue to execute scripts which don't include a '#!' line.
> > >
> > >Why is this necessary? I am pretty certain that our emulation layer
> > >on Windows can only run scripts with a shbang line.
> 
> Out of curiosity how did you have t5550 passing on windows then?

This is the reason:

	1..0 # SKIP no web server found at '/usr/sbin/apache2'

As predicted by Hannes, your new test fails miserably on Windows:

	https://travis-ci.org/git/git/jobs/223830474#L2656-L2674

Ciao,
Dscho
