Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A4D20FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 07:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbcGAHi7 (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 03:38:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:61432 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199AbcGAHi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 03:38:58 -0400
Received: from virtualbox ([37.24.143.238]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MLR30-1bIL4C2xoA-000ZpS; Fri, 01 Jul 2016 09:38:34
 +0200
Date:	Fri, 1 Jul 2016 09:38:33 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	dmh@ucar.edu, git@vger.kernel.org
Subject: Re: git-credentials-store.exe crash
In-Reply-To: <20160701040715.GB4832@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607010938140.12947@virtualbox>
References: <7210bce6-093b-9fdf-9a9b-94059ad0d4e3@ucar.edu> <20160701040715.GB4832@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NK7wzpHp3R8pkwUsJrllLGdevIUP9ifeNxp/AfZ2zvr50z5LwEd
 25E9eZdki9CdseMt51nvy0jW8SWOTo0C/XQ4sGfhPZukkTkt35cAY/2LKFB2BHroZz1YyaA
 bhtOxrKjtPdO5R6IagtTmywGddjykmlZwJHfdP0gaGI45NxyMWBF/W5IDTXWe+4VQWR7Lhv
 gmqKeVpN3BypXJEL1LAcQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:qDRXfH0A2Zs=:w6JGRWa0hcnR+XXwBnLWLh
 JoJIqplfv/BLUVRWaBkOVZDu6XTe/2Cj+3+CKIJKgkXCmDMwb2/84CgQ17kX5yN9VIBa/SYcR
 KlJEGQvuWq5Fvg8D/uEr8SPOcFBlMhMm01bQ2MeybidB69Ra8SQLUkSX0v0kJsdJ6VBpkLQ/9
 TvzKthVDT4CiP1/SSGr22/fm5cgvFnwPPDaePWit1LIPA9KCoFl6zVaGKhExR/Gp/2x7G8E5L
 b35rxEPUu4fyLn5/isxBjURHCVPGYuK+1etXOumIXGU1ueN/Gop0B8Trlbllc+ytODZeDc9+6
 8vC2JnRawvx5t1fde3yfFbfCBvIWP2Dv+vKx6r9a6zZSHSwxODBp52bO01N4HfpF9EwjrZhAt
 9DTcOksQK3CPivOCmVP5n0ZEtOSMW4z9AxY8bUkD6q9JodMlXdMzKoM3YDVqlEd2ludpPMPne
 PZ9jpd+s3lqAdjjDFNTWlG95oHLT3in2wtki4QdL/rZSDjckerdB+3wOG+GKRGC9oXSV5uq7k
 vV7NbCa9GIqNP4OelxWH/n+79emie9Cy+SKR8Ldd0HA3b6JVO4eRllRYFDDOc5Tzlqe6Otuso
 FNnVzEGpaMRPQF5cKFGXH/q/ptrchMdQ769xks0FNO4Eh/5E85zZHphNO1HyzqEWfkiQf1cBH
 FtsLUL7bVMialutQLAnUnI21Jtj+aFIURZqp5iEsPGSFiK/YdaEO7PWbLKFyoZsRdfuU2FcqU
 J6xoyRqjY4e5YPM2ufBKTRPGARRIAKO8OFIORh/VCZV1hbyGXxxLGDwMgCdunLBPlyvGeNbcu
 3x003g7
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

it is sad when bug reporters simply delete the part of our bug reporting
template that says: "I searched for existing bug reports but did not find
any".

It saves the reporters a few minutes... and spends the time of you and me
in the hour range.

In this particular case, the bug report is an obvious duplicate of
https://github.com/git-for-windows/git/issues/766

The saddest part is that I already spent time to investigate this and to
come up with a work-around, and I already committed and pushed it.

So those hours are now thoroughly wasted.

Disappointed,
Dscho
