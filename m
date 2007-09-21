From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Added a new placeholder '%cm' for full commit message
Date: Fri, 21 Sep 2007 11:47:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709211146090.28395@racer.site>
References: <20070921101420.GD22869@mageo.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michal Vitecek <fuf@mageo.cz>
X-From: git-owner@vger.kernel.org Fri Sep 21 12:48:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYg3l-00005w-77
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 12:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbXIUKsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 06:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753420AbXIUKsQ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 06:48:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:51018 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755285AbXIUKsP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 06:48:15 -0400
Received: (qmail invoked by alias); 21 Sep 2007 10:48:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 21 Sep 2007 12:48:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+IBvIfpRKIjlL09TKyR1OzJXNRt2To1VeiKXsKRT
	WO3FfzAwsU2fKo
X-X-Sender: gene099@racer.site
In-Reply-To: <20070921101420.GD22869@mageo.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58841>

Hi,

On Fri, 21 Sep 2007, Michal Vitecek wrote:

> I have added a new placeholder '%cm' for a full commit message.

You mean the raw message, including the headers?  Why not use "%r" for 
that?

> I made it because I want to use my own pretty format which currently 
> only allows '%s' for subject and '%b' for body. But '%b' is substituted 
> with <undefined> if the body is "missing" which I obviously don't like 
> :)

Then you should fix %b not to show "<undefined>".

And please adher to the tips in Documentation/SubmittingPatches.

Thank you,
Dscho
