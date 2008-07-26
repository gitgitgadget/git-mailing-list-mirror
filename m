From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/7] builtin-help: change the current directory back in
 list_commands_in_dir()
Date: Sat, 26 Jul 2008 16:58:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807261657150.26810@eeepc-johanness>
References: <cover.1217037178.git.vmiklos@frugalware.org> <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org> <1217073292-27945-1-git-send-email-vmiklos@frugalware.org>
 <4f2b03391e3f85cf2224f97a2a7765d08707bd73.1217037178.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jul 26 16:58:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMlDe-0007t6-5Q
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 16:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbYGZO5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 10:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbYGZO5B
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 10:57:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:37966 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751886AbYGZO5A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 10:57:00 -0400
Received: (qmail invoked by alias); 26 Jul 2008 14:56:58 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp047) with SMTP; 26 Jul 2008 16:56:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19FMAUD4Z9FHEWVHmx02ees3TfcfR5MSiXTDJgj3X
	9ynPQ2zEZo9Xtu
X-X-Sender: user@eeepc-johanness
In-Reply-To: <4f2b03391e3f85cf2224f97a2a7765d08707bd73.1217037178.git.vmiklos@frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90233>

Hi,

On Sat, 26 Jul 2008, Miklos Vajna wrote:

> That function used to do a chdir() without switching back to the 
> original directory. That was not a problem till this function was used 
> only inside builtin-help, but once other builtins use it as well, this 
> is a problem, for example when the object database path is relative.

I had to work around that in my patch "git wrapper: DWIM mistyped 
commands", too :-)

Ciao,
Dscho
