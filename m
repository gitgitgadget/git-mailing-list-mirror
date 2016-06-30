Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8B9B1F744
	for <e@80x24.org>; Thu, 30 Jun 2016 08:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbcF3IuZ (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 04:50:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:55919 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575AbcF3IuW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 04:50:22 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M5HZD-1bXQsW1TQd-00zVTt; Thu, 30 Jun 2016 10:45:15
 +0200
Date:	Thu, 30 Jun 2016 10:45:13 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Johannes Sixt <j6t@kdbg.org>
cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] Report bugs consistently
In-Reply-To: <5774B039.8080802@kdbg.org>
Message-ID: <alpine.DEB.2.20.1606301043320.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de> <5774B039.8080802@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PJtZBd5WOS079yFp48RRN89OGs7DSkn4Zl5jkbirMdG56s1Joph
 j6c8S9etx9QmdvNs2zOTcpt+kZUvLm6wu3Af4YW5vIkobnDOJtgc6l0RUC7dlKvxrWTOXCQ
 qnqo7uCr49isTcW1/NcBbFvHTVKGzM6tx6ngX/P+3HuTn9/Kt5CnGlvwysipsTMLC3nitlX
 zpJj9tDzNYeW3jktEsHnw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:eWh6SZxtPug=:GXh7xqP1Wd3mVx+dTrNtFx
 9ugp8NpJn8coThWd8oqOn27/ZatvkBcrG7Sgpdf8nNBwcEq0coHpQPL0E1yuKmcmzk7QvLkRr
 iDLkInxrBa1uyVzg85fLlP6INKlW7JEDHT75snUDyP6FlUvEoBWqN3En0w3gAShJKXSp1U9Vr
 NZ49k9XeXyQkfj3UF1pRh2UCRX/zHjokwZUuFnNmkffAPgcQE7Pc0EasVehHcqOFhsN+2Gz78
 t2kaNvWv5Zul5TjfUgFHaFjlZ46nhd1frbDt5MCFYw3WWM143UAwb4V0jYtYMu/So7g5lQ5HF
 37sxMLsUXmxRhv8heuXnhfOIK/qFPo1g4Qg9shjcn6+dqacVQlKkZw8e+GciOXe++kaCTZX8e
 rj7ZBRURqM52atfH5Zp59GhNM79l1QECtQFqQvQOml2t/g9DjzQq3C3rHT7hqVXJYVj+aHf1u
 8wnFAsovJ2NIv7xX+DMD49CAuzxiUnb5o/w1F3DalWR7RRi8wnQfKcZZ1C75fRx5dfNnXyVT7
 zbKPJ8Od95VXUaz3LRDKFO1fzEjusKQio99wICSD8XHumfUJU87iOyat6Zmf+b5+dQT3UhEWa
 /Xka5ETr8yQiJjKxULz0MtQE2U4hushYaJmAqISwvZktTGv67ONBvXaOgiskEvRJgaI39By4T
 p7W1uDm358btOjtS9wpcxwAI9zaIeiQPJ4qNgHnSdZ8frwz+YUXoo0FZ0Cq9MF0kF7UVOuvVB
 V/Q2Cu5K/fBRSpPhANPst6Vjmw8Po+43DiG7W/k9SORN65Gg+s6sHF7pO6onA0PJfn55Zxp5h
 jA1NZKg
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Hannes,

On Thu, 30 Jun 2016, Johannes Sixt wrote:

> Am 29.06.2016 um 13:36 schrieb Johannes Schindelin:
> > @@ -955,9 +955,8 @@ static struct merge_file_info merge_file_1(struct
> > merge_options *o,
> >
> >      if (!sha_eq(a->sha1, b->sha1))
> >   				result.clean = 0;
> > -		} else {
> > -			die(_("unsupported object type in the tree"));
> > -		}
> > +		} else
> > +			die(_("BUG: unsupported object type in the tree"));
> 
> Would it perhaps make sense to remove the _() markup (here and a few more
> instances in this patch)? It's simpler for developers to find the code
> location when a "BUG:" is reported untranslated.

I would agree, but the purpose of this patch was not to fix that, but to
fix the inconsistency of the message.

Maybe as an add-on patch, with *all* 'die(_("BUG:' instances converted?
That would be even more outside the purview of my patch series than
touching the bug reports outside merge-recursive.c, though.

Ciao,
Dscho
