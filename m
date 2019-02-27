Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6FF0202AA
	for <e@80x24.org>; Wed, 27 Feb 2019 14:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfB0OIi (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 09:08:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:54784 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730094AbfB0OIi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 09:08:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8AA16B02D;
        Wed, 27 Feb 2019 14:08:37 +0000 (UTC)
Date:   Wed, 27 Feb 2019 15:08:36 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: Need multibyte advice - Shift-JIS
Message-ID: <20190227150836.495f1692@kitsune.suse.cz>
In-Reply-To: <001e01d4ce9c$eff07400$cfd15c00$@nexbridge.com>
References: <001e01d4ce9c$eff07400$cfd15c00$@nexbridge.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Feb 2019 08:04:08 -0500
"Randall S. Becker" <rsbecker@nexbridge.com> wrote:

> Hi Git Team,
> 
> I have to admit being perplexed by this one. I have been asked to support
> the Shift-JIS character set in file contents, comments, and logs, for a
> partner of mine. I know there are a few ways to do this, but I'm looking for
> the official non-hacky way to do this. This is CLI only, and our pager,
> less, does not support multi-byte, so I'm looking for options there also.

SJIS is about as much multibyte as UTF-8.

Why do you think less does not support it?

Last time I looked there was SJIS locale for libc so it is only matter
of generating the correct locales and using them. Of course, if you are
running in UTF-8 SJIS will look like garbage. 

HTH

Michal
