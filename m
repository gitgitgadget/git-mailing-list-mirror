Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5D921F406
	for <e@80x24.org>; Sat, 16 Dec 2017 16:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756796AbdLPQoB (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 11:44:01 -0500
Received: from mout.gmx.net ([212.227.17.20]:63597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756760AbdLPQn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 11:43:59 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIdYi-1eSRQA1pY8-002DLm; Sat, 16
 Dec 2017 17:43:54 +0100
Date:   Sat, 16 Dec 2017 17:43:51 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/8] travis-ci: use 'set -x' in select 'ci/*' scripts
 for extra tracing
In-Reply-To: <20171216125418.10743-2-szeder.dev@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1712161743330.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <20171211233446.10596-1-szeder.dev@gmail.com> <20171216125418.10743-1-szeder.dev@gmail.com> <20171216125418.10743-2-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1472983794-1513442634=:406"
X-Provags-ID: V03:K0:LAgoEIstIOequTC0sS72O3DGmUwm/EbvwH3rPj6PXoVaCidL9Z5
 NUHAe8rThzvYAI+UMK/Dfr86mMwWYhSzABbCOfDx0ooi321UUB6OilTVM1+kKNfPMwLwUfe
 0lKpTz1nB1BAI9XCJN/o0E4Y+FnYNP1qP2dp04Osy4OFoDvDFYCzBNdr3BNFVtpc28iViCX
 St+kgeLZKqWaiTlhmtVuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4A5673xPFCE=:p3ARttg5uyZCDf1AI64fHf
 gQBusQDviFCzF/RPF4FCJTZ+Q47nJge4Dk6UOVa5/jLpCRYLgFhFqWpE+k9NNoGK2RM/TaQdO
 73/SlG93J+rQkAtX+kh2XbYZ60/W9JU1nNztTcZPcTdTbZ4+cyCZl9mRdv3rMBrVNzl5rOlSg
 1HvGtwEXQuJyo0fVyQ5g/MObERRgN6IBma44tgd+fK8zJKMmPcQBiPDa1Dklg4HeQ99FnCZen
 9h5FPTJPavnCGJvt0iZTZMMhjNv9wo219V/WDD49hoBpOzn9WfE0HRdQDc8wy2lI3CmTYlqY9
 1Fn4D11tV3SIzyJ4sL6iXNJymrqCBjzGV8un2Iu1PDBU2g2OGcSuChUZmebxvGFzZ50zTu9lJ
 z836rTjhNABMmUdJF9e+y0QdDyeYW2rA5zA10g1F0ocup/9L6YsqUnHC5ODDkPtOJQ3KJvPHT
 3N1ajY4sFiT/0ywua0xz7YTeCc5VxFMXgENuTS9nyL85LVDcLg7nFoH3uqy16Ra2+l1IsHPTQ
 i8NumaKMOZWM+e6jheOqK8CvfaqnLzHh8z7mfXYMpUolLiBkn0gpHBrmg75a79liov6Pi4JgF
 5gQwP+8k1QEkQLbz1nnNCZLZQFW5ExuyEFRkMC8od9o1ByyYTZ1PjqCS2d+q82/3JSVK2VLjZ
 /vfDB+f/OWcJUCugV97cdE/ajtHzMH6i20GiUNTkKFehMC/70wttGPj5+EIZhxPKNkrpe6AeT
 wfrFtUv2FLaIfRaVVMRD582pQUqlGOFVhZIxWoUn/z1y3M6hwbsFk23a8pLgk+GnVYQCYtnT3
 S2Gbz3NkWSYlOHirKz8bFPBOQiUTyXRvrYpc29jKbr092pPD+w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1472983794-1513442634=:406
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Sat, 16 Dec 2017, SZEDER G=C3=A1bor wrote:

> While the build logic was embedded in our '.travis.yml', Travis CI
> used to produce a nice trace log including all commands executed in
> those embedded scriptlets.  Since 657343a60 (travis-ci: move Travis CI
> code into dedicated scripts, 2017-09-10), however, we only see the
> name of the dedicated scripts, but not what those scripts are actually
> doing, resulting in a less useful trace log about e.g. installing
> dependencies.  A patch later in this series will move setting
> environment variables from '.travis.yml' to 'ci/lib-travisci.sh', so
> not even those will be included in the trace log.  Unrelated to
> 657343a60, 'ci/test-documentation.sh' runs a bunch of 'test -s <file>'
> checks which would fail quietly if something were wrong, leaving no
> clue about which one of those checks triggered the failure.
>=20
> Use 'set -x' in 'ci/lib-travisci.sh' to get more detailed trace log
> about the commands executed in the 'ci/*' scripts.  Use it in
> 'ci/run-linux32-build.sh' as well, which is run in a Docker container
> and therefore doesn't source 'ci/lib-travisci.sh'.  The secret token
> used for the Windows builds is specified as an encrypted environment
> variable in git/git repository settings on Travis CI and it's redacted
> in the trace logs even with 'set -x'.  However, disable this tracing
> in 'ci/print-test-failures.sh', as it produces far too much noise in
> the output of that script.

ACK,
Dscho
--8323329-1472983794-1513442634=:406--
