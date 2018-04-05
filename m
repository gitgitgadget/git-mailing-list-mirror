Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 514691F404
	for <e@80x24.org>; Thu,  5 Apr 2018 19:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeDETcQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 15:32:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:53379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbeDETcP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 15:32:15 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MKpvc-1f4AcH38jI-0004ED; Thu, 05
 Apr 2018 21:32:13 +0200
Date:   Thu, 5 Apr 2018 21:32:13 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Wink Saville <wink@saville.com>
cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] bdl-lib.sh: add bash debug logger
In-Reply-To: <CAKk8isqGe=H7aEtDZtKTpzQMxeshp0oC6tMwhA9rW=PhLt3buA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804052131070.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1522190580.git.wink@saville.com> <nycvar.QRO.7.76.6.1803301231430.5026@qfpub.tvgsbejvaqbjf.bet> <CAKk8isqA6Ru05kRJ+xiVHEkzPgH24cKUZbbgw2tEnw4rhafDQw@mail.gmail.com> <nycvar.QRO.7.76.6.1804051536080.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CAKk8isqGe=H7aEtDZtKTpzQMxeshp0oC6tMwhA9rW=PhLt3buA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uIeA/eGiHrgGiTv81Fo1siRRxMzVlL9jfctAjzNbZ6x5wyiRoOq
 dj1/KAovHKVV6Cd/wRu+7jqogZILx7CtNK7RQNNw3csDFKGc+TGcUmFjOToVzex9VGDQdij
 SZnkaW5Eflkdhw3lIT8jB22dL8i//lEpGoLNVRl7bdFxUEaiWH0gh2HWdmVK5oDdqg0ODLu
 M0cRduRqNwE623SIDQfsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qMGhxrxwU8g=:ALQ8hUTpLfM4GsRkwdxBD4
 Nqzn4ZiS8AtY+TAQ5QPFGKCrQhmwq+bE9dX+fCwrbOTlMZ2kJkHkfyjU8NyTYiLZSA41sqL74
 6tUx+PsBNeta60es6i52r63hDjGi4mDPzr+LY9LD9EHU1GY1lOypnNsebbpXaFaphj2nYCV4O
 Swvq8S0Qh942G+RjBtggSy+DF4phpfEY60vX8wDs9qK/Rz4ld1bT8xxItDjbkkfJpDjNajUVw
 HYjBVb+iLjGPAkTrIPj+eSpA0OMo3TK4VRQbmUVQ1uo5QYcmR11CXoiJqovPz08Q7gzY/JvKg
 0qlRDTeX3u1L0vgBCcsx/D27jcDekTWOBO5OWF7eAOJ3rtIF0tKp6RoToMV93hdqvPV+YVjoF
 jrL5gKJb4xhAMO780FnsT8szCL7YQY7vIYL2WjoS8WZVNJExHBASuxRUoYwionK6vX6PjFzt1
 VZFoMJUCqmOl+P0dEkAOyT9WmNnFguF5EW5SLucjSV+O9L5r/ZzRJmK3OD1Pju+PR/gOt72L/
 PI10kWbTYo1IqsB1xxkSOeORsAyK9mrb674hz4jaLCb/zSCg5sS6xYWBsVgvTfxWgsOnFF4KO
 6zvYu52Ab1NOZqtFxxNFKLvrWm/xcprvmJHVIOoKfSi3Mvy3B4Qp63Xo1GYgvbRUVtkbMMNsb
 AEPdk/0ycbcupdtQxenYlwiVqOzgT+vFcwKnU0sL3vSdkKVQlhNBuYCn8Cn+1fwVxpO2X+1Ju
 qLd8YKUGTfovzCIfeZjA42+K+epcuDzRj59POopq7q0iUGPpOcNmy/j7e1Cic8ITBuGGTQQoa
 LfE0HAl6GTwFrJouRdWLSMXJ0EB/aEt0bY+uUe/UN0zCvhRqO32jhPQbDtEQQUcekTO4Xm1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wink,

On Thu, 5 Apr 2018, Wink Saville wrote:

> On Thu, Apr 5, 2018 at 6:37 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > After thinking about this more, I am a lot less opposed to including this
> > in Git's source code. However, as it is not necessary for Git's
> > functionality, it should probably go into contrib/, and I would much
> > rather have a more descriptive name such as
> > contrib/bash-debugging-library/...
> 
> I'll move it, thanks for the feed back and considering it for inclusion.

Note: I have nothing to do with including it. That is the sole discretion
of Junio (who is offline for a week or two, if I understood correctly).

Ciao,
Johannes
