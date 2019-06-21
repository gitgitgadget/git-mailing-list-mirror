Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633F61F461
	for <e@80x24.org>; Fri, 21 Jun 2019 19:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfFUT3M (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 15:29:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:44361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfFUT3M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 15:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561145347;
        bh=hasH++VVMosxViVMjrhSG9NsXSWJI+TXE60PfzrcTYQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hqXuMIzDVixtSur5dc8OpdZ0xS6kGtq29hCw6F6Mw9pKvytNJ4zXF2qs669BJrb1J
         QOPEB+tB6EnQc/TF35SknHq5aMEvmRWRRYSZcWMwmguI2hDo53qlEUd+K9YaQLEfUs
         DWycZsI4+u4bWkqWVrEmPXpBp5w1Ha4l78UK+e5g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkHQX-1iK2dn3hTF-00ke23; Fri, 21
 Jun 2019 21:29:06 +0200
Date:   Fri, 21 Jun 2019 21:29:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: sg/rebase-progress, was Re: What's cooking in git.git (Jun 2019,
 #05; Wed, 19)
In-Reply-To: <xmqqef3oq3go.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906212127500.44@tvgsbejvaqbjf.bet>
References: <xmqqef3oq3go.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wM/ahtDDKUVldtzK28pVvmcIv41P8ZaXmljcb3DxNV0hBLP5S3y
 W1OlTkGzt3Rlqhz7mgdVW52d6A4sdCEoklqhg9CI7ON5f43drPqNAVQJhgpk6tf4XFXyerR
 wTrxMyOmSX4SOgVaSjOcEBJ0Qz/sLAYcj8kqBLY+EC8EA6TaQQ5Az8Pxq5/YMttsiKWsdKl
 lnE2lk+XWeebZAKwouOag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8+8OhvvcLlk=:zBiHKjx5egXcnol53iEQn6
 9qrml//mY+g8gdjz1dD1KhFs5baJiN86DQ3geuN0R5DS+BspCFMfuXgsltX4A7MRZhJ/w47Gp
 Z1oHAw/mkplrqqUYO5eV4I8yVAAwZaGHKKpuquPq20ommzJFXDkP84xbIfg9aYHgTCaT9Bib8
 G0bBuKzSstXfyguMAz9LYtYEnK4q7ORjyHWKKoaU9KKNJisdItUfCCyf0D+y5EEYr/Ds/MKKT
 zDixZ54plbxYGAUa6vxrhNgMXim+wdACyVJzd7KBexUAMJOiwGrnKn5UrnlzVsh9Xj+3fNGqx
 WOAGPFTTJXsNEP4t6zOsVWTOaxueeJRkvVrkoZRBLmbT8hO0Wtgw+kSxvwuU9P/becYaAqQq8
 31zM6yGOHOUhgRdvVMwUrhZhw8Sk2+7Ns4dvhvivGUJFTKVx895XFq5ne8cOqfrl2sN1dsN5G
 ShQZJU9HOYuxb/sAZedW2vThBzru6Me5EzO316Gm8xvl+hcGiFwAQOeA7DegoWhmRkxeaDh6v
 3ozW6kscqROtGn0MMEOVyqZ2/MHSDerXpMzmdmjIcSwEuTzoQ2N4lDi5UhyE366rrShC1x81n
 w7eJvfsxIt8ts6oqRvGj31lyUUKjga7D2E1DM5G878euHP4t9l0O6M0gQCYsoOSMkv4Cv6Ekr
 9LaN1AHu2Sp2dvc7ynkV6aGw4PzWKsCaoPoQCwDvxhSnU0nGFeCX86u8fBK8z0JwuU4LhqVHK
 f161PbiN2GEg8lnrW7Ut5SY9yh7+Qpi6QZdJE4zacECtCYyqi4MTSIC1N6HH8kDLiXUKZo5Ej
 NwfiRl5Fhj2RFp3JjGw5wn9MUniS+zNkEv3XMDsa87tkkE2MpxHeZH9nL61Q/3JEJ55sN2Wb6
 1aPMR81pnmRnRwheHiRwRsxcwUjAZZXDgnOEiFxEEPwomCvPkZCSdKfy7okTENp25VQx3bsk0
 9yXDN19fVCKdXJVC8avebxQhzBkwBIuZz3LHHqa5RuY3w2Nj5FyCD
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 19 Jun 2019, Junio C Hamano wrote:

> * sg/rebase-progress (2019-06-11) 4 commits
>  - progress: use term_clear_line()
>  - rebase: fix garbled progress display with '-x'
>  - pager: add a helper function to clear the last line in the terminal
>  - t3404-rebase-interactive: use the 'q_to_cr' helper
>
>  Use "Erase in Line" CSI sequence that is already used in the editor
>  support to clear cruft in the progress output.
>
>  Its test may have to be updated to work around glitch in test setup
>  on Windows.

No, it seems that the Windows-specific problem with this patch series'
tests have disappeared (I want to believe that my bugfix is the reason,
but I lack the time to verify that suspicion).

=46rom my side, this patch series is therefore good to go.

Ciao,
Dscho
