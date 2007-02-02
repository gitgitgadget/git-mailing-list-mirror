From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".
Date: Fri, 2 Feb 2007 19:07:06 +0100
Message-ID: <20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth> <20070201234805.3313.20525.stgit@gandelf.nowhere.earth> <b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 19:08:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD2pR-0007mM-Hl
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 19:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946009AbXBBSIA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 13:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946010AbXBBSIA
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 13:08:00 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:55383 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946009AbXBBSIA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 13:08:00 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id DF6348122;
	Fri,  2 Feb 2007 19:07:58 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 212E21F080; Fri,  2 Feb 2007 19:07:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38520>

On Fri, Feb 02, 2007 at 09:58:06AM +0000, Catalin Marinas wrote:
> On 01/02/07, Yann Dirson <ydirson@altern.org> wrote:
> >Previously we were just assuming that the remote from which we
> >just failed defined a local branch whose name was the same as the
> >remote def, and that this branch was the parent.  While this is true
> >for the most common case (branch "origin" from remote "origin"), it is
> >quite an unflexible assumption.
> 
> The t1200-push-modified.sh test fails after applying this patch. It
> looks like the 3rd test fails to pull the changes from 'foo' into
> 'bar'.

Strange, it passes here, even after pulling you latest commits
(HEAD=fba895f5f12a652c248b0fd02b7c41f8342cfbdc).

Best regards,
-- 
Yann.
