Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-0.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 10329 invoked by uid 107); 4 Oct 2009 10:59:24 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 06:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106AbZJDKui (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 06:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755027AbZJDKui
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 06:50:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:40638 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753673AbZJDKuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 06:50:37 -0400
Received: (qmail invoked by alias); 04 Oct 2009 10:49:48 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 04 Oct 2009 12:49:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Cc5tXG+nCLxyabfcj091WXyv9Q74xf+1Woc3rVn
	Ac0wiP0b9KmUmH
Date:	Sun, 4 Oct 2009 12:52:09 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: schindelin@pacific.mpi-cbg.de
To:	Jeff King <peff@peff.net>
cc:	git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com
Subject: Re: [PATCH] Add the utterly important 'mispel' command
In-Reply-To: <20091004065239.GA7890@coredump.intra.peff.net>
Message-ID: <alpine.DEB.1.00.0910041250420.4985@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0910040040180.4985@pacific.mpi-cbg.de> <20091004065239.GA7890@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Sun, 4 Oct 2009, Jeff King wrote:

> On Sun, Oct 04, 2009 at 12:41:55AM +0200, Johannes Schindelin wrote:
> 
> > --- a/builtin.h
> > +++ b/builtin.h
> > @@ -12,6 +12,7 @@ extern const char git_more_info_string[];
> >  
> >  extern void list_common_cmds_help(void);
> >  extern const char *help_unknown_cmd(const char *cmd);
> > +const char *help_mispeld_comd(const char *cmd);
> >  extern void prune_packed_objects(int);
> >  extern int read_line_with_nul(char *buf, int size, FILE *file);
> >  extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
> 
> Hmph. This hunk doesn't apply to Shawn's master, and your blob sha1 is
> not in my repository for a 3-way merge. ;P

Hmm.  It might be based on 4msysgit.git's 'devel' branch.

> Also, I think there is a bug:
> 
>   $ git mispel show-branc
>   error: You probably meant show-index
> 
> Or is it intentional for it to throw the user off track?
> 
> Let this be a lesson, kids: don't drink and code.

Well, the command is called "mispel", not "autocorrect".  So I think you 
misunderstood the purpose of the patch.

Let this be a lesson, kids: don't review GitTogether patches before you 
had a drink.

Ciao,
Dscho

