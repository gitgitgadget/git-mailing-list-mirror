Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0418F20282
	for <e@80x24.org>; Tue, 13 Jun 2017 11:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbdFML0E (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 07:26:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:55767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752109AbdFML0E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 07:26:04 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJmcS-1dJe1m2JW8-001EKd; Tue, 13
 Jun 2017 13:25:54 +0200
Date:   Tue, 13 Jun 2017 13:25:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 8/8] Use the early config machinery to expand
 aliases
In-Reply-To: <20170610100730.j62kh2hayt6zknr5@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1706131323330.171564@virtualbox>
References: <cover.1496951503.git.johannes.schindelin@gmx.de> <af40ce088de03130a5edfae187bb8274b5a9d3a9.1496951503.git.johannes.schindelin@gmx.de> <20170610100730.j62kh2hayt6zknr5@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:91YGaP0ZRRW6e6Gf4CcY+TP+ertDIdcarpV1t0pstciqXhjNHsW
 Q/TC45+ck1AZXqGhNaPtA8ioDPWToh34DSRU8KVHuNuxK7kqRdAua/1ZZWIY6dW3JRhbf9v
 xMe5CGkaTjvSeBCpieNdgKxrxA2MBSILthteqh3qV7IH7Oe5k6F9wKWOhMUqsy+KtypAI3/
 g9nB2K9izwSfy0jA1h3+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dvuGMIEctb8=:9igONQkfhFrXdiIBAMdyAu
 2Zh+3ZfQWGnA9iLlcAvYrWhu2PfDnSzNoy+fUpo3Xke2WS0+cbiLm5vQkvUCpUuM64vF2ru0i
 Ef3TlCE2jCcDq1svZVxhq4uhBznSUMb44gnfGsBK85ZILnjrr5Yv50UN5OQOwq2LRM9RcFVfa
 PeLn+0zdFtzhLl/qWClGKW/ERwFc/b/dg42AQ9QUhHYEPe3LNv9LHz5eImgjMV+CESHJ6g0Qh
 CWkpdY3KynEx7CDCstUNvNlA+ftEEwuTcFXfEpTHuEN4T279eiN2mEx9wQciwUl1ILR5vunRi
 Tw6rNMyxcLrnRm+/KZgiTn3T+bCQHemCrmxM7Ih9DXJQ51dgJ37yVubG8onr3w98JC+gVlzPo
 r2ng/E4Z/587nfTA+6e+bnD73UNkY6pdmiv0mvenu7z4tVU1CaCBLEDLj8n+QS2JnvTHze6cj
 aFdxZEedSK8zDeXXBRPM9dEBGZxEbORTb+e4sEj8uVXlALe6ZyvjC5j53hfo+cJPyHO5HFBIL
 tM8cHF8y3s+Dd2dmvEqhMzTVn99v823kEF14hznrtGbSczD0AHRqGDfeaXa2rOebhz5e6RSOd
 /c9GwC5y2XX969sgYPnY8iKpni4EsjGhKAPXiWnbe28fO52AIQ8H4iaK0dRgIljB6DvSz5gWW
 cjsdpt3fPJIryXHZyFk3Fy2zLngHnocY4P8s9ihDKpbhAJ0FL24GBlg3VD0tY2du0DgnYUlqp
 ttzRc5QCnn/zZ7gwoLkwRHm+TOY5UHXkF/t3VPN+SB+gPjgHaIh7yqMdoT/K+z7A4JtuwI4C2
 CGRisV4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 10 Jun 2017, Jeff King wrote:

> On Thu, Jun 08, 2017 at 09:53:53PM +0200, Johannes Schindelin wrote:
> 
> > @@ -245,36 +201,37 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
> >  
> >  static int handle_alias(int *argcp, const char ***argv)
> >  {
> > +	struct strbuf cdup_dir = STRBUF_INIT;
> >  	int envchanged = 0, ret = 0, saved_errno = errno;
> >  	int count, option_count;
> >  	const char **new_argv;
> >  	const char *alias_command;
> >  	char *alias_string;
> > -	int unused_nongit;
> > -
> > -	save_env_before_alias();
> > -	setup_git_directory_gently(&unused_nongit);
> >  
> >  	alias_command = (*argv)[0];
> > -	alias_string = alias_lookup(alias_command, NULL);
> > +	alias_string = alias_lookup(alias_command, &cdup_dir);
> >  	if (alias_string) {
> >  		if (alias_string[0] == '!') {
> >  			struct child_process child = CHILD_PROCESS_INIT;
> >  
> > +			if (cdup_dir.len)
> > +				setup_git_directory();
> > +
> 
> I'm really confused here. We went to all the trouble to record the
> cdup_dir as part of the alias lookup so that we could make sure to
> chdir() to it.

Right, that was my first idea.

But then the test suite taught me that we set at least GIT_PREFIX and that
tests break (or, in other words, promises Git made earlier) if those
variables are not set.

So as a quick fix, I simply called setup_git_directory() instead of
chdir(cdup_dir.buf).

> I understand why you must use setup_git_directory() and not just a
> chdir(), because the latter sets up variables like GIT_PREFIX and
> GIT_DIR that the shell alias may be depending on.

Exactly.

> But couldn't we just unconditionally do:
> 
>   setup_git_directory_gently();

But of course we can do that! Why on earth did I not think of that...

Will change the code accordingly.

Ciao,
Dscho
