Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41E4D20248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfCHJbF (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:31:05 -0500
Received: from mout.gmx.net ([212.227.15.18]:49057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfCHJbE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:31:04 -0500
Received: from mail.schuerz.at ([78.47.150.33]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRGPP-1hVeOm18QB-00UXsy for
 <git@vger.kernel.org>; Fri, 08 Mar 2019 10:31:03 +0100
Received: from tag-331.vpn ([10.0.100.9])
        by mail.schuerz.at with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <wertstoffe@nurfuerspam.de>)
        id 1h2BqI-0003Mu-Ho
        for git@vger.kernel.org; Fri, 08 Mar 2019 10:31:02 +0100
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakobus_Sch=c3=bcrz?= <wertstoffe@nurfuerspam.de>
Subject: ls-remote set timeout
Date:   Fri, 8 Mar 2019 10:31:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-AT
Message-ID: <0MUoma-1haJEB1Ckm-00Y6Wl@mail.gmx.com>
X-Provags-ID: V03:K1:9c0rG6y81jNzmy/7jK8B9v1HkTHbutUBh4Ygj+IY3wFrb0mfcPe
 zQ3rPWq/4IEzQB2W9TxYEfhg+vhoj+CkpTdmMIZ4VikbQ/hhHLRzYxFTHNvMwQKvUIUOSvR
 uQ6/LwNTYXO9SbMvx+/elr00yIorfz8A7sx9Sqs3NTq62UxuORtFArwsh/Q2xPQsB3TeDdq
 00nMKQVAMHQzB29imDIlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0FYbScgf8fI=:CeGFlu4izaBOsFLDHKFkTw
 aqk25ZGGpK/+LbHSnW9ZgyIGxVCzQDNGubcc+zMAPG+66R1AMIotBBHwz/TpgxWF3C27hw63K
 PhFKUCrnQkIp3z+EeJp7SyH2zyEplTScqOuhzA7N3UAmwkXfel8ptTte0Jw11786oh99KxIog
 9GteyTCrK7YGUfpcIlAhLsFkw0vtxd++sQQzwFwZ8kAigk/U3VUbxe89txVQ6CEMCh+c8QpJJ
 3t9B7NK6WCYn/vKkOvhTwYU+aGWmtgLpaYZK8j0YJjn9416vTamXFQUNoWRg36TqQK3muMPnp
 +gM53yN7w0q6JRwTrZWjmjAM/FN9k3Qoq8pQowQCNUKnUz/brvijJ41Bh1XYKHFaU7Oku+rO1
 ewSFcrgMjaLV2yncYWFArTlrUDqiHOtTMIEOkkwJuu3LUK0hbqS63RqpPrqpSpKduEdv3onUa
 WElua6PmUpbKzIFs7rBV7xVdz/FdV6tEx99oiRBVHdWsKFArl6lnW5yxMfCxRCzkP8ojfqgp+
 5NdLBj4aRFQivXwfcZl3CFugUuOiqIBw4wxYXPTLBdmLlNhOHd//SoBYnE0tZrOgVRCuXeFHf
 fYiwwz4ppTwZGuDL84TZpHeYCxO5Of3ScMiAbXgg8vguBVbm6bnjCU2W5D/NRNISzyJTt4F/n
 4zuoqWakjplzdO1adld6XpEAQwFyRA3sdhG079yj/DqbSEmDyYsC3SZobwYP4NtH6tVTNpXN/
 clHsCVc62wSQvNEfnxDSTv3mHt6e3xbFHz8yprKes09UydMRMVB1hTNW1bLgYBU3A7fnrv6mX
 rg4m9kzvcQbnlatX6gDjaalsb3pZGeJtwK435raNlKhYDV/V+l6r9TH1+7AXRqmBbGUVP+hYZ
 MfOU0HZVKHTRz0+ttIU4W/pueuIkOLzs6WyrN5CCWs23711D9bn2eyx8U9nVE04zfZr2MDYvF
 N6vTFbeqSOg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there!

Im new to this list - so hello, hope I'm welcome.


My problem is: I have a configuration for my bash saved on a private
git-repo. Every time, i start bash, my .bashrc checks this repo out to
get all changes (alias, some functions, $PS1 and so on). So i can have
my working environment on all my servers with personal login.


Now I'm working on a new customer, where github.com is not reachable
(firewall/proxy). Parts of my configuration (some plugins/scripts for
vim) cannot be updated there, because they are hosted on github.com. :-/

Now i tried to fiddle in a check, if a repo is reachable in my .bashrc.
And i found out, that git ls-remote is a good choice, because it handles
redirections from http to https correctly behind this proxy. (direct
https links to git-repos do even not work in this surrounding... don't
ask why, please).

I can check, if my private repo (git bare repo with gitweb) is reachable
(http pull, ssh is also closed!!!) with git ls-remote. But this check
hangs on github.com in case of a redirection from the proxy to a "this
is forbidden"-site... . And it hangs forever (1 Minute, 2 Minutes or
even really forever!)

Is it possible, to include a "--connection-timeout" and/or the
"--max-time" option for curl, that i can give to my "git ls-remote"
command? So i can call

git --connection-timeout 3 -m 3 ls-remote <REPOURL>

and the command stops after 3 seconds with an errorcode, which I can
evaluate?

I tried netcat and curl directly. In this environment only git ls-remote
will work correctly on reachable repos, but it hangs on blocked... :-/


Thank you for your interests


Jakob


