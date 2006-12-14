X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 12:27:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141224330.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612141021.12637.andyparkins@gmail.com>
 <Pine.LNX.4.63.0612141147200.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612141123.02346.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 11:27:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612141123.02346.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34318>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guokf-0005O3-JS for gcvg-git@gmane.org; Thu, 14 Dec
 2006 12:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932620AbWLNL1q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 06:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbWLNL1q
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 06:27:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:53464 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932620AbWLNL1p
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 06:27:45 -0500
Received: (qmail invoked by alias); 14 Dec 2006 11:27:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp041) with SMTP; 14 Dec 2006 12:27:44 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Andy Parkins wrote:

> On Thursday 2006 December 14 10:51, Johannes Schindelin wrote:
> 
> > If I have the choice between a "doing something" bar and a Windows
> > Explorer "14 seconds left" bar showing the same message for two minutes,
> > I'd rather have a Mars bar ;-)
> 
> Gahhhhhhhhh!  Oh how I hate that window.
> 
> On this we can wholeheartedly agree.  Unfortunately it's not just windows; 
> most applications that have a progress bar go like this:
> 
> 0%, ..., 0%,..., 0%,.., 1 , 2, 3, 4, 5, 6, 33%, ..., 33%, ..., 33%, 35, 36, 
> 85%, ..., 85%, ..., 85%, ..., 99%, 100%, ..., 100%, ... (yes, I'm completely 
> finished, but still working), ... 100%.
> 
> I reckon, unless the window with a progress bar in it has an ETA, then the 
> progress should be an ETA itself.  If it's not going to monotonically 
> increase, then the "percentage" is meaningless.

And now you know one of the reasons we have no true progress bar.

Another reason is that it would be relatively expensive to calculate, 
since the total _size_ is not known beforehand (remember, the pack is 
calculated on the fly).

Yet another reason is that all estimates there are unstable by nature: the 
load of the server, the net load, the load of the client, the speed of 
packing and unpacking, and the luck if deltas can be reused, are all 
contributors to this unstability.

Ciao,
Dscho
