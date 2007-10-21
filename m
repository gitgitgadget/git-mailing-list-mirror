From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] "git help -a" should search all exec_paths and PATH
Date: Sun, 21 Oct 2007 23:25:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710212323580.25221@racer.site>
References: <20071021214846.GI16291@srparish.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 00:26:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjjFD-0008Im-Rz
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 00:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbXJUWZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 18:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbXJUWZt
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 18:25:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:46350 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750866AbXJUWZt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 18:25:49 -0400
Received: (qmail invoked by alias); 21 Oct 2007 22:25:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 22 Oct 2007 00:25:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+XCw15BieXW0j1xfIiY6J/ELrcTw1A2RMH2aWL+C
	XU5AyYlGV5kZ7Q
X-X-Sender: gene099@racer.site
In-Reply-To: <20071021214846.GI16291@srparish.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61918>

Hi,

On Sun, 21 Oct 2007, Scott R Parish wrote:

> Currently "git help -a" only searches in the highest priority exec_path, 
> meaning at worst, nothing is listed if the git commands are only 
> available from the PATH. It also makes git slightly less extensible.
> 
> To fix this, help.c is modified to search in all the exec_paths and PATH
> for potential git commands.

With this explanation, I would have expected that you add a loop just like 
in exec-cmd.c.  Not anything more.  And certainly not the removal of a 
sanity check for the length of the path name.

Ciao,
Dscho
