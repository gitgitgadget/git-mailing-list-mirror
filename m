Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 498221F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeCWRmY (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:42:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:42951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbeCWRmW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:42:22 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0McUnM-1fH6511lMu-00Hil2; Fri, 23
 Mar 2018 18:42:15 +0100
Date:   Fri, 23 Mar 2018 18:42:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Wink Saville <wink@saville.com>
cc:     git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
Subject: Re: [RFC PATCH v3 5/9] Use new functions in
 git_rebase__interactive
In-Reply-To: <387b3dc01562fd30f5894c91109d1a9d00d07720.1521690197.git.wink@saville.com>
Message-ID: <nycvar.QRO.7.76.6.1803231838020.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1521690197.git.wink@saville.com> <387b3dc01562fd30f5894c91109d1a9d00d07720.1521690197.git.wink@saville.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:I5Nlc3OvF42a32d26MHqEJY9lTq6bd+I6Te3POC0vHFnCkg+DuV
 RCK/lD76qTQARmQFSb8bH8EJrwyP9FlP3FHVWqLKhzegVd1T1vQCiMSR6/MtPp13Zv/SIMz
 6KHaILLqySx+3BZss6erW27hatfys69o4eCkn2GjgjLTREXbRn29Yq9ebE3mxE/Zzn7H4RS
 tg86c1F05An+r5Ssolliw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yFbiyklSG+4=:tdYRtAd0kE3Stmw6ZHk9eO
 VOXi8RqkspMhofOMoVhlq9QvFaxwtHX/4n8Whsfzg/3tRUQKI/FPFNdX44U7I5wSP0oOEefEs
 jfI7dLNmSvWhaipj6gM1+HDzzrDuqWCLzNs63xoS49XSTCD7sloxr0CVgjshBPq63tqa+f+JO
 Wmj/LUjxXl8TTmbf/BulZ2VFET5ViSIpGqnKcOm+0RBvqOWfy/vP8kHS+AOkAQdrU5+2jCuH6
 YgrXud6GsjraxXiu8tWdZDVfixPvkuTINZMzlr3xEGY7QmLNFpiVO0FpDuIE8NuE8AaEhM3jX
 Wn1GPBL+qDP8LJQWQ4pzgTXd9IcDddwzxMp3qvEkKGyz43X+PycvqIL9+W6cQIPc5G0hm5MOH
 VDdLuiA9JFfxzgs6rMQlqDqbGXPFRv48+X6+OkMHaun0owbQYBSxCF7yj6MfOUYjGvT0VPRZE
 CYv7ZWKHMsNH4deZdFo1EEbawmuVkdBI+zYIfXrhXjurSswoKlNDm/gr3t8VsgJctk5m9GkZ+
 znLlcS9noPJ2s9+CuK5aWgIVo/QWl8KY2oIuyLsrI8ArWQSBnnmjzY6GhCdiL5kAOVltj8K7P
 +rBCUi/2ui1m4rvrWlpdqobdmGblacPxHqau0CFqGlI2LZCE9MgYFyAK3Z8QlOHdOjy74iZxN
 FZVeHIRS3j81Ioselin9FfDZLFbD/yIiITiSyvjEXNQGljmaXB+g2RcQaqQm6w4xFP8B1cFDm
 3jgiMTfutCIc5b7pU1DCVhQr4bAQOFoPy3EaVnBKMhJNxknCjBVQFH/3oA3Tm3UN219+cqQ59
 7gKzyT8OAKRPab3FeeBS+VtV9mAvQ7TMNn1Ur16E/pDcTFkGCk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wink,

On Thu, 22 Mar 2018, Wink Saville wrote:

> Use initiate_action, setup_reflog_action, init_basic_state,
> init_revisions_and_shortrevisions and complete_action.
> 
> Signed-off-by: Wink Saville <wink@saville.com>
> ---
>  git-rebase--interactive.sh | 187 ++-------------------------------------------

If you fold this into the previous patch, I am sure that after your 3/9
indenting the function properly, the splitting into functions will look
more or less like this:

-git_rebase__interactive () {
+initiate_action () {
+	action="$1"
 
 	[... unchanged code ...]
+}
+
+<next function> () {
+	[... setting up variables ...]
 
 	[.. unchanged code ...]
+}
[... more of the same ...]
+
+git_rebase__interactive () {
+	initiate_action "$action" &&
+ 	<next function> <arguments> &&
+	...
+}

In other words, it would be easier to review and to verify that the
previous code is left unchanged (although that would have to be verified
manually by applying 3/9 and then looking at the diff with the -w option,
anyway).

Ciao,
Johannes

