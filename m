From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-rebase--interactive needs a better message
Date: Mon, 24 Sep 2007 00:56:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709240055150.28395@racer.site>
References: <20070923224502.GB7249@potapov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 01:57:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZbKL-00076k-I5
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 01:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201AbXIWX5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 19:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755052AbXIWX5Y
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 19:57:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:58425 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754711AbXIWX5X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 19:57:23 -0400
Received: (qmail invoked by alias); 23 Sep 2007 23:57:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 24 Sep 2007 01:57:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Tap5CKUaT7nUuA3/GYCbgxXpYTY/+t2p05WZ9JA
	WQ56rL5mx10XjE
X-X-Sender: gene099@racer.site
In-Reply-To: <20070923224502.GB7249@potapov>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59006>

Ho.

On Mon, 24 Sep 2007, Dmitry Potapov wrote:

> I have tried to use git-rebase --interactive today, and run into a strange
> error message saying:
> 
> /usr/bin/git-rebase--interactive: line 333: $GIT_DIR/.dotest-merge/author-script: No such file or directory
> 
> I had to scratch my head for a while before I realized that I forgot to
> say git-commit. So, it was mine mistake, but I think that it should be
> possible to have a better error message suggesting the user what to do.

Actually, it should just work, I'd say.  IOW git-rebase--interactive 
should store an author script also for "edit"s.

Ciao,
Dscho
