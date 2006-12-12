X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow building GIT in a different directory from the
 source directory
Date: Tue, 12 Dec 2006 19:55:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612121951000.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <eljo2u$pnq$2@sea.gmane.org> <7vbqm9xz8z.fsf@assigned-by-dhcp.cox.net>
 <457E979F.9060307@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 18:55:57 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <457E979F.9060307@xs4all.nl>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34126>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuCmy-000537-Dm for gcvg-git@gmane.org; Tue, 12 Dec
 2006 19:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932344AbWLLSz0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 13:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWLLSz0
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 13:55:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:37755 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932342AbWLLSzR
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 13:55:17 -0500
Received: (qmail invoked by alias); 12 Dec 2006 18:55:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp049) with SMTP; 12 Dec 2006 19:55:08 +0100
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, Han-Wen Nienhuys wrote:

> I still don't understand the problem with autoconf; there are already 
> plenty of baroque shell scripts in GIT.  I hate writing m4 macros as 
> well, but that's not a problem for GIT users (ie. people who compile 
> GIT).

That, together with the complexity of GIT_EXEC_DIR and path mangling 
problems, makes me take every opportunity to suggest we should build in 
most if not all of Git into the "git wrapper".

Granted, without completion scripts, the "git-" convention was nice.

Granted, with bash, Perl and even Python, you can rapidly prototype your 
thoughts (even if I often miss the power of C there).

But in the end, I'd say it makes lots of sense to have everything in one 
executable.

Ciao,
Dscho
