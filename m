Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007261FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 15:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932399AbdJ0PLW (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 11:11:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:58963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751511AbdJ0PLS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 11:11:18 -0400
Received: from virtualbox ([2.247.243.12]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpsmR-1dUvmW1tW3-00fkWU; Fri, 27
 Oct 2017 17:11:15 +0200
Date:   Fri, 27 Oct 2017 17:11:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Alex Vandiver <alexmv@dropbox.com>
cc:     git@vger.kernel.org, Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 1/4] fsmonitor: Watch, and ask about, the top of the
 repo, not the CWD
In-Reply-To: <alpine.DEB.2.10.1710251700300.9817@alexmv-linux>
Message-ID: <alpine.DEB.2.21.1.1710271709570.6482@virtualbox>
References: <20171020011136.14170-1-alexmv@dropbox.com> <4f8e3dab26cf50cc6aa055605784680f5c33fcfa.1508461850.git.alexmv@dropbox.com> <alpine.DEB.2.21.1.1710201457180.40514@virtualbox> <alpine.DEB.2.10.1710251700300.9817@alexmv-linux>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:O7CzZCLPmrGwLRKuKnkqPZh4RbRsa2y1om2eQ+aa5s4UG3lLBTI
 8Ig7w/pUJeNst1gfN5A8NP6dMVTi2898FjpP1jp7aAav6HJJTWMNwAKNsMktYSuQhNKlAY+
 PrLx67BLL4og1hO0uIORw/xLMzXiMJm2hzLrjMD9wzwXbXykUZGmHA9Z1ISJ0GZ8ciYdU3z
 o2Q0+Gkb+gCd7zFOHgKjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+EDw1W7hHvY=:M3+3+uNF1hn6hAKX5SjkpL
 2VpTezPRsF30+LYbwX1LGZdpN+8IekQ1ztdrY6MivNcqYFGVCeM1I6SWFeO7U/ScDUaVklygk
 huxagbvltIvtDOU53y4r/g9a4IOIayt1xytmE+A+lFXvenYjCYMoOP/pahA/xbnccgaw3LBau
 UVkdV0/9+OtZVNpMos2w3JRT5GZhI6RYPWiKayxyo+TvgQOaQar5jchsuE+kkRmBHGtclIqcx
 O4zsYNtIzOc/4dd0i30ptnINruXXIBLoowSoOEv6PbbBc6ZQbJja1lwTCgdP2vfZJ/jD5FZxL
 i7Y1JllZ0fsTbMf79Js1tBDYl/8y3pPDEKR66YRCzG4wGutgQztH8dXlAqysCEzIUYRViJF0t
 n6CY+ZBTZXfNurCPL0XVlc8r3ACkQyk5coPYxs1XIzQQbR3Ux7MrVI1KuRWZSKat0T6nYZ6Ov
 1iDFdL4ybKrtmeGI84Uq79ZVuXmLEmiGuOwxSMJxRR2JpoNVPr+Irp34BZj4Sr3f4X05S/1Oa
 gFcs7xmjTtJpJvVEoAJ3K4q7tOVRRbf38rtUu1H8QfFPEQ6eJtJIBlUsvG91XnkLELaJdqSOo
 Vb9G3SOHLociQ1A93bqqDKtKqiyIIZ/70VNspjyAKwQ72tr2SCdnxRGrPPJObojim+/A6If++
 qJ5gfZ35YcujLY9iPDu1Nc8XewcMKL60ngfoLufnRfKiAO+4hgYnqzP5DEeizbQqnGG/Fzn9h
 1sOzaGBd0Fyvx7hUVrPTzZVl+IFYTevBlN33Q6gUe0qnMV+4dNCv3uI8vRISkbUTM98qlvwhA
 zuHO6+9lFUSCzSz3M1oPz0sm5t1Km1eYwkgjUK3+TC0jUT2qRo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Wed, 25 Oct 2017, Alex Vandiver wrote:

> On Fri, 20 Oct 2017, Johannes Schindelin wrote:
> > This is super expensive, as it means a full-blown new process instead of
> > just a simple environment variable expansion.
> > 
> > The idea behind using `PWD` instead was that Git will already have done
> > all of the work of figuring out the top-level directory and switched to
> > there before calling the fsmonitor hook.
> 
> I'm not seeing that PWD has been at all altered.

No, PWD is not altered.

But a simple environment variable expansion (fast) was replaced by
spawning to `git rev-parse --show-top-level` (slow, ~60ms on Windows).

*That* is expensive.

Ciao,
Johannes
