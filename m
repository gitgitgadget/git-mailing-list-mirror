From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] rebase -i: commit when continuing after "edit"
Date: Mon, 24 Sep 2007 13:11:57 +0400
Message-ID: <20070924091157.GA25435@potapov>
References: <20070923224502.GB7249@potapov> <Pine.LNX.4.64.0709240121080.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 24 11:12:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZjzk-0005iP-M6
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 11:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbXIXJMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 05:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbXIXJMF
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 05:12:05 -0400
Received: from smtp06.mtu.ru ([62.5.255.53]:61955 "EHLO smtp06.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbXIXJME (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 05:12:04 -0400
Received: from potapov.private (ppp85-140-171-48.pppoe.mtu-net.ru [85.140.171.48])
	by smtp06.mtu.ru (Postfix) with ESMTP id 1F71D7BED63;
	Mon, 24 Sep 2007 13:12:01 +0400 (MSD)
Received: from potapov.private (localhost [127.0.0.1])
	by potapov.private (8.13.8/8.13.8/Debian-3) with ESMTP id l8O9BvWS025491;
	Mon, 24 Sep 2007 13:11:57 +0400
Received: (from dpotapov@localhost)
	by potapov.private (8.13.8/8.13.8/Submit) id l8O9Bv02025490;
	Mon, 24 Sep 2007 13:11:57 +0400
X-Authentication-Warning: potapov.private: dpotapov set sender to dpotapov@gmail.com using -f
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709240121080.28395@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59031>

On Mon, Sep 24, 2007 at 01:29:30AM +0100, Johannes Schindelin wrote:
> 	On Mon, 24 Sep 2007, Dmitry Potapov wrote:
> 
> 	> I have tried to use git-rebase --interactive today, and run into 
> 	> a strange error message saying:
> 	> 
> 	> /usr/bin/git-rebase--interactive: \
> 	>	line 333: $GIT_DIR/.dotest-merge/author-script: \
> 	>		No such file or directory
> 
> 	Could you please apply this patch and try if the issue is gone?

I have tested it only on a couple cases, but everything works fine now.

Thank you,
Dmitry
