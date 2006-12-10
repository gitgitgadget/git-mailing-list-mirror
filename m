X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] add test case for recursive merge
Date: Sun, 10 Dec 2006 23:51:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612102350050.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061207101707.GA19139@spearce.org>
 <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 10 Dec 2006 23:08:26 +0000 (UTC)
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33955>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtXmP-00062y-RM for gcvg-git@gmane.org; Mon, 11 Dec
 2006 00:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759147AbWLJXIS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 18:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762254AbWLJXIS
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 18:08:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:38257 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1759147AbWLJXIS
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 18:08:18 -0500
Received: (qmail invoked by alias); 10 Dec 2006 22:51:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp031) with SMTP; 10 Dec 2006 23:51:38 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Sat, 9 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > this test succeeds consistently on the machine where I tested it 
> > originally, but fails on another of my machines, but only when run without 
> > "-v". Very annoying. I will not have time to investigate until Monday, 
> > though.
> 
> There seem to be cases where stage #1 contains blob 'B' or 'A'
> or nothing depending on something totally random.  Ring a bell?

Not at all.

It seems that one merge is conflicting on "a1", and not storing _anything_ 
in the resulting (unclean) tree. So, there is no stage 1.

However, I also saw that something is left in stage 1 on the box where the 
problem arises. Tomorrow.

Ciao,
Dscho
