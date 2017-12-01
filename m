Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41A6020A40
	for <e@80x24.org>; Fri,  1 Dec 2017 10:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbdLAKpt (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 05:45:49 -0500
Received: from mout.gmx.net ([212.227.17.21]:51308 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751897AbdLAKps (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 05:45:48 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9bYB-1eFTVO47Pb-00D2c5; Fri, 01
 Dec 2017 11:45:46 +0100
Date:   Fri, 1 Dec 2017 11:45:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Robert Abel <rabel@robertabel.eu>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-prompt: fix reading files with windows line
 endings
In-Reply-To: <3557a15f-3019-7d31-b990-66c2e0cb893f@robertabel.eu>
Message-ID: <alpine.DEB.2.21.1.1712011143320.98586@virtualbox>
References: <20171128201818.4132-1-rabel@robertabel.eu> <20171128201818.4132-2-rabel@robertabel.eu> <alpine.DEB.2.21.1.1711291519290.6482@virtualbox> <d57e4cb9-b0b4-314e-370a-e0db58a2a7da@robertabel.eu> <alpine.DEB.2.21.1.1711300100320.6482@virtualbox>
 <cacbf41e-3b4a-99e2-a0e0-50bb4cd9e152@robertabel.eu> <alpine.DEB.2.21.1.1711301619590.6482@virtualbox> <3557a15f-3019-7d31-b990-66c2e0cb893f@robertabel.eu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TFq2VnD/B4E1TTyXluY6iinS4wJRb9rMTIEMgZQTP83oU2cU4rp
 /0JOR/8nMGRbS/v9KSLGTZt3k9giI3Kf8+b5aPahgphf+JzwfCqG+zFiKzl4eXjuN8P0lXq
 T44gRYFuXzzB+7OlZaSnOv5XWUoL3sy4835YFBBWfaA+rqLMxErEizcNL7Tmq55y+Sqh94o
 EFTKxhE8qteBKmBclvHSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HCnZBLxBmTg=:EZioxNKzAggZOYZx90dd+i
 2eh92B71+dL/eufMEh0wfTEPFKLU9sndD2NoLlQZJ38VDzbDgtRsVUzqJf6iCFBl9raU3YM3t
 EKVkMq9KJvueQ20wyxFl2VnBlR82/j2SdBBkq8yu0+29oX5+cwOaCUjBVSnIzh14eMv8Dj/nN
 QOvFcEhB8RXCpPJunVNKgkW6qQIei/5CWs+/Bu1BjVr0OnW9j9oRsqZvIe4vRPar59cXTyl9E
 Ifmvvcvv2K/ViK7mgzUubelKGHub6/JTT/VA3AEckWyH+qjNbiUBeFCfk8gxLgCVeU/I3qEa3
 DkPZA0LADKxx1Y89t09358jwgCfKQLnJVAGZFD4f6kBo39NBXxajNb6BdJep0GjyXs+ROIxVf
 nl+ONd4/JEQ7rpQ7kRjyg5mWQnjGH7bwvh/M7jAYRhAJX2SBBZEjrTF9yM6HsXX6sBxBri39O
 LhF2AXc/inJZSmsWJwJ+4iOnnMEmTH3fu09o8kta9Ro/jnpJi55ijGXaJopRifI7IjOZUvdeN
 WLP/lI3lsqApIQmh203bmnBTCt+oJq1vYeQyIaUgH4dCIDEl38RQG56EtfAUqHzpgXoeMxUPg
 fP7NE/S24V65/I161ZXP2y7Y6GNDDx0nPOUwDxNMkLrKmEpZ6eHfJjE2HRNry0Y/C1YMhoJbA
 Tit3/IX0Wyv+EIOJzo+Kf1FBFs5zGLApMLoozVmCH4lrNLXWZlu0yesa0LymFZdPx+PoG+bZD
 El8tN+TQjTvNIKN83plwV55hcfyaANEBkGLeeWXn02LTKhKFKFXcJF65Fl+ZiFxoaTmefzAQS
 yz90MqyOTzpi7IyIJxEqlU1X0P9kEebKiENw46UDU2BWXqpbPU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robert,

On Thu, 30 Nov 2017, Robert Abel wrote:

> On 30 Nov 2017 16:21, Johannes Schindelin wrote:
> > On Thu, 30 Nov 2017, Robert Abel wrote:
> >> So reading a dummy variable along with the actual content variable
> >> works for git-prompt:
> >>
> >>     __git_eread ()
> >>     {
> >>         local f="$1"
> >>         local dummy
> >>         shift
> >>         test -r "$f" && IFS=$'\r\n' read "$@" dummy < "$f"
> >>     }
> >>
> >> I feel like this would be the most readable solution thus far.
> > 
> > Hmm. I am just a little concerned about "dummy" swallowing the rest of the
> > line, e.g. when reading "1 2 3" via `__git_eread line`... the way I read
> > it, dummy would consume "2 3" and line would *not* receive "1 2 3" but
> > only "1"...
> You missed that tab and space aren't field separator anymore,
> because IFS=$'\r\n'. The way I see it, __git_eread was never meant to
> split tokens. Its primary purpose was to test if a file exists and if
> so, read all its contents sans the newline into a variable.

Ah. The "$@* put me on the wrong track. If you hard-code the expectation
that __git_eread is not used to split tokens, maybe there should be a
preparatory patch (after carefully ensuring that all callers pass only one
argument) to change the "$@" to "$1"?

That will prevent future callers from expecting the token-splitting
behavior that is promised by using "$@".

Ciao,
Johannes
