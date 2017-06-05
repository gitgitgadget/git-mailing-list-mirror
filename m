Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA471209FD
	for <e@80x24.org>; Mon,  5 Jun 2017 08:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbdFEIsn (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 04:48:43 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:41201 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdFEIsn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 04:48:43 -0400
Received: from tigra (unknown [192.168.2.102])
        by hermes.domain007.com (Postfix) with SMTP id 970BAD400AA;
        Mon,  5 Jun 2017 11:48:40 +0300 (MSK)
Date:   Mon, 5 Jun 2017 11:48:40 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     christienne shultz <cpshultz86@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git Error Message
Message-ID: <20170605084839.mmirmdtvlpdqgwgo@tigra>
References: <CAPMR3RcMK_Dt=4g6JJjQ9DVhCn7PLY2xAPXM1OgZGaqyVSeP=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPMR3RcMK_Dt=4g6JJjQ9DVhCn7PLY2xAPXM1OgZGaqyVSeP=A@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 03, 2017 at 01:13:05AM -0700, christienne shultz wrote:

> I have installed the Git software and upon trying to update a
> repository by the "open recent repository" link and am unable to
> access the menu-or anything-from there.  Instead a window pops up with
> the following error message:
> 
> "\usage C:\Program Files\Git\mingw64/libexec/git-core\git-GUI[
> {blame|browser|citool}]
> 
> Can you please tell me what this error message means and how to fix
> the issue?  Thank you!

A shot in the dark until someone with access to Windows chimes in (it
appears that the "open recent repository" feature of `git gui` is specific
to Git for Windows): have you verified that repository actually exists
on your filesystem?

Another interesting question is whether the pathname of that repository
includes space characters which could in principle confuse `git gui`.

