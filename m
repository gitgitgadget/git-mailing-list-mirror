Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B1541F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 17:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbdAYRB5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 12:01:57 -0500
Received: from mout.gmx.net ([212.227.15.19]:65012 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752001AbdAYRBb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 12:01:31 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2L2a-1cFjRN25FU-00s5FY; Wed, 25
 Jan 2017 18:01:13 +0100
Date:   Wed, 25 Jan 2017 18:01:11 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2017, #04; Mon, 23)
In-Reply-To: <20170124132749.l3ezupyitvxe4t2l@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1701251800120.3469@virtualbox>
References: <xmqqo9yxpaxk.fsf@gitster.mtv.corp.google.com> <0D956B23-E655-4C28-A205-14CCC0A7DEA2@gmail.com> <20170124132749.l3ezupyitvxe4t2l@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/SQJf0oCgclPhd/DVbK54bUJCP5mmeQjt826awAlrZJt694hgJI
 NNORTfibw1/vdlMrwJC1eBDTZSLk+XkNGJohzW3IoTBnB9HV5liD5Nt6dqS51daWBUzDt0g
 LB8XNtdD6Ei9hwfk/WLUjliYF0dj4+vHqREzw7jD9IH3VPD9g2+grlvulvKgHUXhjF2aink
 jU+vLFW/9vNkj5yErzUKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nB6ae5jXnRM=:tr43HyYX0swUhDEzGgNohH
 XrCWo2mRbch28Qw+xTGu+0tplQmcGVOmNw6dUScVCG3j7X0+YCJZAzOGIdSyo+f24MQVUNBq9
 r93gsXX0B1tAmYV3MKVTgllPsXR+8FBLU4hvTeUUMGadlHBO6naaKaLNuVw0lG/2pEHUCR/qD
 CQwgi7hF4d40C7LcdhzdSz2I8jKFsN/z4qFrl4qsQ6crDRpGd+EjXvGqZY6TpmQ70/FeYsWWk
 GDRuTB7VBJVUAwg8Um8UFdEeqLosO6B8SN3aiY+x0EFNvy0t9jAurvC/tq+fx8Sb7sgwehZzQ
 ulAIe/o3OpShrY6CzCQp9VfJnmuX1ZjADcsCbeAHhOk24a9uKB2zdnGG9LPFxfVqmfXnI/Ysd
 YdL41GiWPbRYY/ZbQxuVlVHBkY57vViQdxoMoC/oJK/U4bFvpNjmfzdL+DD3ny/Rzod1LJ9Sz
 pLkLopZuL5+D3lzxLn/v6uv4tEI7gCCand+U6H9QhbdbOlhkl+qYE/aBkmmCbb8DB52X9LMMW
 fTYeRPsEpNLDoXjN6kT7I+thTw7o9vrbMiaf/O2EyJYOtSSlMPQTH57QrQf2+tgO/KoJTkcUl
 OJRhk0AqwAG9SyttVop+V99ndlaVBFDPOAPDfCXQQOihuwc82FdZS6p17EOPbZ5oVWWT1FpAO
 AwSvkVy2zHMWl2EmF1SWp9NQ8y26KWd4cYyeeFDMgIVntxO/iBC5hH9V+VEzEKFdy9jCkzwRB
 ittQbzEyeEf+WL07ARxqfOLFc12JPCDHxcLveXwKk/zmFvwXOU/UXAL0rXgWj+Ys0/dxu1G7v
 ZxuwVZe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 24 Jan 2017, Jeff King wrote:

> On Tue, Jan 24, 2017 at 11:04:21AM +0100, Lars Schneider wrote:
> 
> > "fsck: prepare dummy objects for --connectivity-check" seems to
> > make t1450-fsck.sh fail on macOS with TravisCI:
> >
> > Initialized empty Git repository in /Users/travis/build/git/git/t/trash directory.t1450-fsck/connectivity-only/.git/
> > [master (root-commit) 86520b7] empty
> >  Author: A U Thor <author@example.com>
> >  2 files changed, 1 insertion(+)
> >  create mode 100644 empty
> >  create mode 100644 empty.t
> > override r--r--r--  travis/staff for .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391? (y/n [n]) not overwritten
> > dangling blob c21c9352f7526e9576892a6631e0e8cf1fccd34d
> 
> Looks like "mv" prompts and then fails to move the file (so we get the
> dangling blob for the source blob, and fsck doesn't report failure
> because we didn't actually corrupt the destination blob).

IIRC I had similar problems years ago, on a machine where the
administrator defined mandatory aliases, including mv="mv -i".

Ciao,
Johannes
