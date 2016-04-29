From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config
 settings
Date: Fri, 29 Apr 2016 14:29:25 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604291417580.9313@virtualbox>
References: <20160428112912.GB11522@sigill.intra.peff.net> <alpine.DEB.2.20.1604281405540.2896@virtualbox> <20160428134953.GB25364@sigill.intra.peff.net> <CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com> <20160428153902.GF31063@sigill.intra.peff.net>
 <CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com> <20160428165031.GA31421@sigill.intra.peff.net> <xmqq1t5p5z8v.fsf@gitster.mtv.corp.google.com> <20160428191038.GA10574@sigill.intra.peff.net> <xmqqwpnh4joq.fsf@gitster.mtv.corp.google.com>
 <20160428210026.GA12268@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 14:30:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw7Yb-0003l8-2V
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 14:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbcD2M34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 08:29:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:65525 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563AbcD2M3z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 08:29:55 -0400
Received: from virtualbox ([88.128.80.158]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LsTge-1bgQfd2S2C-01246l; Fri, 29 Apr 2016 14:29:41
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160428210026.GA12268@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:XJ+lPDStcWQLj+O9gZGu3QdFCAGs6Gb5hJzgo43uUhKWtV535ox
 r4srsmfYM2MHf59EbKU4AIRaMobAJ/7gcvMMjxpb63n1osTQIxOjyS6YIcfEjh8V+29Hd8d
 jwx1/lLwWrNMum9nA7okS07tpQAS/p0v08a2lVciTxdkRaKw+XipoeHmOz3/+dPwT6F8YqP
 V7Mbhc5gOd78V8rs9AXVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6p0iYnnfyiw=:gj/wkgXUChTAMTcft9pFBk
 UHuSelQAy+NrJOqbkQZ9+KFW5/txi0FNjmqOtnWE78NGKFoR/b5lWgB9Dbc1bmIhIgEle/xDa
 LEERTllCT9+w18+QPeEGAc3+7dUsielX5LhK8VY0jp4EV7R+kzJSqQYmBrsujsIlcCaR8s71i
 TWGXcqA44jFUGmDbHAoR7GiiAXf8nLGmxNPOb6pW9Wb/uM0Yo3rUhpqYKu7pQhOBHV2EE8hdF
 ukF34nwwK2NfMpWpHTQLYEkmzpqiPQWO8zjDVZKVrm7ejNUqwDznfChuO6lMRRCEN2Ybukuha
 4IwpGjGvJxDSPlZCo7Hyos36wQrvv57TQJ0VcJ6yMOnzTeHiwCGiYziqf8kTXpNV0aQHQSwMC
 k9554zI+T5h0Wb64rVZdOABke406gPC4Hj4tT6IgyNoVAD9o5h5JRxp1MYA4m09zdoifaU78W
 zxcBZtFwu3z58fU9giQTzwZQbm5yOumqkK+LD6/n7VqVrtgUCImgSGIZ778mL95gCgzcvqiOE
 kDyIUbOKFvvUh9Biw3zuQqyaurht0T+EvmvoiY7NnNajbXWLOVMDcTvOJ63sMasNNa7D5bGWs
 ZLI7skWgeUjbR6zBRjEKzc5+quQxD3KIie1xEt0vOrHWwxjtpWLcrkrXRp/wxck18gxEVKF3E
 2uDPA/2WU6v8ZvTarEcK1GzARzVf3x5q2JlDUaRXj35uq7AGAv/Y4/C9qHjmjfjsf1iDQdReE
 NnBrSNYabnZp65seMv8OUee1LAEWi8Z7lfz+uwH+J2eEEaPbEUEgzkcgGsbEu+671i7Dl34T 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292989>

Hi Peff,

On Thu, 28 Apr 2016, Jeff King wrote:

> On Thu, Apr 28, 2016 at 12:28:21PM -0700, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > It's definitely sufficient, it's just annoying if a user shows up
> > > every week and says "I want X.Y", and then somebody else shows up a
> > > week later and says "I want X.Z".
> > >
> > > Are we serving any purpose in vetting each one (and if so, what)?
> > 
> > Personally I do not think we would need to filter _anything_ if we can
> > tell that the user directly said
> > 
> > 	git -c var1=val1 -c var2=val2 $cmd ...
> > 
> > and "git $cmd" ended up needing to spawn another "git" subcommand,
> > possibly in some other repository (i.e. "$cmd" in this case is likely
> > to be "submodule", but in principle it does not have to be).  If the
> > user somehow gives variables like core.worktree that are inappropriate
> > to be applied across repositories, that's user's problem, i.e. "don't
> > do it then if it hurts".
> 
> Right, we are talking about that direct case here. And any time our
> filter heuristic lets something through, it is probably "if it hurts
> don't do it" as the worst case.

The more I think about it, I actually think that we do the user a *really*
great disservice by filtering the CONFIG_DATA_ENVIRONMENT. If I call

	git -c ... $cmd

and that configuration is *not* picked up, it is much worse than letting
users shoot themselves in their own feet by specifying config settings
that are *prone* to wreak havoc.

> So I think the only two cases worth filtering are:
> 
>   1. Ones where we _know_ that the config is nonsense to pass along,
>      _and_ where a user might conceivably make use of the
>      just-the-top-level version of it (core.worktree
>      comes to mind, though of course they are probably better served by
>      "--work-tree" in such a case).
>   2. An option where we think there may be some security implication.
>      Setting "http.sslverify" to false does have some security
>      implications ("oops, I only meant to turn off verification for the
>      root repo, and I got MiTM-attacked for the submodules!"). But it's
>      so obscure and unlikely that I think the benefit outweighs it.

I can see that happening when somebody calls an alias with `git -c ...`
and that alias performs actions in the top-level project as well as all
submodules.

But. Do we really have to be "Big Daddy" for users who do that?

> I am OK staying with a whitelist.

Me, too. But I am even more in favor of abandoning this "we know what is
good for you" approach, i.e. that whitelist that filters
CONFIG_DATA_ENVIRONMENT.

Ciao,
Dscho
