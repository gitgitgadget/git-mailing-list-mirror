From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".
Date: Fri, 2 Feb 2007 23:42:50 +0100
Message-ID: <20070202224250.GF5362@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth> <20070201234805.3313.20525.stgit@gandelf.nowhere.earth> <b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com> <20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 23:43:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD78G-0000yn-Se
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 23:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946140AbXBBWnp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 17:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946141AbXBBWnp
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 17:43:45 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:51184 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946140AbXBBWnp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 17:43:45 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 1446B5557;
	Fri,  2 Feb 2007 23:43:43 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id A97351F080; Fri,  2 Feb 2007 23:42:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38535>

On Fri, Feb 02, 2007 at 07:07:06PM +0100, Yann Dirson wrote:
> > The t1200-push-modified.sh test fails after applying this patch. It
> > looks like the 3rd test fails to pull the changes from 'foo' into
> > 'bar'.
> 
> Strange, it passes here, even after pulling you latest commits
> (HEAD=fba895f5f12a652c248b0fd02b7c41f8342cfbdc).

Wondering which GIT version you are using, I tried to run the
testsuite with current GIT HEAD, and it fails much earlier (t1001).
We'll have some work here :)

Best regards,
-- 
Yann.
