Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BACA20756
	for <e@80x24.org>; Mon,  9 Jan 2017 11:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935790AbdAILPJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 06:15:09 -0500
Received: from mout.gmx.net ([212.227.17.21]:60935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754702AbdAILOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 06:14:09 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVIva-1byOM53dvi-00YlIy; Mon, 09
 Jan 2017 12:14:00 +0100
Date:   Mon, 9 Jan 2017 12:13:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH] connect: handle putty/plink also in GIT_SSH_COMMAND
In-Reply-To: <xmqqh958y44c.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701091207480.3469@virtualbox>
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de>        <xmqqy3ym1dsc.fsf@gitster.mtv.corp.google.com>        <xmqq4m1911mf.fsf@gitster.mtv.corp.google.com>        <alpine.DEB.2.20.1701090825510.3469@virtualbox>
 <xmqqh958y44c.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WPF0o4yGC7D8zRZWqblbPcTOTTFd1gf+7A4i8XK4JtRnduUUYXN
 u9LR9yTOmSYHmkoHAv1PnNnjUo+nCIiPmpoIBQrpJog3F2Yxi7k+Fs/wPRZcW1/p/X9VxmE
 8LFZvuNOZSFRxxY9FgcAzGlVrDzNqesY8QooC3xIPL3KQguWfxqDxum9BjpNX5l0HLb829t
 bzEy3ywfBTqIum9Vg3+mg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+qMAn0mogCE=:4srtQlawfR21K7FEggQwM/
 fB7Tel19NqSwtht/+3OiWo8xId4gltEnNND+X2FuHcNP15vpkaWNundwdiCcXRwrIF9AlrkEF
 fycxE5GxGoGpjm9mLEl/WE41+RO8P19d7EZeA309nkyd2tjbMFX9VsYsMZEhLaVE2/n8AskMv
 k8TG9kDYi4pYi+YWiRvtJ7SjOQODlQxEaaVWUpmL5WwZlDN8cIL+h7sIMml/KGfrK+gN2zCo3
 2NVuXazQZ5A2f7x8w9ZPh2PcI6VTalFPE57i4m+fFN/ub3ryrukf4Flr4uznc3/Hq2bszU5nN
 uatRWU9jtCHEaOXiWdQgZG4+MD+IFllKcS+7iY1KmXvcIstTg/WVAwsa0sgchI7yloH9vPKlz
 xwqwHIQoGGqvA9kXfR0A1Imnytis3SIdnmsiSmbQhRu2m4pSWhYsIgqCABg1F4iTpBN+Ue+SE
 4mJvzLvRpfE9PleSdZ28Aq29X3E3qkFjTCAmhtIKzMqV/r3L90XkJ+WM30T14FzrYo1ZGR25D
 eXnVWCAtHZbKZ09UZxe+a9EEausx1CqtNasWx4E7AX+F+u3aC4LJY0CKpa8YtHNI6krtpUSYR
 CsD2tz3C4++yr0k3279NHslWCsD4D5acCOh6FisDOhnIJf2PDYvkUwN6m1UeGL4BbCjvs+gxc
 NloDO2HseDU0sMUtWWpWuJDn5SlkFR1rlzTWKx3bzflaWB+pwE3v7liM5JzvIgQr1ZsvV12Cg
 Kz7hpczwbZm6M69Z16II2uvDU+eglQFhD+sb0QkAU1DIZ8p568MQ6grB9QBalt32v3VW+mWJW
 fhFy/FA1+h1n+/KtKyN9/JGQME/G+0AK1lw/2Cpv5Bf2vov4wzlqJJm0YkkfRWQs6rboO6xNP
 KE4iOhBM1Ep/K/aDVdl7VpQK3UQI4S7jVXwfdKWSCtQ/niciYaNFNEf7QaIKR9sGeC0BL1s8x
 7GgXsvto7U2BjHywFe1MAxwq3pI6WonOBx/rCuYOlt8oyiNCjZU4jG+UDXQbNsyVR+UuxHVDJ
 spA8/+S9fnASDsJMwB1EpTyPp1uP0kYZLS/y5xl0efuVUu0aejEmnoDuNOdpHWAy/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 9 Jan 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > If you feel strongly about your contrived examples possibly being
> > affected by this patch, we could easily make this conditional on
> >
> > 1) no '&&' or '||' being found on the command-line, and
> > 2) argv[0] not containing an '='
> >
> > Another approach would be to verify that argv[i] starts with '-' for
> > non-zero i.
> >
> > But do we really need to do that?
> 
> No.

Exactly.

> > That means that the user has to specify something like
> >
> > 	HAHAHA_IT_IS_NOT=/plink.exe ssh
> >
> > as GIT_SSH_COMMAND.
> 
> My second message was to clarify that "VAR1=VAL2 command" is NOT a
> contrived example, and this response indicates that I somehow failed
> to convey that to you.

Indeed. The quite contrived example was about a script that chooses
between plink and tortoiseplink (and fails to call anything else). And it
failed to convince me.

But since you seem to convinced that a future bug report like this may
happen (I am not, and it contradicts my conviction that one should cross a
bridge only when reaching it, but whatever), how about this, on top:

-- snipsnap --
diff --git a/connect.c b/connect.c
index c81f77001b..b990dd6190 100644
--- a/connect.c
+++ b/connect.c
@@ -797,7 +797,8 @@ struct child_process *git_connect(int fd[2], const
char *url,
 				char *split_ssh = xstrdup(ssh);
 				const char **ssh_argv;
 
-				if (split_cmdline(split_ssh, &ssh_argv))
+				if (split_cmdline(split_ssh, &ssh_argv) &&
+				    !strchr(ssh_argv[0], '='))
 					ssh_argv0 = xstrdup(ssh_argv[0]);
 				free(split_ssh);
 				free((void *)ssh_argv);

