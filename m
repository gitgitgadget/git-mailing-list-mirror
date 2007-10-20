From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH] allow git to use the PATH for finding subcommands and
	help docs
Date: Fri, 19 Oct 2007 23:42:40 -0700
Message-ID: <20071020064235.GA2237@srparish.net>
References: <20071019065931.GB1463@srparish.net> <47185DAF.7060809@viscovery.net> <20071019130402.GD1463@srparish.net> <Pine.LNX.4.64.0710191616490.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 20 08:43:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij833-0008CJ-8A
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 08:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753829AbXJTGmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 02:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756892AbXJTGmt
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 02:42:49 -0400
Received: from smtp-gw51.mailanyone.net ([208.70.128.77]:47448 "EHLO
	smtp-gw51.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656AbXJTGmt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 02:42:49 -0400
Received: from mailanyone.net
	by smtp-gw51.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1Ij82p-0005Rd-2Z; Sat, 20 Oct 2007 01:42:47 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Fri, 19 Oct 2007 23:42:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710191616490.16728@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61798>

On Fri, Oct 19, 2007 at 04:27:39PM +0200, Johannes Schindelin wrote:

> While reading this, I have to wonder why it is not just simpler to try 
> with builtin_exec_path first, and if that fails, just let exec() find the 
> program in the PATH?

I think you're right; that is a much better way to do this. I've
rewritten this as two patches i'll post shortly. I have mixed
feelings about the MANPATH/PERL5LIB hack, so i'm leaving it out for
now.

sRp

-- 
Scott Parish
http://srparish.net/
