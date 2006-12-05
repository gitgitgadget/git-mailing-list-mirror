X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] git-reset to remove "$GIT_DIR/MERGE_MSG"
Date: Tue, 5 Dec 2006 09:22:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612050847340.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v4psbknvb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 08:22:25 +0000 (UTC)
Cc: git@vger.kernel.org, ltuikov@yahoo.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v4psbknvb.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33315>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrVZG-0001ss-2t for gcvg-git@gmane.org; Tue, 05 Dec
 2006 09:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937382AbWLEIWT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 03:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937481AbWLEIWT
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 03:22:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:53117 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S937382AbWLEIWS
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 03:22:18 -0500
Received: (qmail invoked by alias); 05 Dec 2006 08:22:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp029) with SMTP; 05 Dec 2006 09:22:16 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 4 Dec 2006, Junio C Hamano wrote:

>  * Marked as RFC because I suspect I am missing a valid use case
>    where a user might want to say "reset" as part of continuing
>    the conflicted merge resolution, although I do not think of
>    any offhand...

I can only speak for myself, of course: When I use git-reset in a merge, 
more often than not I use "--hard", in which case I want to try something 
different. So yes, I like this patch.

The only possible exception I can think of: git-reset --mixed when a 
merge failed.

Ciao,
Dscho
