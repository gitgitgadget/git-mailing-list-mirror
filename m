X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] git-reset to remove "$GIT_DIR/MERGE_MSG"
Date: Tue, 5 Dec 2006 10:03:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612051000280.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v4psbknvb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612050847340.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <45752F8E.9020405@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 09:04:03 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	ltuikov@yahoo.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45752F8E.9020405@op5.se>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33322>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrWDW-0006c8-A1 for gcvg-git@gmane.org; Tue, 05 Dec
 2006 10:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968122AbWLEJDz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 04:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968123AbWLEJDz
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 04:03:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:37610 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S968122AbWLEJDy
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 04:03:54 -0500
Received: (qmail invoked by alias); 05 Dec 2006 09:03:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp010) with SMTP; 05 Dec 2006 10:03:52 +0100
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 5 Dec 2006, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> > 
> > The only possible exception I can think of: git-reset --mixed when a merge
> > failed.
> 
> Indeed, but any invocation of git-reset means you'll quite likely have 
> to re-do the merge to get all changes anyways.

But the working directory still contains the changes (and conflicts) with 
--mixed. A valid workflow would then be to compare to the index directly, 
instead of having to ask "git diff --ours" all the time. And if I'm not 
mistaken, a commit (after cleaning up the conflicts) would not record the 
merge as a merge.

Ciao,
Dscho
