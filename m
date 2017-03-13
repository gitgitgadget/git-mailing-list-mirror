Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2316420373
	for <e@80x24.org>; Mon, 13 Mar 2017 19:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754056AbdCMTtF (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 15:49:05 -0400
Received: from [195.159.176.226] ([195.159.176.226]:47095 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1754529AbdCMTtB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 15:49:01 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1cnVxc-0007M2-9u
        for git@vger.kernel.org; Mon, 13 Mar 2017 20:48:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Christian Neukirchen <chneukirchen@gmail.com>
Subject: Re: Stable GnuPG interface, git should use GPGME
Date:   Mon, 13 Mar 2017 20:48:48 +0100
Message-ID: <871su1arfj.fsf@gmail.com>
References: <201703101100.15214.bernhard.reiter@intevation.de>
        <20170311001031.f5534omsrzkrzfzb@genre.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
In-Reply-To: <20170311001031.f5534omsrzkrzfzb@genre.crustytoothpaste.net>
        (brian m. carlson's message of "Sat, 11 Mar 2017 00:10:31 +0000")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Because the amount of the gpg API we actually use is very small, a user
> who wants to use a custom signature program (say, OpenBSD's signify),
> can actually write a simple wrapper that mimics it and use that instead.

FWIW, I did this, and it was quite some effort to figure out the
actual API that is needed:

http://chneukirchen.org/dotfiles/bin/git-signify

-- 
Christian Neukirchen  <chneukirchen@gmail.com>  http://chneukirchen.org

