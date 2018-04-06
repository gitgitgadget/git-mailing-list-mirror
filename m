Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E1461F404
	for <e@80x24.org>; Fri,  6 Apr 2018 12:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeDFMV5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 08:21:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:37251 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752021AbeDFMV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 08:21:56 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOkQc-1f7BWf13Kw-0064ia; Fri, 06
 Apr 2018 14:21:47 +0200
Date:   Fri, 6 Apr 2018 14:21:31 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Joseph Mingrone <jrm@ftfl.ca>
cc:     git@vger.kernel.org, garga@FreeBSD.org
Subject: Re: git 2.17.0: uninitialized value $rec in scalar chomp at ...Git.pm
 line 557
In-Reply-To: <86h8oobl36.fsf@phe.ftfl.ca>
Message-ID: <nycvar.QRO.7.76.6.1804061420340.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <86h8oobl36.fsf@phe.ftfl.ca>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Uwl80UEArJ9NwY0Sdlxut40bQkhWQ6amf7wmDjm74RZ/qof16df
 d/2XZCVg9M9TEuXl7bCVO0kFEM7kj64q+rrxCsr/EcjiKwFoa5pMwctRO3WIGl9hygYurT1
 xUcmyaaACAuHcjwnRxjMCOWUJDd+s5zXH4C7ySciTHr6AQwq7Ven56FUXnSgQRNg0ZuqKzq
 5k139y9p0lUgjXE6QC8mg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qC+5Ph0+A/I=:oykmP4N+z8mRB6ZHGVQrfZ
 qS9MjtaSobVf4mmFHwi0A9uk7f4VQKnl04qopkZ8IKQ5p8BklXr8SbATSTy71IfNMAE4bX18M
 vHKYCeRlJmWMsoeYkDzWOWLrG9BDvAj0M6wSQgh+9QU2ViSAXgRoqm8wkmQ4udQIAEClIQcYf
 jB5BH4m/SBYeFhqnEzzhOuQKg4jeAfDJOvJR2ibZppXLDvW3iMOxA5gMEe9dL0OhTXcLJReZL
 DVkWmmS6z6jlJfg2j61GDDPZO7kFnOB9kGRwT5yqAutCIfAhXDqy7B/u9KHwZbT8YqRz3gN+D
 8OcdHRc9zeLJW5o66B1Mgvazb1+r+q2DV3vI+I5oaOUpZml/nSE0clJDtFl3KgfWdejJV/q/4
 7FRvpeFvdOuNJzINbRdX68YA9HdRkqlekDV5yOW2/K5l3s1DMKfSBJRb6MY3L8NJYnHGUhJCp
 1FYyJ/kBm2gtt7C1f0ptQeQtpIDtxvgtgEa6rRjciw2+ox5LU0ZI1qOcxS7JfsFBQV4Qq/lUC
 FoiatJ4mc49HItrlN09yGKQngkE8KwK2R2bnl+oRdGPasKivuDaMFz5dfdzRR+q4W3tzul5UY
 6m/E0VEedrCUtnPy+K2KVYcevNL/qVzSWOIJ4jZU+ejFxVGH4NWtYmcbL053Gl+7TAmFP46z7
 UakMDaobgK7zhXQFn9O4nxtiVZE66+PVLaKnBxcoY//tkqljueWyq3lM88a3j0oVGt41k/qFW
 sWJw9s+1v0oG2fI1D5RWQEoZ4OKCuvi3sMai8Tql/dY75RVzArHqCHzRyQIDvWB1VZb8XrD1a
 uIztu107mK7Z4HGgxU2O5H+BvjxqANnwGnptKtfqnhvRT4BwHX+hHNpS3WPJcTDxzBI1348
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joseph,

On Fri, 6 Apr 2018, Joseph Mingrone wrote:

> After upgrading to version 2.17.0, this message appears repeatedly when
> running `git svn rebase`:
> 
> Use of uninitialized value $rec in scalar chomp at /usr/local/lib/perl5/site_perl/Git.pm line 557, <$fh> chunk 1.
> 
> The value of chunk varies.  For example the message above may end with
> '...<$fh> chunk 5.'  This is with the FreeBSD packages git-2.17.0 and
> perl 5.26.1.

Does this stop the `rebase`?

Also: could you publish the unrebased branch so that others can reproduce
the error? (I am not claiming that I have enough time; I don't...)

Thanks,
Johannes
