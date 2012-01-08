From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] rebase --fix: interactive fixup mode
Date: Sun, 8 Jan 2012 23:25:47 +0100
Message-ID: <20120108222545.GB22680@ecki.lan>
References: <20120108213134.GA18671@ecki.lan>
 <20120108220127.GA4050@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 23:34:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk1Jc-0003Wt-2J
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 23:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651Ab2AHWeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 17:34:06 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:57715 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754602Ab2AHWeF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 17:34:05 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id E931A1000F;
	Sun,  8 Jan 2012 23:32:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120108220127.GA4050@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188149>

On Sun, Jan 08, 2012 at 04:01:27PM -0600, Jonathan Nieder wrote:
> 
> Funny. :)  I wonder if this is possible to generalize, to something like
> 
> 	git rebase -i foo^{last-merge}
> 
> What do you think?

I suppose if the history has no merges, I would return the root commit?

Uh, and now I realize I have a bug. In a repo with only linear history:

$ git rebase --fix
fatal: ambiguous argument '4ccf67b9fa2ae247e55b86648d650cb368f286c2^': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
fatal: Needed a single revision
invalid upstream 4ccf67b9fa2ae247e55b86648d650cb368f286c2^
