Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CCB51F667
	for <e@80x24.org>; Wed, 16 Aug 2017 12:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbdHPMaO (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 08:30:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:57836 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbdHPMaM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 08:30:12 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYOCL-1e4FXc1Y3t-00V4cS; Wed, 16
 Aug 2017 14:30:09 +0200
Date:   Wed, 16 Aug 2017 14:30:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        Johannes Sixt <j6t@kdbg.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC 0/3] imap-send curl tunnelling support
In-Reply-To: <CAGZ79kbgYqo=6FvRNwB0AOKT8mioPTu2CearVttA30nZ8wBMHQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1708161429510.19382@virtualbox>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com> <5c46f1e4-825e-8e10-e323-e637e170f315@morey-chaisemartin.com> <CAGZ79kbgYqo=6FvRNwB0AOKT8mioPTu2CearVttA30nZ8wBMHQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ldBIvwaXi4sD3FhClmQhqjWrorEIVw8NYuRMfn0sUO0Ljwrxc53
 TB//NBjitsOzKKGJUnu6r7nZSnJz4s+pJcGNZ/d6Zk4zmWGoY3U5ElhxArMzWC2+8Qlcosk
 eFgYXKw6ssh3/cMo6QXti2HCahCKe7NtGHEHu/XnBrei9ZkK342fGE/wB4re8Ba3xaf+68j
 mjbuZq2x6MzFHyx59MOIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G85u4gSqcgg=:Dzp4iU5LHg9xvBZx7d0qbP
 8VwOXs9NOBbiz9NqUCEj3D9vFrQ/IEun4KzvcaiNvjZaanefeMUpteSwXQJ6VQRlbyoLE4LHe
 whPsddy5ztdtHJNMjzOiQIDxpgB/vr5HBkcZNSut9XXfc7Mad6jcoa9l4F9/z9z0xWJksQY2u
 yYQ02mU+6071VkTujNXVcgMN6X3TuzmTgxcTrvVdRNPkYH3ujek6wGfXXpTxlpnM5Rp1g8UaL
 yJvaoWZnLhkp0RPCu16Dzqfo2cvf0dM/ebK2LN6MWvKlpwl3/vYwbLQNmEQuS2tF6c/Ldqe2d
 zt0+/Y39dwFjDQen1it7I9JFkncMxK8yS3RUGuTm2QkrHG8qvY1CP/TZQkd+TUzeGCrzE2yO/
 q1C3PKBZVXpWOthqdggnMigFkhaWSsUtNkzR/SNpyhn/rqjKO0jR2dpCEFq/psEuQ83DCub//
 IZk6agX5Ztm/Jfn4KGVNTESzdXg0r8jvQzpCtY8rZvasA59F7jMhwuJWjkjrvvETLsWLD9Vit
 2j1O/YsHLXLI3qZqPX6U/VSXWvlmIONXvD/gbsGodh4rcrQJT7+xidJz015Jq/VYShdBnH53I
 hkXxOAhvyB2Wdn9AbHlo2fyvmmUg8WjQenIWTMp2f06nYSOlYfZoM++SYPP27iYmXSEisoFnq
 BxE4WccUKIUUqxKZ7TDRYCOERCdFxvIgO09il2wvPz2bvGsQiqjkRVyWp/Oejxwdk7dtY6FFC
 qIqwl0FoKkn05WDTawDTlkp8Vc6jzjjEnEMe5GZhFto6uKCCJqOb4uwy3olmW7rkcRE4wt8KJ
 fdS2ZQolUrnpJWOwbz54AAkVrt3IAwgSRvTPP+AHL+fMg39wpg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 15 Aug 2017, Stefan Beller wrote:

> On Tue, Aug 15, 2017 at 10:49 AM, Nicolas Morey-Chaisemartin
> <nicolas@morey-chaisemartin.com> wrote:
> > Ping.
> >
> > I'd like to get feedback from Windows developer on patch #2
> > Patch#3 will probably need some updates as I expected Jeff old curl drop patches to make it in.
> > As it seems to be going another way a few more ifdefs will be required
> 
> +cc Windows devs

I can has easy-to-pull branch, please?

Thanks,
Dscho
