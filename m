X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] git-fetch: do not use "*" for fetching multiple refs
Date: Thu, 7 Dec 2006 00:21:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612070020580.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1165261102.20055.9.camel@ibook.zvpunry.de> <el1tud$n07$2@sea.gmane.org>
 <1165422865.29714.13.camel@ibook.zvpunry.de> <el6sni$re3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 23:22:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <el6sni$re3$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33533>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs65X-0002iP-0r for gcvg-git@gmane.org; Thu, 07 Dec
 2006 00:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937778AbWLFXWD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 18:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937779AbWLFXWD
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 18:22:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:48075 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S937778AbWLFXWB
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 18:22:01 -0500
Received: (qmail invoked by alias); 06 Dec 2006 23:21:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp038) with SMTP; 07 Dec 2006 00:21:58 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Jakub Narebski wrote:

> Michael Loeffler wrote:
> 
> > Am Montag, den 04.12.2006, 20:48 +0100 schrieb Jakub Narebski:
> > ...
> >> I'm not sure if regexp support is truly better than the usual path globbing,
> >> as in fnmatch / glob.
> >
> > The current code does not do a real glob, this was the reason for me to
> > think about regex support, I thought it is easy to use sed for this. Now
> > I know it better.
> 
> We could use perl for that, but embedded perl is a bit horrible.

Not to talk about portable, and as we saw, dependent on the C compiler 
(you would have to make git compile with the same C compiler that perl was 
compiled with).

So, please look into other options first.

Ciao,
