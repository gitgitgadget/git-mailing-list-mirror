From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [PATCH] Fix guilt to work correctly even if the refs are packed
Date: Fri, 6 Jul 2007 11:12:38 -0400
Message-ID: <20070706151238.GA1607@filer.fsl.cs.sunysb.edu>
References: <E1I6pF5-0003V9-2R@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Jul 06 17:13:03 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6pUU-0002Yh-Sr
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 17:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759801AbXGFPNB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 11:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759236AbXGFPNA
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 11:13:00 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:40051 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758541AbXGFPNA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 11:13:00 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l66FCcGE002071;
	Fri, 6 Jul 2007 11:12:38 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l66FCcE9002069;
	Fri, 6 Jul 2007 11:12:38 -0400
Content-Disposition: inline
In-Reply-To: <E1I6pF5-0003V9-2R@candygram.thunk.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51763>

On Fri, Jul 06, 2007 at 10:57:07AM -0400, Theodore Ts'o wrote:
> 
> Explicitly referencing .git/refs/heads/$branch is bad; use git
> show-ref -h instead.
 
Applied, I fixed up the commit message; you say -h but the code used -s.

Thanks.

Josef "Jeff" Sipek.

-- 
If I have trouble installing Linux, something is wrong. Very wrong.
		- Linus Torvalds
