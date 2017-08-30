Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789A720285
	for <e@80x24.org>; Wed, 30 Aug 2017 20:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbdH3UXb (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 16:23:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:52381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751562AbdH3UX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 16:23:28 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mhdex-1e8NQX3z63-00MqFD; Wed, 30
 Aug 2017 22:23:23 +0200
Date:   Wed, 30 Aug 2017 22:23:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael J Gruber <git@grubix.eu>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] name-rev: change ULONG_MAX to TIME_MAX
In-Reply-To: <ef9aebb63227c36b8b72a65240a416a0271cc618.1504086318.git.git@grubix.eu>
Message-ID: <alpine.DEB.2.21.1.1708302223020.7424@virtualbox>
References: <ef9aebb63227c36b8b72a65240a416a0271cc618.1504086318.git.git@grubix.eu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iBour1WkmnOsx5kMbHTbLouRbBPSHY1fvpV+B1lTIq+cDoyG0jt
 +/TXpdsV/FeLaD/4YOBurBnNY/3uxWZTNmKu58BXWV9KTdBOdQKZMVs98UNTBTVuA2ME5f2
 qxRCzMpy/yYXeE9lSEnE76w46q7ufHXCcgDkfycpxs0jAHPZI/TcvBRktJ0YoPiDBdLbAzp
 v138liVy3iIfn5I+aDjyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:00VZz2etzxc=:XAsNBVQli3Fj3D5wajn3sk
 DT5++wMbXJ/CaDzfouKWXJir8gb7RfYrMBHStLf5JH40N/R62hBPEvEOg7jweAVD42/nfcbHh
 k+eItHTY8XdSVRs/NAYTpswUs84I6oaGQC2Iu+SFMZAodVd17JPKKTmXIs1bNMFTyxPm1RR5U
 ODhiqfBmnxIVwELvuVzTgI+8wWcsOYuFsL8klFRcJQ08rneP2t0X5M+dGHA0V0ToJL+bWyGjs
 Qg8J4xAlWGqqUegwO2utsh7ZLdJu+TO3BebLSuIFCwTaRilJHvSZb5o5osW+d1IMNqpWY4Z31
 rDeA5kXhTjiv+J+Pf5b37hU3u7MrsW9cuW5tMt4tT3dySMfNu1beVPfX3Axc+0Xk5rY2EZQRE
 MUQUoCL/UjzDj4Tj4v3CpDHPot4GuOjdefWr/8JzblTN/0Wh5GyA7nq7w1fT9eyP89V8Ar8ps
 SShifxbjNTbfzWdiHqOJ9VlRyfiexiUEl/57GE4kVT7Ls9lpSAVVEUNpkxXvaPwwms+tmGEwu
 kb28yevcqrIPnq1QM9Fp3xRcIOqMZ1G30btvua8Al+0tsVWfwOEmnsFhSA7nmTv5AzDnd29ya
 Itqf0mBwsm/YIg2FjqfAo24F69mFKD85cQYKhtPclV1bXbnHu9dNbFA8mPk6CsOD3K50ZO8M8
 Uvn89v9UQmkrDOoRuBnLQ3zgJbq6qF+JUj25qawMWa69SyJsg0YT4HYFG5C/Hc6lvVfXn/3r1
 AbC3Q/bOvgCP0S5k956IJ3t7yzEtIJr/rxNBh262XZeOeP9Skx8GWfiy2nm4F99Cp1KrE3KkU
 IKYn0S3EkcaVUdKuzhd5wE1wpf5KE1r9yk5F48yUyd1zjaihwU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Wed, 30 Aug 2017, Michael J Gruber wrote:

> Earlier, dddbad728c ("timestamp_t: a new data type for timestamps",
> 2017-04-26) changed several types to timestamp_t.
> 
> 5589e87fd8 ("name-rev: change a "long" variable to timestamp_t",
> 2017-05-20) cleaned up a missed variable, but both missed a _MAX
> constant.
> 
> Change the remaining constant to the one appropriate for the current
> type
> 
> Signed-off-by: Michael J Gruber <git@grubix.eu>

Good catch!

ACK,
Dscho
