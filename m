From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH] don't set-group-id on directories on apple
Date: Mon, 22 Oct 2007 07:29:45 -0700
Message-ID: <20071022142945.GO16291@srparish.net>
References: <20071022075459.GA1157@srparish.net> <Pine.LNX.4.64.0710221234070.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 16:30:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjyI5-0003sT-NC
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 16:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbXJVO3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 10:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbXJVO3t
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 10:29:49 -0400
Received: from smtp-gw8.mailanyone.net ([208.70.128.73]:34692 "EHLO
	smtp-gw8.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbXJVO3s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 10:29:48 -0400
Received: from mailanyone.net
	by smtp-gw8.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1IjyHq-00066N-F8; Mon, 22 Oct 2007 09:29:47 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Mon, 22 Oct 2007 07:29:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710221234070.25221@racer.site>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62013>

On Mon, Oct 22, 2007 at 03:16:01PM +0100, Johannes Schindelin wrote:

> On Mon, 22 Oct 2007, Scott R Parish wrote:
> 
> > "git init --shared=all" was failing because chmod was returning
> > EPERM.
> 
> Not here.  This is git version 1.5.3.rc4.1716.gc3498, and "uname -a" says
> 
> Darwin michael-stirrats-mac-mini.local 8.10.0 Darwin Kernel Version 
> 8.10.0: Wed May 23 16:50:59 PDT 2007; root:xnu-792.21.3~1/RELEASE_PPC 
> Power Macintosh powerpc

Darwin poplar.local 8.10.1 Darwin Kernel Version 8.10.1: Wed May 23 16:33:00 PDT 2007; root:xnu-792.22.5~1/RELEASE_I386 i386 i386

> Is it possible that you have stricter permission settings?

This is a possibility, but i have no idea what that might be. I've
tried googling around without any luck (except for a post about
reading "mkdir(2)").

> Or that you try to re-initialise a repository that somebody else
> initialised originally?

No, this was a failure when running tests (t1301-shared-repo.sh)

sRp

-- 
Scott Parish
http://srparish.net/
