X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git UI nit
Date: Wed, 6 Dec 2006 16:20:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612061619120.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <el6jmt$mej$1@sea.gmane.org>
 <Pine.LNX.4.63.0612061546190.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <4576DD27.6050307@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 15:21:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <4576DD27.6050307@xs4all.nl>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33471>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GryZr-0001iu-EV for gcvg-git@gmane.org; Wed, 06 Dec
 2006 16:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935728AbWLFPUt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 10:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935732AbWLFPUt
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 10:20:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:42508 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S935753AbWLFPUs
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 10:20:48 -0500
Received: (qmail invoked by alias); 06 Dec 2006 15:20:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp037) with SMTP; 06 Dec 2006 16:20:47 +0100
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Han-Wen Nienhuys wrote:

> Johannes Schindelin escreveu:
> >  			}
> >  			if (quiet)
> >  				continue;
> > -			printf("%s: needs update\n", ce->name);
> > +			printf("%s: dirty; needs commit\n", ce->name);
> 
> Yes - I'd just mention revert as an option too. 

Actually, I like it that short.

We had an email on this list, where the poster said he could not merge 
with Git. It turned out that the merge failed with conflicts, but he 
did not bother reading through the messages, apparently because they were 
too many.

Ciao,
Dscho
