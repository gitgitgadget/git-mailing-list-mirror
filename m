X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-diff: don't add trailing blanks (i.e., do what GNU
 diff -u now does)
Date: Mon, 18 Dec 2006 13:06:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612181305500.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87y7p6nwsh.fsf@rho.meyering.net> <Pine.LNX.4.64.0612171200290.3479@woody.osdl.org>
 <7vtzzu5lp1.fsf@assigned-by-dhcp.cox.net> <em4all$b2c$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 19 Dec 2006 00:17:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <em4all$b2c$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34774>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwHGN-0002sw-9l for gcvg-git@gmane.org; Mon, 18 Dec
 2006 13:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753902AbWLRMGM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 07:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753904AbWLRMGL
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 07:06:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:49012 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1753902AbWLRMGK
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006 07:06:10 -0500
Received: (qmail invoked by alias); 18 Dec 2006 12:06:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp029) with SMTP; 18 Dec 2006 13:06:09 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Sun, 17 Dec 2006, Jakub Narebski wrote:

> Junio C Hamano wrote:
> 
> > Linus Torvalds <torvalds@osdl.org> writes:
> > 
> >> On Sun, 17 Dec 2006, Jim Meyering wrote:
> >>>
> >>> You may recall that GNU diff -u changed recently so that it no
> >>> longer outputs any trailing space unless the input data has it.
> >>
> >> I still consider that to be a bug in GNU "diff -u".
> >>
> >> We work around that bug when applying patches, but I don't think we should 
> >> replicate it.
> > 
> > Me neither.
> 
> Perhaps with --gnu-diff-compatibility then? 

Rather --braindead-gnu-bug-compatibility.

Ciao,
Dscho
