X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] "init-db" can really be just "init"
Date: Tue, 28 Nov 2006 00:36:15 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611280034010.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
 <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 27 Nov 2006 23:36:34 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32461>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goq1N-0000WR-FO for gcvg-git@gmane.org; Tue, 28 Nov
 2006 00:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758614AbWK0XgS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 18:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758616AbWK0XgS
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 18:36:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:34270 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758614AbWK0XgR (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 18:36:17 -0500
Received: (qmail invoked by alias); 27 Nov 2006 23:36:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp030) with SMTP; 28 Nov 2006 00:36:15 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 27 Nov 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Maybe that could be a good rule of thumb to have all porcelainish 
> > commands not have any hyphen in their name, like "diff", "commit", 
> > "add", etc. ?
> 
> I was also hoping that would become the case except verify-tag,
> cherry-pick, and format-patch.

I agree it might make a good rule-of-thumb, but let's not be overzealous. 
I have yet to see any better names for those three either, let alone 
better names without a hyphen.

> Also I was wondering if it would make sense to give two dashes to the 
> back-end ones that never get invoked by the end users directly (e.g. 
> merge--recursive, upload--pack) but thought it was too ugly.

I think it would appeal mostly to our friends, the monotone users...

Ciao,
Dscho
