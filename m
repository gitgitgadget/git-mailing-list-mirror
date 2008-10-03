From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Do not rename read-only files during a push
Date: Fri, 3 Oct 2008 07:16:28 -0700
Message-ID: <20081003141628.GV21310@spearce.org>
References: <1222104029-28366-1-git-send-email-pasky@suse.cz> <20081003102043.GR10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Oct 03 16:18:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KllTP-0003nY-Cq
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 16:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbYJCOQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 10:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbYJCOQ3
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 10:16:29 -0400
Received: from george.spearce.org ([209.20.77.23]:42496 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbYJCOQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 10:16:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 43FEC3835F; Fri,  3 Oct 2008 14:16:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081003102043.GR10544@machine.or.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97427>

Petr Baudis <pasky@suse.cz> wrote:
> On Mon, Sep 22, 2008 at 07:20:29PM +0200, Petr Baudis wrote:
> > Win32 does not allow renaming read-only files (at least on a Samba
> > share), making push into a local directory to fail. Thus, defer
> > the chmod() call in index-pack.c:final() only after
> > move_temp_to_file() was called.
> > 
> > Signed-off-by: Petr Baudis <pasky@suse.cz>
> 
> Ping?

Hmmph.  It got dropped by accident.  I don't remember seeing this
patch via email, and its not on GMane.  I found it on marc and am
applying it right now.  Thanks for the reminder.

-- 
Shawn.
