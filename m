Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C66A3209F1
	for <e@80x24.org>; Thu,  6 Apr 2017 08:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755909AbdDFI5i (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 04:57:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:51071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755793AbdDFI5d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 04:57:33 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lg6op-1cKZff2iXT-00pbU8; Thu, 06
 Apr 2017 10:57:28 +0200
Date:   Thu, 6 Apr 2017 10:57:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix nonnull errors reported by UBSAN with GCC 7.
In-Reply-To: <295981e7-d2e9-d3db-e32d-8dd80ca47136@suse.cz>
Message-ID: <alpine.DEB.2.20.1704061056020.4268@virtualbox>
References: <295981e7-d2e9-d3db-e32d-8dd80ca47136@suse.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2108696474-1491469048=:4268"
X-Provags-ID: V03:K0:4/YR5eazlgLQN/lQgWQNABQ3YqXQMgwqPsItSEVW4LuocU/+dnw
 PTpVRn830P2+Zn5IkPcrqTu1ykNpqucToQu6PokiRhjzjFPjn400Z5diBsYgPyZ2N6iHcEL
 gAW9JpBCO2VM/82KVSC1B7pHj4ElgDro8c4/6xT+h049tVx0IB2DkNnOcKVytV2TE4prMgu
 WzV6brMm9gY2ilAiLMBFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MZh+6hVNCv0=:wfk4SyOnasKLrgPHlCBxBd
 eRim4h3uARqsB74oCptvWmEvvLl1lwshLF+9gVrS2J9+kKZcVtHGBECU0xjh5MjvjqMB0h1vK
 1coB3NK/SxSLpUpzRh0Wat0lQbAK5y/wK7cqEBnJ9JmZroyjzaMkB2ZLa96IVYleQ1NXJFA1X
 3MhRuRYC2wKi38l6dyoK8TOSL4hzpqhcZNS/iw41mXvApWzo02vyNvCh8sFpsKBDtqq0h5F/Y
 E+zUO7e1VE2QaUDTT38aqPnVYq8QTVrb4PTrXyrm4zDDE4s1cLFbomqIY3ey8+2fn546db98/
 Qyj2xfUqe82hpP/KX+kkRzd4TC8tl10nCxaPcRHFM6vJHhHPd6OAhb0LCQXfLFBv60agXJnQM
 1Ep4mQMkkrVmqhMaHo+ifC/5ByFxmbGOsu0z2nJhsae3cWm9EabUUxmNBP1sKv5yJxwHdlLPh
 TWysxOTmUVCUq52CrBvfCFovCuLlLUOWMvpT18h/dP8V4h+uey8Hh+77zW4eHzKrzeUOybxhO
 3uGyJAQNCnjFSQ+cs8SGrH7TX2TCje5IrlrDGuEfEJxCVkdSwnA962ylagEnzf+SLJH0UYDtm
 tZeVGxFOSkonVpZl+r+1IbYy77gssMHnpdA7Va5NHk81wotzTTdzV1phHxD9EpFU0aVWJWkHo
 hMShRyBEmrxKFBwHf2WFMDui9AP6s3wztn+BPK25zjo8YIzqldzTVs/VqVF/LQRFFF1W3xROy
 +s63V22/0lR6hr8Xq/adx4kpqqG72NSFekOOR0oFSsAYNNBRNpCx5sOlQjdCGQffaUlpK6qDn
 Aawpo70
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2108696474-1491469048=:4268
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Martin,

On Thu, 6 Apr 2017, Martin Li=C5=A1ka wrote:

> Following patch fixes issues that can be seen with -fsanitize=3Dundefined
> on GCC 7.

The commit message says:

=09Memory functions like memmove and memcpy should not be called
=09with an argument equal to NULL.

But the patch is not about the pointer arguments, it is about the size
argument. So I would suggest to say

=09Memory functions like memmove and memcpy should only be called
=09with positive sizes.

Ciao,
Johannes
--8323329-2108696474-1491469048=:4268--
