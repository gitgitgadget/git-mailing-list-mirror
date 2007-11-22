From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/3 v3] git-svn info: implement info command
Date: Wed, 21 Nov 2007 20:17:53 -0800
Message-ID: <20071122041753.GC30134@soma>
References: <20071122014038.GA25341@soma> <900537.19467.qm@web52411.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 05:18:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv3W0-0003DW-V6
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 05:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbXKVERz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 23:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbXKVERz
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 23:17:55 -0500
Received: from hand.yhbt.net ([66.150.188.102]:37137 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbXKVERy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 23:17:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 065677DC0FE;
	Wed, 21 Nov 2007 20:17:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <900537.19467.qm@web52411.mail.re2.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65741>

"David D. Kilzer" <ddkilzer@kilzer.net> wrote:
> Eric Wong <normalperson@yhbt.net> wrote:
> > When running from a top-level directory with no arguments, the first
> > line of git-ls-tree was being read.  This allowed the test case to pass
> > because ls-tree sorts the output and 'directory' just happened to
> > be up top; so we were getting the 040000 mode from the 'directory'
> > tree and not the top-level tree.
> > 
> > The below test should fix it for the trivial case I have.
> 
> Acked-by: David D. Kilzer <ddkilzer@kilzer.net>
> 
> Looks good!  Thanks!

Ok, I've folded that into your [2/3] and pushed everything (and an
earlier fix) out to

	git://git.bogomips.org/git-svn.git

David D. Kilzer (3):
      git-svn: extract reusable code into utility functions
      git-svn info: implement info command
      git-svn: info --url [path]

Eric Wong (2):
      t9106: fix a race condition that caused svn to miss modifications
      git-svn: allow `info' command to work offline

Junio, please pull, thanks.

-- 
Eric Wong
