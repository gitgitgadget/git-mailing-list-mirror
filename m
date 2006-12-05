X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: Moving a directory into another fails
Date: Tue, 5 Dec 2006 08:34:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612050831550.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com>
 <20060726223459.GA30601@vsectoor.geht-ab-wie-schnitzel.de>
 <9e4733910607261603m6772602cr333d8c58f555edaa@mail.gmail.com>
 <20060728014350.GI13776@pasky.or.cz> <f3d7535d0612041019q4bda01a1k9938b056d51f8a78@mail.gmail.com>
 <el1qtr$bca$1@sea.gmane.org> <Pine.LNX.4.63.0612042001320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <el1rmm$bca$2@sea.gmane.org> <Pine.LNX.4.63.0612042009590.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612041114240.3476@woody.osdl.org>
 <Pine.LNX.4.63.0612042201420.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612041317480.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 07:34:55 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0612041317480.3476@woody.osdl.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33312>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrUpH-0005Yz-AG for gcvg-git@gmane.org; Tue, 05 Dec
 2006 08:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937468AbWLEHei (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 02:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937469AbWLEHei
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 02:34:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:40871 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S967470AbWLEHef
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 02:34:35 -0500
Received: (qmail invoked by alias); 05 Dec 2006 07:34:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp020) with SMTP; 05 Dec 2006 08:34:33 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 4 Dec 2006, Linus Torvalds wrote:

> 	[core]
> 		escapefilenames = true

I think this goes too far. The problem _only_ showed up with a made-up 
test case for gitweb. Let's bite the apple when we _have_ to (which I 
doubt will happen, because for the most part, developers understand that 
spaces and umlauts have _no_ place in filenames, basically since UNIX was 
invented by stupid US Americans who did not know anything about nice 
filenames, let alone other languages than English and C).

Ciao,
Dscho
