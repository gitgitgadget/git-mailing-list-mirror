X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation: reorganize cvs-migration.txt
Date: Thu, 7 Dec 2006 15:28:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612071522080.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <4574BF70.8070100@lilypond.org> <45760545.2010801@gmail.com>
 <20061206.105251.144349770.wl@gnu.org>
 <Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <4576D92A.80307@xs4all.nl> <20061206145802.GC1714@fieldses.org>
 <Pine.LNX.4.63.0612061613460.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061206171950.GD1714@fieldses.org> <20061206172450.GE1714@fieldses.org>
 <7v7ix47wbr.fsf@assigned-by-dhcp.cox.net> <20061207041805.GC3457@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 7 Dec 2006 14:28:42 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061207041805.GC3457@fieldses.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33580>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsKEp-0006Rq-Jn for gcvg-git@gmane.org; Thu, 07 Dec
 2006 15:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937956AbWLGO2i (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 09:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936939AbWLGO2i
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 09:28:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:36504 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S937957AbWLGO2g
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 09:28:36 -0500
Received: (qmail invoked by alias); 07 Dec 2006 14:28:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp030) with SMTP; 07 Dec 2006 15:28:34 +0100
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, J. Bruce Fields wrote:

> Modify cvs-migration.txt so it explains first how to develop against a 
> shared repository, then how to set up a shared repository, then how to 
> import a repository from cvs.  Though this seems chronologically 
> backwards, it's still readable in this order, and it puts the more 
> commonly needed material closer to the front.

This is a laudable goal, and the order makes sense (put first that what 
most people are interested in).

A few comments:

- just skimming the patch, I found "commiting" (needs another "t"), and 
  "-bare" (needs another "-").

- It might make more sense to "git init-db --shared" and fetch the initial 
  revision into it, rather than clone it and then fix. You might also want
  to mention that the "--shared" of -clone is different in meaning from 
  that of -init-db (make just a footnote of it, to avoid intimidating 
  readers).

- By far the easiest method to import from cvs is to go to a checked out
  _CVS_ working directory, and just say "git cvsimport".

Ciao,
Dscho
