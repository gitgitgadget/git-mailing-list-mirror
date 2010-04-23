Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INVALID_MSGID,MSGID_NOFQDN1,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 16644 invoked by uid 107); 23 Apr 2010 14:33:20 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Fri, 23 Apr 2010 10:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225Ab0DWOcz (ORCPT <rfc822;peff@peff.net>);
	Fri, 23 Apr 2010 10:32:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:41497 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753258Ab0DWOcw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 10:32:52 -0400
Received: (qmail invoked by alias); 23 Apr 2010 14:32:50 -0000
Received: from dinoc9.indmath.uni-linz.ac.at (EHLO localhost) [140.78.117.79]
  by mail.gmx.net (mp005) with SMTP; 23 Apr 2010 16:32:50 +0200
X-Authenticated: #25381063
X-Provags-ID: V01U2FsdGVkX19+eSsLGYJ++RRpSNykd2WktDdScpiIj8IgOJnjzm
	eV+CBFiN7AZrtQ
Date:	Fri, 23 Apr 2010 16:32:48 +0200
From:	Konrad Karl <kk_konrad@gmx.at>
To:	Sverre Rabbelier <srabbelier@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: multiple .gitignore and friends in same workdir possible?
Message-ID: <20100423143248.GA6930localhost>
References: <4526533254752708319@unknownmsgid>
 <y2kfabb9a1e1004230601zcede9e2ah2db8cb0f082bcbb4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y2kfabb9a1e1004230601zcede9e2ah2db8cb0f082bcbb4@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi

On Fri, Apr 23, 2010 at 03:01:42PM +0200, Sverre Rabbelier wrote:
> Heya,
> 
> On Fri, Apr 23, 2010 at 14:46, Konrad Karl <kk_konrad@gmx.at> wrote:
> > Is this currently possible or am I missing something? It would ease
> > my task a lot.
> 
> I assume that each repo has it's own gitdir, in which case it has it's
> own config file, so you could just use "git config core.excludesfile
> .gitignore.one"?

yes I could (i confess I was not aware of this config var) but
the fine manual says:

  In _addition_ to .gitignore (per-directory) and .git/info/exclude, 
  git looks into this file for patterns of files which are not meant to be tracked.


so if there was some way to _not_ consider the standard .gitignore &friends
I would be happy to live with.


Greetings,
Konrad

> 
> -- 
> Cheers,
> 
> Sverre Rabbelier
