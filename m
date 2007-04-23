From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t4201-shortlog.sh does bad things to my terminal
Date: Mon, 23 Apr 2007 19:29:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704231928270.8822@racer.site>
References: <20070423170301.GL955MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sven Verdoolaege <skimo@kotnet.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 19:30:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg2MY-0001Ru-HS
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 19:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161034AbXDWRaB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 13:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754092AbXDWRaB
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 13:30:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:57190 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754076AbXDWRaA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 13:30:00 -0400
Received: (qmail invoked by alias); 23 Apr 2007 17:29:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 23 Apr 2007 19:29:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18f34UCIq0fh444ubw4kFRgQrfmWjnalK7kTvnP+a
	4qZv8LhYWel+Pb
X-X-Sender: gene099@racer.site
In-Reply-To: <20070423170301.GL955MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45342>

Hi,

On Mon, 23 Apr 2007, Sven Verdoolaege wrote:

> It appears that this message is printing a control character to turn off 
> echoing, because the terminal appears completely unresponsive 
> afterwards. Typing "reset" restores the terminal.
> 
> Is this really necessary?

On both accounts, no. I did not dream of these bytes being interpreted as 
control characters.

OTOH, you should not need to use --verbose anyway.

Ciao,
Dscho
