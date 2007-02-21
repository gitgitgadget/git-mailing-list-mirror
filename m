From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 12:17:38 -0500
Message-ID: <20070221171738.GA9112@fieldses.org>
References: <20070221164527.GA8513@ginosko.local> <20070221165636.GH25559@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 18:17:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJv64-0002GT-Lg
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 18:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422720AbXBURRh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 12:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422719AbXBURRg
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 12:17:36 -0500
Received: from mail.fieldses.org ([66.93.2.214]:45228 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422716AbXBURRf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 12:17:35 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HJv62-0002YH-HY; Wed, 21 Feb 2007 12:17:38 -0500
Content-Disposition: inline
In-Reply-To: <20070221165636.GH25559@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40308>

On Wed, Feb 21, 2007 at 11:56:36AM -0500, Shawn O. Pearce wrote:
> Now this is actually not a huge deal if you do it on your local
> repository and go "whoops, I should not have committed that".  If you
> have not yet pushed the commit to another repository (and someone
> has not yet fetched it from you either) you can use git-rebase to
> discard it.

Also it can't have done any (non-fast-forward) merges since then.

Reconstructing history with a bunch of merges seems like something that
could be a huge pain.  (Though with some tools it might be doable.)

--b.
