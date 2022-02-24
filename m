Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C9EC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 15:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiBXPkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiBXPkU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 10:40:20 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641F81BE4CF
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645717183;
        bh=LPcPYagADB7/MmYKET507O0MjUf5RVLOoIcSPh8uVcg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ImOfCpS14oLZRUIiek5re7pQfYebav2dMYPNXRy3LXuyaPLuAgHuXd/G+UureNo/i
         iDJrmpqliTOTLMZ5P2EJUToGqaiBxeUP/lBtlwRqIVLhXHnC/vTJ8VyIFnaX5o4xli
         rVWQiM7F4UaAi4Joo2yRSNubzU8928mXzi/KkLvM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnakX-1o3htq307B-00jZ4U; Thu, 24
 Feb 2022 16:39:43 +0100
Date:   Thu, 24 Feb 2022 16:39:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 19/30] help: include fsmonitor--daemon feature flag
 in version info
In-Reply-To: <3517c4a3c1322f07252f63204d60ace9cbb6b1b0.1644612979.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202241638460.11118@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <3517c4a3c1322f07252f63204d60ace9cbb6b1b0.1644612979.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WVaMEwmm++aG17K1BTNvvbaUZpMqfNHnDOhvAfaZ2WASiua7Oc7
 Qwc8NZucSFn1tXl1rPRXB5pQPGnXJarIMpXGoQc8laK1Pc3sflUdEMJesYwo2Rt9WMWFfnP
 mH4a/nDzQBo9qn8FjzAVagmsljuXu+j0MDGmp+S2x7KVwbJwgyIctZcInRmTqkUplMpAq2/
 yglR6uMUvA2hSqk36AiFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R6ez64RO1ME=:qO6wqZuut+DbSxbM2IlKcE
 rtZTdnjznTUXEKcfYHVRPc/lsYLsa55P7jR02FKd/VxuebsGQTgFtEFRYFBR3crjWG7X/YQHd
 0pUjYdxXbEXrjm6mYfCNif1kKbJgXGlP5bz0kYAzeUgVmwHM0eaBBp9+BIYD1oFmuIwnudC1N
 Y3ylm/VWhV7KhMEqLMS6QpbJ1PzMy82EEU5ZCpiER4BP/B8cTbUBVYPuuPfjcOEUA2kzDIhQ5
 NJ3p2v74u0WgTFGnGmpQ8N8ZKxgTvPLPDWYiChuHzMxsPC5adxlisxTAiMw8VeHuEzd0/nNcj
 6k0wK7MDYsa4Se+OEBSvH/tgGx8HF7lbTGdmJF7VgZgHD54FmwZ2IuEun8N91Hjr1+9kLq/H1
 GfVdJ/Zm5F7+Lo66UMUIw9yyL+HNO9Lje9IyCdAErnnLWypePWCHsPr++WDD2ul4Co/AhdKsd
 n92f4dyaZCgt8yNEg2rnlrglVqDbC0r6D+UqSqFNgZi2PxDbXY3PXS6QDE9daH5jnLXArnXD1
 Gxg71F/1t24ut1kpZgksIftWIEhsH7jDtMkxmteSMU019F/sErQUc+KnXpYPnYbzy03z1f9H2
 uiioQ6iOkQtTAvfKJjfdwtRTXgprJKLXVYb4XWm/JTf0dAzk/4B5CRmvYIHlnHV0qZNtRwFC1
 Ansi0J60Ac+lpyyI3Z4fov6U6CJypPegBGkmI1L8APLC4GK9i8IJ0y+3lCsKtrC6S7d/mi247
 SMSBiZrTkcr96OTqx5KRmHmnhIEczBCqLQSODRFdm4uHRQzFlrdHCQPgniIAPlABUluxl8xnd
 rbbi14BqxYNkurfqSnw5qhbzX0lckCKX8Q4C2nsVgja5INbjuUVAo9E+aZ8VbJ036DgQwKQYt
 UFX/WAi5l/jgPlJE1DBIwzMmkPxTAvUvRyO4OxRb0DdcQOi55KJqIYtGbJIlnXPc4IqWdK86J
 iCHgTLRBKMARc438sFBMAinQUS7bw3YK5dBg0W9dO5oKXNadWZVwLGBmAaeKHptIY1HpbuNvD
 EHFeRb14hZlzasekX5MHsfZGdIin9BQYe52Jnnl+sGUXPnFgDDpvYNPJddBplmbcmqBddWa6N
 pYQ8QTr04UIPxw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Add the "feature: fsmonitor--daemon" message to the output of
> `git version --build-options`.
>
> The builtin FSMonitor is only available on certain platforms and
> even then only when certain Makefile flags are enabled, so print
> a message in the verbose version output when it is available.
>
> This can be used by test scripts for prereq testing.  Granted, tests
> could just try `git fsmonitor--daemon status` and look for a 128 exit
> code or grep for a "not supported" message on stderr, but this is
> rather obscure.
>
> The main advantage is that the feature message will automatically
> appear in bug reports and other support requests.

It was also used by Scalar before we started the journey to integrate it
into core Git ;-)

Maybe include that, for history buffs like me?

Ciao,
Dscho
