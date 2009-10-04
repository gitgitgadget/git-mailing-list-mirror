Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 10891 invoked by uid 107); 4 Oct 2009 13:24:07 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 09:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765AbZJDNUZ (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 09:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756672AbZJDNUZ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 09:20:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:57604 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756645AbZJDNUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 09:20:25 -0400
Received: (qmail invoked by alias); 04 Oct 2009 13:19:37 -0000
Received: from i59F574C2.versanet.de (EHLO atjola.homenet) [89.245.116.194]
  by mail.gmx.net (mp071) with SMTP; 04 Oct 2009 15:19:37 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/OkplanAjO7lqbKMj4XWQIeAuHf+Jrk1Gf4CUxlA
	MLsRLJa9VRpboL
Date:	Sun, 4 Oct 2009 15:19:33 +0200
From:	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To:	Pascal Obry <pascal@obry.net>
Cc:	git list <git@vger.kernel.org>
Subject: Re: A bug or a feature (git diff --author + --grep)
Message-ID: <20091004131933.GA32000@atjola.homenet>
References: <4AC87837.2010004@obry.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4AC87837.2010004@obry.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2009.10.04 12:25:59 +0200, Pascal Obry wrote:
> 
> I would have expected the --author and --grep option to work as
> pipeline filters. The first on the command line being applied first.
> 
> In other word I would have expected:
> 
>    --author AND --grep
> 
> But it turn out that the result are maching either --author or --grep:
> 
>    --author OR --grep
> 
> For example on the Git project:
> 
>    $ git log --author=obry --grep=Cygwin
> 
> Returns commit from obry and commit having Cygwin in their log.
> 
> Is this a bug or a feature?

Feature. There's --all-match to switch on AND-mode.

Björn
