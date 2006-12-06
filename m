X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvs-migration document: make the need for "push" more
 obvious
Date: Wed, 6 Dec 2006 14:14:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612061411380.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org>
 <45760545.2010801@gmail.com> <20061206.105251.144349770.wl@gnu.org>
 <Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <el6d50$p7e$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 13:14:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <el6d50$p7e$2@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33455>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrwbO-0007gJ-9R for gcvg-git@gmane.org; Wed, 06 Dec
 2006 14:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760590AbWLFNOT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 08:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760592AbWLFNOT
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 08:14:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:42668 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1760590AbWLFNOS
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 08:14:18 -0500
Received: (qmail invoked by alias); 06 Dec 2006 13:14:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp031) with SMTP; 06 Dec 2006 14:14:17 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > +  * Since every working tree contains a repository, a commit will not
> > +    publish your changes; it will only create a revision. You have to
> > +    "push" your changes to a public repository to make them visible
> > +    to others.
> > +
> 
> I'm not sure about context of this addition, but it is simply not
> true if you publish your working repository.

Remember, you are talking to CVS users. They are not dumb, but sooo used 
to the CVS ways. So, they do not publish their working directory.

Later, when they became familiar with Git, you can tell them: "BTW you can 
also publish your working directory, but then you have to be extra careful 
with git-commit --amend, and if you allow pushing into your repo you have 
to add hooks to prevent updating your current HEAD, etc."

Give them a chance to get used to the concepts of Git.

Ciao,
Dscho
