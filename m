Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD25F20282
	for <e@80x24.org>; Tue, 13 Jun 2017 11:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbdFMLmL (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 07:42:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:62102 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752033AbdFMLmL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 07:42:11 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQ2zr-1dFX9E35nv-005FY6; Tue, 13
 Jun 2017 13:42:03 +0200
Date:   Tue, 13 Jun 2017 13:42:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] alias_lookup(): optionally return top-level
 directory
In-Reply-To: <alpine.DEB.2.21.1.1706131319130.171564@virtualbox>
Message-ID: <alpine.DEB.2.21.1.1706131339320.171564@virtualbox>
References: <cover.1496951503.git.johannes.schindelin@gmx.de> <aa6601bbfa50c728b7820e0a2991da76288509a5.1496951503.git.johannes.schindelin@gmx.de> <20170610101813.n26wmxcueicecptz@sigill.intra.peff.net> <alpine.DEB.2.21.1.1706131319130.171564@virtualbox>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nr+OQQf12cOlXL7nzqFdgj1WJlboByElNdGKozP3PYAvg9mkzeH
 NeJG43ds+gX5JudUwfCOLvxEBcfxheMz8FIy14W9T6FdLEGZoUwZj9mnbzmcBvSd+Qiqd0n
 hrB6JhbUB+zIUO7UzSCUbCZdlHNaVyBjEJMlMJ/yuLpAnv29Qc3kgu3tg1NJcAXzP0qBk0G
 zQstMdNGaNYzW9TXDB76g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QJoldbZnR1c=:5evVKSpXmy9HdByf80WFDW
 qxFG+V89zjfQpwA7iHj5tz6j7HEMeD45U/QMACS44P7rIpOZn/5NzHanJ+bI7VUvINuL5oekr
 yC/gtJLiuUm9EbQIbOpPTQmxZU+H7P0JCwP9x6mPQYnQcQXsyI8nXsB4mADRnoJBdHZfHuxUx
 6aCXo/JedDO5JXxoJGvjJN/1dJwG57l1RYO6YBY+n7RQ0P+hP0nwUQQabn7vYvTDhgH73GZqN
 Qc2a8f81DEPvqiYevAV3b3xTOqsYK+Pxt0m9jd/RHToXeAdVOArg6LUp/1Sv/HTCM1PzTCeA9
 r1J3DxselrPjnAmQYI+eHqytDbVkqy/lYxx54nDlxRGB3xm194rhurtDlrDhSatTo0gZr871u
 JTaMcKnmMaiomT8AknoFPG7SzDUHUlB9/Vgh/Cc9sQPSTnKpqwneyKBLVZCOt+6E4xHmUq5TH
 +d/CEGv+nrnFe7Sdzn+go4tfaUfLaUxROmaoT2dBFtY8OiFUZizUA5BA8HxKBGCGO/KcE9W96
 n7H0g3/1mYaioNGf8DcdrYQCJAzM20EkR7S7KICeXNLvfq5rqr8QUiMAqfcVvHQqIoPB2JMVN
 H5yPqTISCEv3dwV+mX8SJOmSTyuaEjeRJ1Q6DN+ALo5gLyCXeXcM0qqVQzf4wRht6KpQTOYZ2
 VhtAshjbU92PkH/GFteL/yY73hnIdnOZ5UFR1Zs7Vqo6DW4Koy4HqFu3Ta49ZF4z3ArSf7Mkn
 A/HpsEnkAGe6/8HJ9pwdZFMej0RtaboUVg2YTCBsyjFDdMCcu6bLxRguNsdJVRWLBprV/7UmZ
 s1XZSV7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 13 Jun 2017, Johannes Schindelin wrote:

> On Sat, 10 Jun 2017, Jeff King wrote:
> 
> > On Thu, Jun 08, 2017 at 09:53:50PM +0200, Johannes Schindelin wrote:
> > 
> > > -char *alias_lookup(const char *alias)
> > > [...]
> > >  {
> > > -	char *v = NULL;
> > > -	struct strbuf key = STRBUF_INIT;
> > > -	strbuf_addf(&key, "alias.%s", alias);
> > > -	if (git_config_key_is_valid(key.buf))
> > > -		git_config_get_string(key.buf, &v);
> > > -	strbuf_release(&key);
> > > -	return v;
> > > +	struct strbuf key;
> > > +	char *v;
> > > +};
> > > [...]
> > > +char *alias_lookup(const char *alias, struct strbuf *cdup_dir)
> > > +{
> > > +	struct config_alias_data data = { STRBUF_INIT, NULL };
> > > +
> > > +	strbuf_addf(&data.key, "alias.%s", alias);
> > > +	if (git_config_key_is_valid(data.key.buf))
> > > +		read_early_config(config_alias_cb, &data, cdup_dir);
> > > +	strbuf_release(&data.key);
> > > +
> > > +	return data.v;
> > >  }
> > 
> > Two optional cleanups here:
> > 
> >   1. We don't need to call config_key_is_valid when using a callback. We
> >      only needed that to prevent the configset machinery from issuing a
> >      warning. It does save us reading the config entirely when the
> >      program name is syntactically invalid as an alias, but that's a
> >      pretty rare case.
> 
> It may be a pretty rare case, or it may not be. I do not want to think
> hard about this, so I just wanted to keep that test.
> 
> But since you suggested it, I will simply blame all the fallout (if any)
> on you.
> 
> ;-)
> 
> >   2. Now that we're not using the configset machinery, we don't need to
> >      have the alias name as a full string. Instead of using the strbuf,
> >      we could just pass the "alias" string itself and do:
> > 
> >        if (skip_prefix(var, "alias.", &key) && !strcmp(key, data->key))
> > 
> >      in the callback.
> 
> As you probably guessed, I had tried that first and then figured that if
> I needed to keep the config_key_is_valid() test anyway, I could just as
> well keep the strbuf around for later use.
> 
> Will change the code,

Alas, I won't change the code after all.

It is really tempting to avoid the extra strbuf, but then the error
message would change from

	error: missing value for 'alias.br'

to

	error: missing value for 'br'

which is of course no good at all.

And since I already have to keep that strbuf, I'll simply keep the
config_key_is_valid() guard, too (because why not).

Ciao,
Dscho
