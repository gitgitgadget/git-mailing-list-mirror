Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00FA7207E3
	for <e@80x24.org>; Tue,  2 May 2017 12:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751009AbdEBMJ2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 08:09:28 -0400
Received: from mout.gmx.net ([212.227.17.21]:59865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750886AbdEBMJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 08:09:27 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3i8r-1dwfKn1P9t-00rH6p; Tue, 02
 May 2017 14:09:16 +0200
Date:   Tue, 2 May 2017 14:09:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: PCRE v2 compile error, was Re: What's cooking in git.git (May 2017,
 #01; Mon, 1)
In-Reply-To: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1705021406510.3480@virtualbox>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-11176614-1493726956=:3480"
X-Provags-ID: V03:K0:11cfVko/9S2pnQaqD8UDFxWPLMTCmHJzt7Sd1RKnSsvQXNZ25+L
 jfSNHXnKoYh/B6m56yd//xEOy9XjPZF0U/Gx3V7AfTnS2zAFnhfVdiZyFbZlMPAimIQpLkg
 AenW620+qqXFgqA3i+mO9NOr9j5sBY5Lpxh8HUFrjOEGGiusHSi6auoocH3Y+Ieuhj00Zdu
 Pb7bjwk6Kgb4jrftHy53w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V/gwyWIdzLM=:/6sbuViLAY76Rds0IczPWg
 QF1EoiSIc791W96H/v9bFG0SWMw44+lG2Y4bRFzWY0KltuQ1nUSgGhP+phKkhIG9u7zCNn43r
 Obac1Ob/9BITHdVj58SjtNGpmIgKN6KpqhXdZwbUHW5R4WzpVMbPvaYxwUQqRbcYtm/FiezVz
 mEdugbZc0p76Xl54p7LpdPnuusbK8CuMjNVpzx3uQncXFIFSy4UhuDWyyjEMJ1gpayk8/Gbbp
 UurStuLVOkyCHRDACkqI5oT9D0YEX5PV8bsUUX3Oo5CHp/Z3lxorkVUKbOAArexuNUrcL23c9
 3nl1bLF8ulz8XWnu7Tsi58NxLve0a2ufSzHvV3iJ9yd+w9YM0yhAY8rHovkdvivmi9d0UkGPx
 dbm7vA4w3PhaBZBCB/0ruXeObeISugKQp0hfc8O8lB0aQRzQsVbZm8mZ4M9WZA46xDdKZ4gsb
 UhZRlMGijAUCztC7gZiwJGO0o3qIGTDcq0G2p0b1I3KTg+p7Q9KuWv7oK9eA6SbtNgMTuIaqQ
 z2ApLL5eUYXIr48dPXdtDs1ikW7zLH9agqVjhPMYRfFu9tCWh+FmmwIo+TK6/C6sxSc/Vc5JI
 L2zDzgQ+3QO2cKSFUi2J2uMUsokmPsr7Kxa7fGNaFjBBZe64sxU7xfWhjMbuZfeyGdjQF29+N
 Te3j7zuqPkEEKCUaQLR6XpoPSyq3VBuCRtfYSIf3zlqx0H4DLY97MtmtIilZxWyPcJWCfqLhR
 6k6ZRg33XVObPcnV3sKPj07z5kac0pQyFpUCoFup2HZ41vUwlvd/IPcMJU32UF9y3jvVq16xI
 R2TEVm8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-11176614-1493726956=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Sun, 30 Apr 2017, Junio C Hamano wrote:

> * ab/grep-pcre-v2 (2017-04-25) 20 commits
>  - SQUASH???
>  - Makefile & configure: make PCRE v2 the default PCRE implementation
>  - grep: remove support for concurrent use of both PCRE v1 & v2
>  - grep: add support for PCRE v2
>  - grep: add support for the PCRE v1 JIT API
>  - perf: add a performance comparison test of grep -E and -P
>  - grep: change the internal PCRE code & header names to be PCRE1
>  - grep: change the internal PCRE macro names to be PCRE1
>  - test-lib: rename the LIBPCRE prerequisite to PCRE
>  - grep: make grep.patternType=3D[pcre|pcre1] a synonym for "perl"
>  - grep & rev-list doc: stop promising libpcre for --perl-regexp
>  - log: add -P as a synonym for --perl-regexp
>  - log: add exhaustive tests for pattern style options & config
>  - grep: add a test for backreferences in PCRE patterns
>  - Makefile & configure: reword outdated comment about PCRE
>  - grep: remove redundant `regflags &=3D ~REG_EXTENDED` assignments
>  - grep: remove redundant regflags assignment under PCRE
>  - grep: submodule-related case statements should die if new fields are a=
dded
>  - grep: add tests for grep pattern types being passed to submodules
>  - grep: amend submodule recursion test in preparation for rx engine test=
ing
>=20
>  PCRE2, which has an API different from and incompatible with PCRE,
>  can now be chosen to support "grep -P -e '<pattern>'" and friends.

FWIW for quite a couple of recent builds, `pu` fails on Windows with a
variation of this error:

=09    CC blob.o
=09In file included from revision.h:5:0,
=09=09=09 from bisect.c:4:
=09grep.h:16:19: fatal error: pcre2.h: No such file or directory
=09 #include <pcre2.h>
=09=09=09   ^
=09compilation terminated.

Maybe this can be fixed before hitting `next`?

Ciao,
Dscho
--8323329-11176614-1493726956=:3480--
