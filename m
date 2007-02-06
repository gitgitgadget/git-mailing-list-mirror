From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port now supports native git protocol
Date: Tue, 6 Feb 2007 15:56:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702061554160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45C6F2F6.ADFE0A13@eudaptics.com> <45C893C7.6050001@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Feb 06 15:56:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HERjz-0007gp-DA
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 15:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbXBFO4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 09:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752239AbXBFO4H
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 09:56:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:49904 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752234AbXBFO4G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 09:56:06 -0500
Received: (qmail invoked by alias); 06 Feb 2007 14:56:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 06 Feb 2007 15:56:04 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45C893C7.6050001@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38846>

Hi,

On Tue, 6 Feb 2007, Han-Wen Nienhuys wrote:

> git-compat-util.h:39:21: error: fnmatch.h: No such file or directory
> git-compat-util.h:48:19: error: netdb.h: No such file or directory
> git-compat-util.h:49:17: error: pwd.h: No such file or directory
> git-compat-util.h:52:17: error: grp.h: No such file or directory
> git-compat-util.h:105:22: error: sys/mman.h: No such file or directory
> 
> [snip]
> 
> where are these headers supposed to come from?

>From git's compat/ directory.

As I see you also include sys/mman.h, I'd say that uname_S is probably not 
correctly set. ;-)

Yes, you found -- again -- that git is not easily cross-compilable.

Ciao,
Dscho
