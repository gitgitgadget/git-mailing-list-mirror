X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] hooks/pre-commit: add example to add Signed-off-by line
 to message
Date: Wed, 20 Dec 2006 18:37:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612201835570.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0611291219190.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612201604.12498.andyparkins@gmail.com>
 <Pine.LNX.4.63.0612201717490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz5ifpbv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 17:38:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vmz5ifpbv.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34951>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx5OO-0000jU-Di for gcvg-git@gmane.org; Wed, 20 Dec
 2006 18:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030217AbWLTRht (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 12:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWLTRht
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 12:37:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:34071 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1030221AbWLTRhs
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 12:37:48 -0500
Received: (qmail invoked by alias); 20 Dec 2006 17:37:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp048) with SMTP; 20 Dec 2006 18:37:46 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 20 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi,
> >
> > On Wed, 20 Dec 2006, Andy Parkins wrote:
> >
> >> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> >
> > Acked-by: Johannes E. Schindelin <johannes.schindelin@gmx.de>
> >
> > Ciao,
> > Dscho
> 
> Why SQUASH_MSG?  Doesn't it confuse git-explain when it wants to
> detect that you are in the middle of a squash merge?

Yes, it confuses git-explain. Which did not existed when I concocted the 
first (broken) version of this patch. There are only two ways to give 
commit message templates AFAICT: misusing SQUASH_MSG and misusing 
MERGE_MSG.

Ciao,
Dscho
