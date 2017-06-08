Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67F491F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 10:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbdFHKmD (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 06:42:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:60212 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbdFHKmC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 06:42:02 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsUDg-1dysOK42jQ-011yr5; Thu, 08
 Jun 2017 12:41:09 +0200
Date:   Thu, 8 Jun 2017 12:41:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 03/31] config: don't implicitly use gitdir
In-Reply-To: <20170531214417.38857-4-bmwill@google.com>
Message-ID: <alpine.DEB.2.21.1.1706081235130.171564@virtualbox>
References: <20170531214417.38857-1-bmwill@google.com> <20170531214417.38857-4-bmwill@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PPe9tU2Z5pmS3f3Us7Zan/i9pjzSL6ZbkFxXiPYCJ0+RPh2u5Rs
 OLcSz6Xv2T3gLNFKcI18OQqxjUZ53rgeoREqkteHm0/P9EIGxH3NOsTZtB9fOKn0odJ7ysD
 JMpuP2DSjwqSjJpsen5MdlwtN8Hbgu0CWdQfAerSKbLKcNm6WA86pi2xKxd8wH3aurIzJHu
 CsE/SFQMZT7VL2k4yYqWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+O8LyiuxhIE=:1LmblTqmOdvrro+dAEQWgb
 /K3lp4BcM7rjlsc39kQeHOvbrnLaJtDuF3KdkFMQFKAYjNMtwHt/f45lVtUd8BkPQVqeq8p8f
 3X8u0KZafeEg1lM9CRHz+9y8DXtXUsuyXHltu8cwFYcw7lVtCPFpESmyjybc7dK3eD/q3qidZ
 EEu0C/0tHcBt2ppRAS60BvoNFUMMAnlZBPRJBHLQ3V+gcRdvy7+jz5Vof4b4few0vsqLOEH6W
 PHOWq4MhxBVxyWxGeh0U/AgBETpW8W2++cdzu76pr24CwzzdZXJp4Wk1HyOMLWMNqAIQHclHK
 yT2ZgwPL5B9okH4BeDNXQXsvQWHbqyb/hpoppdrdgwjlCS/Fut65+t2KuCXUXK2bMkAiKUVP6
 94l40IRDmx0e/P+4PpQ7R1Osg9J6Q2CFdV6CPalAcU/GlQ4uLCDG1MZv7sDgWQv/d7596vj8F
 tcbUEmrw8GWsKAS7TDuq0kyWWURaATN3loXwhuHGqwAiSp2mZOhqCgxV/vHlyp0lnVA/imGiL
 j8Hvj+ht8OSsUhLzmrL/UCBumDICGmHUE34KkAbQzMfJfqZhgDbGNIlqTCbLhT3p7ju9tRt1G
 8devkFwynDW+qk7taxGEBZAaNDRwV3ZVBzJBZR5NJg+oMAd26FIHXGA63Ht1M9Rf1jPIp5Mwr
 nNuxauYcGrjiVhkUEiikN68lOc3uJ/iVOhBgDeflXUDB23drpgMF/vVVxVm+xBOp4ToYab26r
 2j1NjWKe9VRgtEB7ZYUfhYBwim7HxYO/TbDMyuq9rp6BbG6C6LDUdEr8BHdnYxmzHzKLYz3a1
 avYKBFe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Wed, 31 May 2017, Brandon Williams wrote:

> Commit 2185fde56 (config: handle conditional include when $GIT_DIR is
> not set up) added a 'git_dir' field to the config_options struct.  Let's
> use this option field explicitly all the time instead of occasionally
> falling back to calling 'git_pathdup("config")' to get the path to the
> local repository configuration.  This allows 'go_git_config_sequence()'
> to not implicitly rely on global repository state.

Oh wow. `git_pathdup()`...

Sadly, I lack the time to review the entire patch series, but this here
change definitely looks correct to me.

Thanks,
Dscho
