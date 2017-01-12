Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4141820756
	for <e@80x24.org>; Thu, 12 Jan 2017 09:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751094AbdALJm5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 04:42:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:62297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751005AbdALJm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 04:42:56 -0500
Received: from virtualbox ([213.133.108.164]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0ML6XF-1cRKn12zTN-000ITJ; Thu, 12
 Jan 2017 10:42:46 +0100
Date:   Thu, 12 Jan 2017 10:42:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jacob Keller <jacob.e.keller@intel.com>
cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/5] describe: teach describe negative pattern matches
In-Reply-To: <20170112001721.2534-6-jacob.e.keller@intel.com>
Message-ID: <alpine.DEB.2.20.1701121041450.3469@virtualbox>
References: <20170112001721.2534-1-jacob.e.keller@intel.com> <20170112001721.2534-6-jacob.e.keller@intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7I+B13h00YesVnTaM4snADvz6Yt5tTpIEmcXseOzJeddJJzfJSZ
 sGqtt62ljh9ueWW799Nz7Py+es0xJ9Vb4Wa1Es6Oae04fHvdU3aS5/cFZtuGyNYzBNQZRok
 XuTeM2WmrAvrwfuiznLP5+1pGhkPH+qgromvrFoNpjhhCXi8Y/xxXk9zVnxyTqYR1X8Wgm/
 BwY1cn4tOXbLDsD73CrWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0eKrLMoCA4w=:70FXYXpik1ShVQq3MwrJf7
 lmTiVQtH1Lcvt1km9XTrYR+AZq09BYiZKsWou+pXrnvfI6JEEjGRLuGMD4rUS3tnVEd/RbjHS
 /GwK0XBzLXjAWdahQOGxwe0QLllZmnG5a7okWcTkp6K2L66gx4HpO1RK6XCpnDnwoqM7w1Ha6
 52Yi6vTs0o//Kx+1sJqdcpQ00I74OkBsZufgbURzWkn0BT4sHRuYDI0h4EtNbd5Q347AhUJnU
 /63bXG0RNPmsX8yV/Ho3A/pnNxWqtBXCOBLgU0toJZy7SeERciFe/w0sdZAsuc4f9GfzZ04VI
 tKX3g/8zKFhq5rVbbS4JwIN+3YL613fN6ExfwytHMMYgLOgH4Pj0jncxP8giYPYk9dxzHln7+
 6g4xqgpoHNN91BXuxNhcbPQ0KUNcc2ENE+hltkOncBhX3+ENGtVwl2yJ/tcjR/gxUCUhPeDNT
 uCyow5kH+dgEistU3NE+eSqltzN3td+QtiDfuDpYtNqc6VXCMvkhucHrgaPaaaN5E0D7hKCVT
 2MAv5HngBO1zLH1o0m5/HfijdfI70H6L5wibIHa9JQzqvdv5trjB8YUgXaDWSQypz1/7HFJsi
 qQoSFhQkTkOPD1OakrPcmBKd2nfW0UY5bi0nZ7h2IqUd0/zN2CIgxP9hZHiRYPHPspOf5jCYm
 a+i4dy7S2XoYSdlYhWeCwvWg/F2uDWlRPw1mZpiT7hVjh3mp1p5Mkf1wn7o+dT9Np6bkuvpMk
 zbwBGJpCgQzBof/GNzwBC/kt/Hy21bx7MQ5MnHJXLoLcLHF3ornZy3RngvzA9oFXTzertQ8eq
 GUziGO+rjEzSCWaWwl1CcyINrAepA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Wed, 11 Jan 2017, Jacob Keller wrote:

> From: Jacob Keller <jacob.keller@gmail.com>
> 
> Teach git-describe the `--discard` option which will allow specifying
> a glob pattern of tags to ignore.

IMHO "discard" is the wrong word, it almost sounds as if the matching tags
would be *deleted*.

Maybe `--exclude` or `--unmatch` instead?

Ciao,
Dscho
