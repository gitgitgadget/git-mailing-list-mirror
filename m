From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] When exec'ing sub-commands,      fall back on execvp
 (thePATH)
Date: Sat, 20 Oct 2007 21:25:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710202124050.25221@racer.site>
References: <1192867937.v2.fusewebmail-240137@f>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Sun Oct 21 03:52:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjPze-0001Gf-Ra
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 03:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbXJUBwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 21:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbXJUBwW
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 21:52:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:40177 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752076AbXJUBwV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 21:52:21 -0400
Received: (qmail invoked by alias); 20 Oct 2007 20:25:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 20 Oct 2007 22:25:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JguRA1MUJwsqsAOQH1I+gFrjfyA1fsgkvqkGYZt
	Z6F8kE/rywLXte
X-X-Sender: gene099@racer.site
In-Reply-To: <1192867937.v2.fusewebmail-240137@f>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61858>

Hi,

[please do not top post. Just delete everything you do not reply to, and 
put your answers below the text you are replying to.  This spares others 
so much time.]

On Sat, 20 Oct 2007, Scott R Parish wrote:

> The theoretical drawback to this approach is that it could possibly 
> effect the order in which the paths are tried. For instance, if a user 
> did "export GIT_EXEC_PATH=", then the builtin_exec_path wouldn't be 
> tried before the PATH. (i doubt that it would be a problem, but thought 
> i should note it)

In that respect, my code does not change anything from your code.

Ciao,
Dscho
