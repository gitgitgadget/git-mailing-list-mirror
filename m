From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add commands that git-gc runs underneath
Date: Thu, 30 Aug 2007 12:58:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708301254420.28586@racer.site>
References: <lkbtwek0.fsf@cante.net> <Pine.LNX.4.64.0708301107320.28586@racer.site>
 <46D6984D.9040802@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Aug 30 13:58:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQif7-0000wX-Nj
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 13:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755848AbXH3L6I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 07:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755670AbXH3L6H
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 07:58:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:44781 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754819AbXH3L6G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 07:58:06 -0400
Received: (qmail invoked by alias); 30 Aug 2007 11:58:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 30 Aug 2007 13:58:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19AdvVQG/hAuheKUPRqEVcsqaIHt68gWP8exzypDX
	PyFGwpt3DVoO7k
X-X-Sender: gene099@racer.site
In-Reply-To: <46D6984D.9040802@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57028>

Hi,

On Thu, 30 Aug 2007, Andreas Ericsson wrote:

> I kinda like it [listing the commands git-gc calls], and it might be 
> helpful if someone's got a large repo and one part of gc for some reason 
> didn't complete so they want to start at whatever step it broke off on.

Let me clarify: I do not like the listing in the man page.  This suggests 
to the user to delve into plumbing areas where it is all too easy to shoot 
yourself in the foot.

I have nothing against listing the commands per se.  But the man page is 
too exposed IMHO.  (Or would you like to add the original shell script to 
git-log's man page, too?)

My preferred location would be somewhere near Documentation/technical/, so 
that people reading the commands are more likely to understand the 
consequences.

But maybe I'm wrong.

Ciao,
Dscho
