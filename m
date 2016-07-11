Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7792A2018E
	for <e@80x24.org>; Mon, 11 Jul 2016 06:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933615AbcGKGY5 (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 02:24:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:64372 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932286AbcGKGY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 02:24:56 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lxt3Q-1bJLt819WO-015EkC; Mon, 11 Jul 2016 08:24:50
 +0200
Date:	Mon, 11 Jul 2016 08:24:49 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2016, #03; Fri, 8)
In-Reply-To: <xmqq37njlora.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607110821500.6426@virtualbox>
References: <xmqq37njlora.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:V+3ycEYWh8E7wcAuuats4bYSb3kZQDkRu/ewG1P2rQZ7V4r2bTz
 secmP23F252h/7t8s91f8FTlVJN25wdPtrhglywyUE/6b4pCWYWkVCN8YxckzO+ZRgrd4Yr
 Wy5miFP6S5vpkNTKZMSilqfqTp84pOo2Th2e/UBps7Vkpsvlo6cU9PDWFpzB/HcHfX7dyPz
 sNdCovUtrEGqnrO+JuGRA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:V4PYybE+pcM=:xCEJBRD26S2wiQes6s03ov
 p9eQcLSJUsQfE3iBxYXRAtAWohJg4FVTF62wVKqWNx8aPBLVn0Narc3IIwVpReztQf1MwdQ1e
 I4vlwWgJEsOZoQSjpl2YrCYItoeYAUYmwM1Ph4Jgz5TUv+Qv9bIKx9PXOikci/+s7ZxWF4RLh
 vBJVHy7umAe79U0pWsl57NVteMKMbfmzZGzIV0q2Oy05w11aof3Qp1ZBMqp+RtT8ivpzXTvCe
 HMav4jI9OOmufCZ03YpnqErPCwqk/tKZ0Scy2rzgbQmGH6Y8BFhg+2BXcR2oq9wtJzUjDu2Iu
 ruLJlwnrnUpZURXXQ42aTGe/HGUfKEo1ma9IuMtnewRVGlVMTpfw7huIruzJDJeqc6DC/E6wM
 Pqyn8+7dRKdxHmwjoIeM+plE4dT/v+z0jDFxGhpTO2uOZoFAd51Ngdqv1RmfeANFbuV7HEAsh
 w5LxfOlDWQzKCf8bAV+nEvaEH47+gCRyPrQKQUhEmaOJMgLx0bBbc8uu3h9AFWx8V081tzLLQ
 zw33MFiaDjLM+HZ8fn7AXY9lxfuVIrt8HZabYsXHU1iKj8DsMb6Eu4E7NyL8ktFKOH07EDSoo
 0p4uPest+gkbXn1zuPHH7JJpMViZJRZtp9JizwvKAIxLwAiCNDUTlfKE0JWNY0aNSbd224rIv
 vPfrSYykmJBtIjKFwC1m4kSPQy+B4rr0rvBMuG1cvubXkdeq0aFLirRfQN8FVXgugxKsTPq2i
 wBB4pBRqI9gbPSvLXwp5WM+4smwuXYx3gDKMt5GxxiNv6GZP6MuQ+CUbwFqDE3trlRyhLFYBH
 WJA/fpB
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Fri, 8 Jul 2016, Junio C Hamano wrote:

> * js/am-call-theirs-theirs-in-fallback-3way (2016-07-08) 1 commit
>  - am: counteract gender bias
> 
>  One part of "git am" had an oddball helper function that called
>  stuff from outside "his" as opposed to calling what we have "ours",
>  which was not gender-neutral and also inconsistent with the rest of
>  the system where outside stuff is usuall called "theirs" in
>  contrast to "ours".
> 
>  Will merge to 'next'.

What about the am-call-merge-recursive-directly patch series? As I
demonstrated by rebasing it to `pu`, it is actually not butchering the
smudge/clean pathway as you suggested.

I am a bit at a loss here: what can I do to get this picked up?

Ciao,
Dscho
