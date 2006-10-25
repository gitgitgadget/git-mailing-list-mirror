X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-merge-subordinate
Date: Wed, 25 Oct 2006 18:19:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610251819080.3286@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061025155009.GD5591@parisc-linux.org> <eho29l$1td$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-206539939-1161793194=:3286"
NNTP-Posting-Date: Wed, 25 Oct 2006 16:20:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <eho29l$1td$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30072>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GclU0-000748-EN for gcvg-git@gmane.org; Wed, 25 Oct
 2006 18:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422881AbWJYQT5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 12:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422972AbWJYQT5
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 12:19:57 -0400
Received: from mail.gmx.de ([213.165.64.20]:10393 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1422881AbWJYQT4 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 12:19:56 -0400
Received: (qmail invoked by alias); 25 Oct 2006 16:19:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp044) with SMTP; 25 Oct 2006 18:19:55 +0200
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-206539939-1161793194=:3286
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 25 Oct 2006, Jakub Narebski wrote:

> Matthew Wilcox wrote:
> 
> > Linus doesn't like seeing unnecessary merges in his tree.  I'm not a huge
> > fan of them either.  Wouldn't it be nice if we had a merge method that
> > did a merge without creating a merge?  I call it git-merge-subordinate
> > (since my tree is subordinate to the tree I'm pulling from).  I suppose
> > you could call it 'slave' if you want to be more pithy.  Anyway, this
> > is a first attempt, and it's totally cargo-cult programming; I make no
> > claim that I understand what I'm doing.  But it does seem to work.
> 
> Hmmm... the --squash option to git-merge/git-pull isn't enough?

What subordinate does is not _merge_, but _rebase_ on top of the fetched 
commit. So yes, --squash isn't enough ;-)

Ciao,
Dscho

