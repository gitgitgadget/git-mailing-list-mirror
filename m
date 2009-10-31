From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v4 26/26] test smart http fetch and push
Date: Fri, 30 Oct 2009 17:13:14 -0700
Message-ID: <20091031001314.GK10505@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org> <1256774448-7625-27-git-send-email-spearce@spearce.org> <be6fef0d0910300910x5e8bc552k4f020ca8bb890352@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Clemens Buchacher <drizzd@aon.at>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 01:13:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N41as-0000Tr-BK
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 01:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933138AbZJaANM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 20:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933136AbZJaANK
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 20:13:10 -0400
Received: from george.spearce.org ([209.20.77.23]:32966 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933135AbZJaANJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 20:13:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C9753381D3; Sat, 31 Oct 2009 00:13:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <be6fef0d0910300910x5e8bc552k4f020ca8bb890352@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131782>

Tay Ray Chuan <rctay89@gmail.com> wrote:
> 
> Having "/git/" reside as a subdirectory in "/" where WebDAV is enabled
> may be confusing to readers. I think we should use "/smart/" for the
> CGI map, and consequently, use "/dumb/" for WebDAV repositories,
> rather than the root "/" that it is occupying.

Yup, great idea.  Patch added to switch to /dumb/ for WebDAV,
and changed to use /smart/ for this patch.
 
> Mention of "packed refs" should be removed from the description, and
> the 'unpacked refs' test, irrelevant in this context, should be
> removed too. The assumptions these tests are based on is relevant to
> t5540, but not in t5541. My explanation follows.

Yup, you are right, thanks.  Fixed.
 
-- 
Shawn.
