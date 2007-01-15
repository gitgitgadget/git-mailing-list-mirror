From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-remote exclude
Date: Mon, 15 Jan 2007 11:23:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701151118400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45AA44D6.6080605@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 20:18:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6W2O-0000RJ-7S
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:54:28 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9a-0003eK-Gv
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbXAOKXS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 05:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbXAOKXR
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 05:23:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:39244 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932192AbXAOKXR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 05:23:17 -0500
Received: (qmail invoked by alias); 15 Jan 2007 10:23:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 15 Jan 2007 11:23:15 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Quy Tonthat <qtonthat@gmail.com>
In-Reply-To: <45AA44D6.6080605@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36869>

Hi,

On Mon, 15 Jan 2007, Quy Tonthat wrote:

> "git-remote exclude" can be used to prevent one or more unwanted remote 
> branches from being tracked. After, for example,
>     $ git-remote origin exclude man html
> "git-fetch origin" will no longer fetch origin/man and origin/html.

That is not what your patch does.

It rewrites the "remote.$name.fetch" entries so that those branches are 
not _updated_, but they are _fetched_ nevertheless.

But then, I don't really see _why_ you would want such a solution. After 
all, you are more likely to be interested in _specific_ branches, rather 
than all branches _except_ a few.

IMHO "git remote expand <name>" to expand the wildcards and "git remote 
copy <dest> <src>" would be more useful.

Ciao,
Dscho
