Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C64A1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 20:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757346AbeFSUzo (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 16:55:44 -0400
Received: from alerce.blitiri.com.ar ([51.15.5.42]:59368 "EHLO sdfg.com.ar"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755479AbeFSUzn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 16:55:43 -0400
Received: from sdfg.com.ar (authenticated as rodrigo@sdfg.com.ar)
        by alerce.blitiri.com.ar (chasquid)
        (over submission TLS-1.2-TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384)
        (envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 19 Jun 2018 20:48:24 +0000
Date:   Tue, 19 Jun 2018 21:48:24 +0100
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>, max@max630.net
Subject: Re: t5562: gzip -k is not portable
Message-ID: <20180619204824.oahvg7bxyqxnrqp3@sdfg.com.ar>
References: <5ee7a65d-63e1-aa6a-c3c1-663c092d0efe@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ee7a65d-63e1-aa6a-c3c1-663c092d0efe@web.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 07:25:15PM +0200, Torsten Bögershausen wrote:
> Hej Max,
> 
> t5562 fails here under MacOS:
> "gzip -k"  is not portable.

What do you mean with is not portable?

I wrote the patch for gzip[1]. That was in 2013, and is included since version
1.6 IIUC:

	$ git tag --contains 0192f02e26ac9fa0a27ed177263ee3ea73d5e95c
	v1.6
	v1.7
	v1.8
	v1.9

But that maybe is too new? Or do you mean something else?

[1]: http://git.savannah.gnu.org/cgit/gzip.git/commit/?id=0192f02e26ac9fa0a27ed177263ee3ea73d5e95c
