From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix renaming branch without config file
Date: Thu, 5 Apr 2007 19:51:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0704051951170.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070405144359.4B8832A7C67@potomac.gnat.com>
 <Pine.LNX.4.63.0704051728400.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <B0C79D8E-07A8-4178-B0A6-698EB2BB5A2A@gnat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Geert Bosch <bosch@gnat.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 19:52:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZW7v-0004GH-Q7
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 19:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767035AbXDERwA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 13:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767143AbXDERwA
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 13:52:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:48590 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1767035AbXDERv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 13:51:59 -0400
Received: (qmail invoked by alias); 05 Apr 2007 17:51:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 05 Apr 2007 19:51:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bHRxdtb7bwfMG61blIaiie8JmusWJ5sZbh+vVnx
	GJRbHYFEofgMeM
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <B0C79D8E-07A8-4178-B0A6-698EB2BB5A2A@gnat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43847>

Hi,

On Thu, 5 Apr 2007, Geert Bosch wrote:

> 
> On Apr 5, 2007, at 11:30, Johannes Schindelin wrote:
> > I don't think this is correct. git_config_rename_section() _should_ return
> > an error.
> > 
> > > Otherwise, renaming a branch would abort, leaving the repository in an
> > > inconsistent state.
> > 
> > This should take the hint from --rename-section, and print a warning (or
> > not).
> 
> Looking at the code, I deduced that git_config_rename_section()
> returns a positive count of sections renamed, 0 if no matching
> section exists and negative for another error condition.

Ah, yes. You are completely right!

> The proposed patch makes the behavior of an absent config file the same 
> as the behavior of an empty one, which seems sane to me. There should be 
> no warning, as it is perfectly fine to have no config file. Could you 
> elaborate on why you believe my patch is not correct?

I elaborate by taking my objections back. Fair enough?

Ciao,
Dscho
