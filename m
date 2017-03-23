Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532EC20958
	for <e@80x24.org>; Thu, 23 Mar 2017 14:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934133AbdCWOje (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 10:39:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:61839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932360AbdCWOjd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 10:39:33 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKLeM-1crbar2xXi-001eUv; Thu, 23
 Mar 2017 15:39:27 +0100
Date:   Thu, 23 Mar 2017 15:39:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/3] sequencer: make commit options more extensible
In-Reply-To: <xmqqa88dkw9j.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703231539010.3767@virtualbox>
References: <cover.1490194846.git.johannes.schindelin@gmx.de>        <c0c836e1f1739af25ad875419ee6125b53ac6a1a.1490194846.git.johannes.schindelin@gmx.de> <xmqqa88dkw9j.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yJDqJmISGY7hXLCNTCGM5lNWzBfyAe0xF+QhpY038nkGcmYw9w4
 hmZWw0yVVJVIaUZaiLSNo+UfMVlp+zK61xs5+nh7uewnHcIYmcSmLXhbuCkjtkYIxEQrIG/
 ojM1ZZ9W0xVszeosgZo15YBO1rmSENWAmFErJ9TggJazMLZTsRNCj/8V1rphD1xWzkV+A9e
 cC6ML5k3CJ1wAqfWzyLRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hEhIm2fHPAU=:IIN+FJiuFMQWaoJIpm6fyA
 PG/0v/rCIA/wWVcFF2+isxzWDW2pFT7lgff71W+9IfsnrLo4DWhXKRg09dCKpdmZG5GEo858q
 vUD/LF0T+Ed7hTivw2koVI0oX/6fJjT/tWPIuUlEb21ucSA6JD2VHvhxNG4zqeD8RzDbHJRxI
 lp1jflEkqDlXX70x7asdKUpHzsaibbYRPUGKGdTf4BnCLJutJhRUDILp4E3CrtWsOmmkK0tjY
 ULue101jNDP/VXXaqrJ0NIO+zfcHcAaFEAgeBHbDnpwJ9eAp/kEhfnWWJ3ZlbgtWPUDI8Fowj
 k2TV4i/0qD/LD5TjtenVAVDC/ej5W8E7cuI2WtJb9cq/uU8zyE1o/I7q9ms6fzPJOWV147Rnv
 6c4oQtwQuMvvyr0XItHaIqUQawlmn0QqSLRDIWL2WH+cmALbU+0rU3j7uEmaSY2uwmEV829vq
 LZsH2g/sOeHwUA0oGqFK+pN4GIv+1ENRIqpz8vQ59z/MUrwWq40UI+89aNqzJPJfvXV7sTvjU
 +XpcUrJ6xUWdYdcuKMOXjW9KuiIsNXl7gu9eU7+LM+UTgA+kWZENIsv/Fe2gAv4CbYhfs74zo
 HjaK+qpeGDUifwdXk5R+UeRoxOju402JgBN0LsoiX789ypp9wHUkwDeDu85UqlRF3m+d72T2N
 8VWVE/RuGkLKi61JBjP2McQ9jpZytJgqd2G9vmyNPoSIZmsjiYjPCcL5b3DreJQF9Mc3gGOCS
 AxfjWIh0D6Lf50of3ImcB4j0svWtUtedXhat1JYj5pXSR1Qq0mKUYC0gvZxrFFEdFZEDWvdIA
 eR22GYlFmSNpnQB6rulgkJxV0B6tQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 22 Mar 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > @@ -615,8 +620,7 @@ N_("you have staged changes in your working tree\n"
> >   * author metadata.
> >   */
> >  static int run_git_commit(const char *defmsg, struct replay_opts *opts,
> > -			  int allow_empty, int edit, int amend,
> > -			  int cleanup_commit_message)
> > +			  int flags)
> 
> Use "unsigned" not signed integer for a collection of bits (see
> e.g. GSoC microproject ideas page).

True. Fixed in preparation for v2.

Ciao,
Dscho
