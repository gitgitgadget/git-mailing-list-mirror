Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F99E207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 19:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967123AbdDZTtq (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:49:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:53016 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967118AbdDZTtp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:49:45 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lp8h6-1di0os3S56-00eq9F; Wed, 26
 Apr 2017 21:49:42 +0200
Date:   Wed, 26 Apr 2017 21:49:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v1] travis-ci: printf $STATUS as string
In-Reply-To: <20170426193933.28961-1-larsxschneider@gmail.com>
Message-ID: <alpine.DEB.2.20.1704262147550.3480@virtualbox>
References: <20170426193933.28961-1-larsxschneider@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Vwk0zE52UQk/+/6tx3UBFa8CYIFnVDISrgUKvfyhr/AO7kPRGTP
 hKxbB8jVNfnkvLvu90gi74Y2kICsqNfIKf2qaxU5oW56CD9HN/Vj9i4QdjDdsjEhYZdinTj
 MfsAFr6cbewRqkvcE3S8aEufYXRhhuMhd5Wi8ZtBwBJm7Pa44cwftnpC0f5Qq2K2Svq1ocN
 9ECMSnRptbWRD7UCN3z+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M7DQ3GIm9U0=:gLjITAf67B24O+Wvji1YGO
 2Oiu93hp9GzOPd0xEbFuD6mHZb91k3wJL4wqITNofYtIOf9yJFsNEI92imaOf4mSmbhjI4QB0
 h2E5AoRCFFny4T3r9iZgx6L7wtvNEXwysKsy5qlDtAdvCavAMgbDgOelZl6DtuhIBKLmbR3hE
 Z95tpjVj3qo7m1ehduNjmnox4rxMhIMYSoZJRJ7iteGyXpvTZwbDuSoD7vjBK6wSZ/PoNsLAm
 nyvbFGpH4VQGmeTftQU0r0ihw2jRiN0JzzPXjAGxiMv+Iapbb5O5xZOvElt+x1wM+N9pMVHt9
 s0nkYUcgc5KJVBiG24CROsD+EYp5OawjixoSb5e1pQap9eXZnSRLxMTLXAJIHnItFUHjp3Rl1
 jCpPgR7PWxktzXE7tvnh44BSR6WaX1pJ68XY58NtS5O2L5+PBqMlQYohRvSUXmLgxTFY2p6zP
 k3x2ZI6CMlqFaGmgKS+EJHB7k+7cduZr5g4aLZH+ZuSD9NChfC2P1s5jBm6CuKQgj2ckiRfyK
 LKzNjBzAPwwZdizCao/NsXAcv2OtrAjq8VV7gQp7nCygGZlfCgMy4mMoUc1Lh5JZas5vDSdO/
 vpL1np3Go2zJrxcmGzaDaE+6RyfMoq5ys0g3Sef6OIpbyT5pyOch2R8NcPebftBZzIj8sMLCF
 PO/p8q6rI0SrxWhyyoGCj5gmaV/dtQssDCoJWkLeKVm2NVT1C7cCgYGwudf4hOVTkXg069m6b
 12lLngu07GNis7oq6v7/gjYcFaNIsKzCith2oozRVOYE65W5SA4AWH99+Vg7FEtv2jnER4+IN
 C6yHvuN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 26 Apr 2017, Lars Schneider wrote:

> If the $STATUS variable contains a "%" character then printf will
> interpret that as invalid format string. Fix this by formatting $STATUS
> as string.
> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>

ACK.

For reference, the status should always be a single all-ASCII word, but
sometimes it looks as if there is a server error that returns a full-blown
HTML error page (including a style that contains something like 'width:
10%;' which would be misinterpreted by printf as a format string).

Ciao,
Dscho
