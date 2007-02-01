From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: .git/info/refs
Date: Thu, 1 Feb 2007 18:32:34 +0100
Message-ID: <20070201173234.GA29170@moooo.ath.cx>
References: <7vireuaj9d.fsf@assigned-by-dhcp.cox.net> <45B92332.5060206@zytor.com> <7v3b5yai6c.fsf@assigned-by-dhcp.cox.net> <45B928AD.50508@zytor.com> <Pine.LNX.4.63.0701260029580.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45BBCD27.5050408@zytor.com> <Pine.LNX.4.63.0702011501250.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45C2124C.5070308@zytor.com> <Pine.LNX.4.63.0702011749100.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45C21BA0.4080700@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 18:32:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCfnd-0006ju-SK
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 18:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbXBARcj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 12:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161207AbXBARcj
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 12:32:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:43983 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161193AbXBARci (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 12:32:38 -0500
Received: (qmail invoked by alias); 01 Feb 2007 17:32:37 -0000
Received: from pD9EB9AC1.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.154.193]
  by mail.gmx.net (mp047) with SMTP; 01 Feb 2007 18:32:37 +0100
X-Authenticated: #5358227
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <45C21BA0.4080700@zytor.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38378>

H. Peter Anvin <hpa@zytor.com> wrote:
> Yes, it does matter, because it drives the load up further.  If you 
> start having this going on in overlapping instances, then you're soon on 
> the downhill slope of a cascading failure.
Add some other locking mechanism.

> And we have already experimented with it.  It unfortunately doesn't help 
> much, it only makes matters worse.
The gitweb overview page has less than one hit per minute?  Otherwise
this should help.
