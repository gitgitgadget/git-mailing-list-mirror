Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7576DC2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 20:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AB720838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 20:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgBGUuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:50:32 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:61768
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726947AbgBGUuc (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Feb 2020 15:50:32 -0500
X-IronPort-AV: E=Sophos;i="5.70,414,1574118000"; 
   d="scan'208";a="338479298"
Received: from 91-160-5-165.subs.proxad.net (HELO [192.168.44.23]) ([91.160.5.165])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES128-SHA; 07 Feb 2020 21:50:29 +0100
To:     git@vger.kernel.org
From:   Brice Goglin <bgoglin@free.fr>
Subject: fatal: cannot rebase with locally recorded submodule modifications
Autocrypt: addr=bgoglin@free.fr; prefer-encrypt=mutual; keydata=
 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
Message-ID: <660c39af-d0f2-5e4c-66a0-5c78b646b023@free.fr>
Date:   Fri, 7 Feb 2020 21:50:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

I don't understand why git pull --rebase --recurse-submodules fails after a git reset --hard
to the previous commit. I didn't touch the submodule, it's supposed to be clean:

$ git clone --recursive git@github.com:open-mpi/ompi.git
[...]
$ git reset --hard HEAD^
HEAD is now at 395e2c9d8f Merge pull request #7364 from awlauria/fix_compile
$ git pull --rebase --recurse-submodules
Fetching submodule opal/mca/hwloc/hwloc2/hwloc
fatal: cannot rebase with locally recorded submodule modifications

Why is failing here?

$ git submodule status
 38433c0f5fae0b761bd20e7b928c77f3ff2e76dc opal/mca/hwloc/hwloc2/hwloc (hwloc-2.1.0rc2-33-g38433c0f)
(that's expected)

$ git status
HEAD detached at 38433c0f
nothing to commit, working tree clean

Thanks

Brice

