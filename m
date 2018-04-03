Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1F0F1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 13:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932258AbeDCNMk (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 09:12:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:54119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932151AbeDCNMk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 09:12:40 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LaGJa-1efnEi47e2-00m74b; Tue, 03 Apr 2018 15:12:35 +0200
Date:   Tue, 3 Apr 2018 15:12:33 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/runtime-prefix-windows, was Re: What's cooking in git.git (Mar
 2018, #06; Fri, 30)
In-Reply-To: <xmqqvadd1epf.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1804031511510.5026@qfpub.tvgsbejvaqbjf.bet>
References: <xmqqvadd1epf.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nsL+yDbzEevE95NcLpmzCtirAQTi9J720htwOAA0re0uryocYFX
 Upa/2/M9C7X1HPuSH9FDY0yKz+mxqA62rP23cPEifsOJ4BvDYe4XZkJqgnl29GNPPX/47kU
 aSMcJrtYgeOznPvEVxG1CTrDw7tbWSpDkid+enQcT7QAav9BrAYzrmIkqJPBWcSe0wVi17s
 Kh455SQVsY/m6encLFrBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W7WBJYqV1lM=:FoomiPdQ/yiI/ftPP91Wi+
 2BJdDYb1bHeXEDW9MDWpz8QniFWBQqsuqHPmlNNDc1f3he9ZXwzfzAP90tzQjwnuyiHDT1p3a
 bmjiuUzIp7vVzu6E9R0GS+PiBJqK5u0figWNIx1FLgZT3B5aFpykn3Rn+vJUU6debQDYAQ5KU
 /ann9I1NFbx8UBTxFjTUO6Ak5559GuGPpAZDqTcTwxkv6V5RDtoePyEaTbicxBuUs+rR+1Xma
 PD3m3ZiiZsVlk6VtsvXLHGwkVfeD/QhPXfQpbU8Xs9NbcImNIFUCPor47vuM9SyxF4LbnmNMo
 hTcqjA4fIAU6wNoWhdaY/OpXRZa/RyQTpN5f+V1mTOPNXoR53hd1sjfUbuAUSSJHm6LGhC+kj
 9RJJzOQYZOTMde8eYFJvxWIfIB1GuCAdS7EusMa98RZqT4BYUb47A6Huc4AZZKuRU9QPKmcRJ
 KG+jI4+4GRTHBrDPR9EfMpgOi4gAKfJeuY+KSzie+pqSK5YMolgzhz4d/IP99KYvYd3PY1PEB
 yOrlwoq70A9VSc3xw0oZnn8+HBD7Gxe7bINAMNOokQVLdxrSy/dc0D2RuoAHQ0GiPZiQN/ZVk
 aUfbT1BeJlCoeCBFyBe14LICzY7lM457iE1ddYgAkJBfqtPhZIsanMtOnRccn7NhEuArtQ6kg
 fs10zcGO6FVR239NXz70/CpNephef7mqiMsDt3zuwyHHaTRS4IYOmkNxOE07Cm9FFxRHtpV7W
 7SU8iBY+FuBacLVb4oJmsaM3leLKeB47Dd+vLOYfFteehKHLzIiEvMVRSB/hfU8GzJnraweJb
 FRFeLPX7fYnFvMW+fScmgIVEnLBAii61zei7+PxGyi9no48leMct170M3Co/TpCE0z79cZs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 30 Mar 2018, Junio C Hamano wrote:

> * js/runtime-prefix-windows (2018-03-27) 2 commits
>  - mingw/msvc: use the new-style RUNTIME_PREFIX helper
>  - exec_cmd: provide a new-style RUNTIME_PREFIX helper for Windows
>  (this branch uses dj/runtime-prefix.)
> 
>  The Windows port was the first that allowed Git to be installed
>  anywhere by having its components refer to each other with relative
>  pathnames.  The recent dj/runtime-prefix topic extends the idea to
>  other platforms, and its approach has been adopted back in the
>  Windows port.
> 
>  Is this, together with the dj/runtime-prefix topic, ready for
>  'next'?

As far as I am concerned: yes!

Ciao,
Dscho
