Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF861FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 16:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753293AbdDRQ6f (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 12:58:35 -0400
Received: from ikke.info ([178.21.113.177]:39382 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751197AbdDRQ6e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 12:58:34 -0400
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Apr 2017 12:58:34 EDT
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id C30E84400B7; Tue, 18 Apr 2017 18:49:17 +0200 (CEST)
Date:   Tue, 18 Apr 2017 18:49:17 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Christoph Egger <egger@cs.fau.de>
Cc:     git@vger.kernel.org
Subject: Re: GIT_EXEC_PATH
Message-ID: <20170418164917.GA24697@alpha.ikke.info>
References: <A351EA5C-734D-4833-821F-1B5AA49895BF@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A351EA5C-734D-4833-821F-1B5AA49895BF@cs.fau.de>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 01:47:14PM +0200, Christoph Egger wrote:
> Hi!
> 
> Concerning $GIT_EXEC_PATH .. is that supposed to be a $PATh like variable? as in can it have more than one path (colon-separated)? I have currently two directories there (one with a git-annex installation, one with the normal git stuff) and it seems to mostly work. However git-sh-setup is unhappy:
> 
> > % git pull --rebase
> > /opt/local/libexec/git-core/git-sh-setup: line 46: /opt/local/libexec/git-core:/Applications/git-annex.app/Contents/MacOS//git-sh-i18n: No such file or directory
> 
>   Christoph

Hello Chistoph,

The exec path is not just $PATH, it should just point to a single
directory.

See [1] for a recent thread about this:

Junio C Hamano wrote:
> That environment variable is designed to hold a single path, not
> like $PATH that lists multiple places in a colon separated list.

https://public-inbox.org/git/CAJF7t-dqSa7tmQqNEWmg_VZ=+832nsZ-3JmSGA03qK6aY5eNTQ@mail.gmail.com/

Kevin
