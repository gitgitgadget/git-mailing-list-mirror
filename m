From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/3] Fixes bug: git-svn: svn.pathnameencoding is not
	respected with dcommit/set-tree
Date: Tue, 4 Jan 2011 15:20:29 -0800
Message-ID: <20110104232029.GA15889@dcvr.yhbt.net>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru> <1293240049-7744-2-git-send-email-zapped@mail.ru> <201101041818.09365.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Zapped <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Wed Jan 05 00:20:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaGB9-0006Cp-NQ
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 00:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065Ab1ADXU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 18:20:29 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:56045 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833Ab1ADXU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 18:20:29 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD3081F760;
	Tue,  4 Jan 2011 23:20:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <201101041818.09365.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164524>

Thomas Rast <trast@student.ethz.ch> wrote:
> Zapped wrote:
> > git-svn dcommit/set-tree fails when svn.pathnameencoding is set for native OS encoding (e.g. cp1251 for Windows) though git-svn fetch/clone works well
> 
> I'll let Eric judge whether loading the encoding here is the right
> fix, but here too the commit message states only what is broken, not
> why you fixed it that way.  Can you elaborate a bit?
> 
> Also, this should be easy to cover with a test case, can you make one?

I second Thomas's requests.  I'm also a bit disappointed the original
option is missing tests, especially since not many people are likely to
use it.

-- 
Eric Wong
