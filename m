Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23243202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 15:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753509AbdCHPlj (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 10:41:39 -0500
Received: from mout.gmx.net ([212.227.17.21]:52527 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753108AbdCHPk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 10:40:57 -0500
Received: from virtualbox ([37.201.192.247]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6vSj-1c0q3A3m8z-00wngL; Wed, 08
 Mar 2017 16:40:50 +0100
Date:   Wed, 8 Mar 2017 16:40:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: RFC: Another proposed hash function transition plan
In-Reply-To: <22719.59633.269164.986923@chiark.greenend.org.uk>
Message-ID: <alpine.DEB.2.20.1703081638010.3767@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>        <22719.680.730866.781688@chiark.greenend.org.uk>        <CA+55aFyyi0vBBApf9grYQzF2PRZMjtCzkB4LzYvLpqQ-Z7QfJQ@mail.gmail.com> <22719.59633.269164.986923@chiark.greenend.org.uk>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LTWfCMl+gNcwi4abfD4ALo+74QXUm0FNOHRcWWmDlPF+VTAYSwK
 W6xOsYHSft47g7ZsKw9LMAbUsP2k0LV0yvPTmFOCydbcCebg5mTaoN2POD10DikgvCfRSi2
 +eLNN/6RSiWgsfcplI5skq7JqsAaHewtBZtIhZLqobNf3Hm3aD1eOl8DVNukmmCsbxr0kwy
 QLlbRQA6ReowgHheDTlZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5+vqoCROA3s=:rd3AulpWodh4WH1lfhybez
 eX8tsAWPvkGnZzesM6XYRFy+4ppjRKO16QkolAg+OzJAUKTzEPJObdwICV2EvN2UUT0x2hR7f
 osBYs0EoH13SaD16QnIwJIaw4ZaJhuJpcPdLdQ5jOKa02yVMtCRpfD7OhWoLmLzOJ0WQMLW41
 upTedjcbdZZqRaqtu3uk1W2ScUhze7u6t1h8ahlWvInPBUkGUGoUFkzhBpEA5pH4yptgdRZkz
 tmu4yvT7QzFUCkKlsnsOuLxoT0gNDA2nLvv12U+hGy//Q+t3XXGQpzS/H8+Iy8dzefqMtq33s
 Br12Fi6eNJAt/PsITJI/fVtlVD//rg55C8UW4/OpJQWX2uA0mw60vHlJDx1+A6vtZUjWF096Z
 zXulsklp9MSuasGw1IvrnTXBZcjVuJqCg6AZhkn9vZKkYlV9rTtpnsV5F6TDjVQlg380cLNKR
 6m6GV0At+65mZxkQXMMxQ+U0wYXV+FSU7WtauUWD8oe02fwaSsBokca2AmfB3SBlivW7Y+swl
 +nzpmavCVd1ULVUFCVYPzDzKymc9UyEMM/kMxVxR0RLqmG7Q6T8NVxNhG5rCClDqH3hi6WUt+
 9yw0CQVO7JkTX3eLnon1LJ/Db0mRPGLh87lN4KVLptrTFVmhbFj1BWBJbCM7avbzngTUTp5jw
 stLskL8osXJbjgQeE92jPp9i7Jh4drH6lcb/zn6+4er2VpKCs5+UHIKSuSuC77ODdl7eVCRd1
 w9WLWAtOTyw5NTLAxEbnPvnekO3oltl3td/bXiuNv6YfWrv8TJpy2kciPVyH7BfEbMfW+pTFx
 Gj/hdOb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ian,

On Wed, 8 Mar 2017, Ian Jackson wrote:

> Linus Torvalds writes ("Re: RFC: Another proposed hash function transition plan"):
> > Of course, having written that, I now realize how it would cause
> > problems for the usual shit-for-brains case-insensitive filesystems.
> > So I guess base64 encoding doesn't work well for that reason.
> 
> AFAIAA object names occur in publicly-visible filenames only in notes
> tree objects, which are manipulated by git internally and do not
> necessarily need to appear in the filesystem.
> 
> The filenames in .git/objects/ can be in whatever encoding we like, so
> are not an obstacle.

Given that the idea was to encode the new hash in base64 or base85, we
*are* talking about an encoding. In that respect, yes, it can be whatever
encoding we like, and Linus just made a good point (with unnecessary foul
language) of explaining why base64/base85 is not that encoding.

Ciao,
Johannes
