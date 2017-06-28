Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E61E1FCCA
	for <e@80x24.org>; Wed, 28 Jun 2017 14:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbdF1OkZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 10:40:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:49239 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbdF1OkX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 10:40:23 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LvVYZ-1dph3O07Nr-010aPz; Wed, 28
 Jun 2017 16:40:21 +0200
Date:   Wed, 28 Jun 2017 16:40:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Gyandeep Singh <gyandeeps@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Bug: Cannot kill Nodejs process using ctrl + c
In-Reply-To: <CAHaNChecHzZqzafe4P85Kz4BtJuisO+krCvm=yPW9wGMXWJK_A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1706281527120.84669@virtualbox>
References: <CAHaNChewK_4a7sPgZqWTNSmchiSbKOJUrpCrGLmcnR+cw6J5qw@mail.gmail.com> <CAHaNChecHzZqzafe4P85Kz4BtJuisO+krCvm=yPW9wGMXWJK_A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hnGxGfxK52jyv1HxRI+RPqG7+/NsbPNFKandy8zS8lxABLUBWJ6
 FoExlUAuJkLZu/THDiWZvBCnybWxxMbRSejv/BZKbfUWhM6BpqnvcsxqsDfxPhEIpYw+Rqk
 53t9grWHsQMIeQuuyBvjZLICgFC+DVIdNIq4RZWWg38aXqoYO7bWWrhNEXXqV8bP6Xx7nFc
 m3J0y5SmC5FsWkPssL4+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DOwYhOZbcjU=:CTUA3m6tVhZ/i1b0UYvkUI
 p15UDphwjvwMFS7rs8DQXsuELvNoFMx959Qrsn0N/C2HwWtFtpmdwiZD8ll/xyrogVctnuoS9
 n4+t3vFLyZ0er083Fm0Qi4EyIhHVhTH34L3DuSUGG88mVoOiE64u6S4kywdrTCiyFyLedVdWD
 4bbYh6wWZC79ruudC96Za2P7yza35DkO1vfuMR8jP0d/+PzddCUYaXq+Jd5+fkupsZnC9zv0T
 5CHmsR1NfV75uzBIYO9HDGDk+NzWejaq4lE2fyb6Z86ZCxX6rjtGNlX7SfTWiZNI9Gk7H3K7C
 U6DohzKoBfD16gdVWEGRCz2PQC7VQSunHZlaQI6Bix7G+ZWytrvAeKRr2U2x7yIaCCQTjGjG+
 8mvPe96PzvzTRxh3bL+JBAn+MCmDUqyl2ME1t1IzTzMOc2yVGQLJKvZFpgBIq+0N7RUw9Lk56
 IVaHM6Z8PfgcFEgHjb7KLkHIBUXfaIkC/cvmMRD2u8NgF/VUiPow7+TUxbiFRDuBUktAdZOdN
 V9xwAzfZ7PZnMMisQ0NMulFX0gF1acnBQjrjBZ5E7GlgUdS+yqhGfxyyok5WJAxXTZqjxdyK/
 uHXxnAg+LksPWhiyQ88AZqShz/F2ysSs056O0kqKbNiRlj+gAkTbdvvCH72pwmXfpst2R4wSO
 Yv1Xenk2eMMF9oQjUr/M0pn3JGFDNnaCmGAfQDzELh2/HG0porWHMhRschphQII2nuMv2v5Tp
 JA2pNJaVUzh8cVgckn2zhtPGwCAJ43tHzoBkfs64dmRl2VjvkH9LQwpVEjk5Edsi/Qy2MoOMN
 wXohtbR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 26 Jun 2017, Gyandeep Singh wrote:

> 3. hit "CTRL + c" (2 times) to kill the process.
> 4. If you look at taskmanager, then you will see a node.js process
> still running. or if you try to restart the server it will say port
> 300 already in use.

The way Ctrl+C is handled in Git for Windows changed recently, indeed.

Remember: sending signals to processes to ask them to terminate is *POSIX*
semantics. Not Windows semantics.

On Windows you can terminate a process via the Win32 API. And I really
mean "terminate". There is no chance for that process to, say, remove a
now-stale .git/index.lock.

We have to jump through hoops to accomodate Git's lack of non-POSIX
understandings. In this particular case, we inject a remote thread into
the process, running ExitProcess() so that the atexit() handlers have a
chance to perform the cleanup that Git so cleverly expects to be able to
do when being terminated.

It is probably that thread that is still trying to run when you hit Ctrl+C
the second time, and that second time it terminates *just* the shadow
process: node.exe is a Console program, and since you run it in Git Bash
(which does not have a Win32 Console, but emulates a Unix terminal
instead) the node shell alias runs node.exe through a helper called
winpty.exe that I suspect gets terminated without taking down its child
processes.

Ciao,
Johannes
