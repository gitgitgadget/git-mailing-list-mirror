Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D96ED2055E
	for <e@80x24.org>; Mon, 30 Oct 2017 10:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbdJ3KkI convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 30 Oct 2017 06:40:08 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:24663
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751546AbdJ3KkI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2017 06:40:08 -0400
X-IronPort-AV: E=Sophos;i="5.44,319,1505772000"; 
   d="scan'208";a="242810155"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 30 Oct 2017 11:40:06 +0100
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] WIP: git-remote-media wiki namespace support
References: <20171029160857.29460-1-anarcat@debian.org>
Date:   Mon, 30 Oct 2017 11:40:06 +0100
In-Reply-To: <20171029160857.29460-1-anarcat@debian.org> ("Antoine
 \=\?utf-8\?Q\?Beaupr\=C3\=A9\=22's\?\=
        message of "Sun, 29 Oct 2017 12:08:53 -0400")
Message-ID: <q7h98tfszzp5.fsf@orange.lip.ens-lyon.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antoine Beaupré <anarcat@debian.org> writes:

> Obviously, doing unit tests against a full MediaWiki instance isn't
> exactly trivial.

Not trivial, but doable: there is all the infrastructure to do so in t/:
install-wiki.sh to automatically install Mediawiki, and then a testsuite
that interacts with it.

This has been written under the assumption that the developer had a
lighttpd instance running on localhost, but this can probably be adapted
to run on Travis-CI (install lighttpd & Mediawiki in the install: part,
and run the tests afterwards), so that anyone can run the tests by just
submitting a pull-request to Git-Mediawiki.

If you are to work more on Git-Mediawiki, don't underestimate the
usefullness of the testsuite (for example, Git-Mediawiki was developped
against a prehistoric version of Mediawiki, the testsuite can help
ensuring it still works on the lastest version), nor the fun of playing
with install scripts and CI systems ;-).

Cheers,

-- 
Matthieu Moy
https://matthieu-moy.fr/
