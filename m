From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-reset <tree> -- <path> restores absense of <path>
 in <tree>
Date: Fri, 5 Jan 2007 11:29:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701051128120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vmz4xiz6t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 11:29:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2mKI-0005v1-Ar
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 11:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbXAEK31 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 05:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbXAEK31
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 05:29:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:38763 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161041AbXAEK30 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 05:29:26 -0500
Received: (qmail invoked by alias); 05 Jan 2007 10:29:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 05 Jan 2007 11:29:24 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmz4xiz6t.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35989>

Hi,

On Fri, 5 Jan 2007, Junio C Hamano wrote:

>  * By the way, I noticed that "git log --diff-filter=A --
>    t/t5401-update-hooks.sh" does not find the commit that
>    introduced the path.  v1.4.1.1 seems to work but v1.4.2.4
>    does not.  I haven't bisected it yet...

It is this commit:

1798562: "log --raw: Don't descend into subdirectories by default"

And sure enough,

$ git log next -r --diff-filter=A -- t/t5401-update-hooks.sh

works.

Ciao,
Dscho
