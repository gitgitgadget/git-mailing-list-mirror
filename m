X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git (stable)
Date: Sat, 16 Dec 2006 00:22:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612160020590.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612140959.19209.andyparkins@gmail.com>
 <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net> <200612141136.59041.andyparkins@gmail.com>
 <eluemi$gc0$1@sea.gmane.org> <Pine.LNX.4.64.0612151029080.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 15 Dec 2006 23:22:53 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0612151029080.18171@xanadu.home>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34573>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvMO2-0000y8-W5 for gcvg-git@gmane.org; Sat, 16 Dec
 2006 00:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030367AbWLOXWd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 18:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbWLOXWd
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 18:22:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:57357 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1030367AbWLOXWc
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 18:22:32 -0500
Received: (qmail invoked by alias); 15 Dec 2006 23:22:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp039) with SMTP; 16 Dec 2006 00:22:30 +0100
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Hi,

On Fri, 15 Dec 2006, Nicolas Pitre wrote:

> On Fri, 15 Dec 2006, Jakub Narebski wrote:
> 
> > It would be nice to have some generic place in git config to specify
> > default options to git commands (at least for interactive shell). It
> > cannot be done using aliases. Perhaps defaults.<command> config variable?
> 
> I would say the alias facility has to be fixed then.
> 
> In bash you can alias "ls" to "ls -l" and it just works.

So, why not use bash aliases?

Frankly, what git aliases try to achieve is a little bit different from 
bash aliases. Bash knows exactly when a command is interactive, and has a 
clear advantage there. Git _cannot_ know.

Ciao,
Dscho
