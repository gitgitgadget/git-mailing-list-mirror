Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0A6020282
	for <e@80x24.org>; Fri, 23 Jun 2017 16:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753942AbdFWQo5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 12:44:57 -0400
Received: from siwi.pair.com ([209.68.5.199]:50826 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753368AbdFWQo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 12:44:56 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2E6E184555;
        Fri, 23 Jun 2017 12:44:55 -0400 (EDT)
Received: from [10.160.98.126] (unknown [167.220.148.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 89A6884520;
        Fri, 23 Jun 2017 12:44:54 -0400 (EDT)
Subject: Re: [PATCH v4 00/20] repository object
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, avarab@gmail.com, jonathantanmy@google.com
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <dadf3fe7-180b-df3a-f5f5-932905f08335@jeffhostetler.com>
Date:   Fri, 23 Jun 2017 12:44:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/22/2017 2:43 PM, Brandon Williams wrote:
> As before you can find this series at:
> https://github.com/bmwill/git/tree/repository-object
> 
> Changes in v4:
> 
> * Patch 11 is slightly different and turns off all path relocation when a
>    worktree is provided instead of just for the index file (Thanks for the help
>    Jonathan Nieder).
> * 'repo_init()' has a tighter API and now requires that the provided gitdir is
>    a path to the gitdir instead of either a path to the gitdir or path to the
>    worktree (which has a .git file or directory) (Thanks Jonathan Tan).
> * Minor comment and commit message chagnes
> 
> Note: Like v3 this series is dependent on on 'bw/config-h' and
>        'bw/ls-files-sans-the-index'
> 
> Brandon Williams (20):

I read thru the v1 and v4 versions.  Very nice.
And thanks for splitting the earlier parts out
into independent patches.

I didn't have any complaints, but did want to ACK
that I had looked at it.

Jeff

