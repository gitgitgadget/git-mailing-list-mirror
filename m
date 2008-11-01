From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git/lib and git/git-gui/lib merge mis-hap?
Date: Sat, 1 Nov 2008 13:22:01 -0700
Message-ID: <20081101202201.GA15463@spearce.org>
References: <490CAE40.4060300@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Nov 01 21:23:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwN0E-0005RI-7L
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 21:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbYKAUWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 16:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752448AbYKAUWF
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 16:22:05 -0400
Received: from george.spearce.org ([209.20.77.23]:56969 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbYKAUWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 16:22:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CC8BE3835F; Sat,  1 Nov 2008 20:22:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <490CAE40.4060300@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99771>

Andreas Ericsson <ae@op5.se> wrote:
> Settling down to get some libgit2 hacking done (adding build-rules
> to git.git), I noticed that there's a file in git.git called
> lib/remote_add.tcl, which looks as if it belongs in git-gui/lib.
>
> I don't know how this happened, but since I assume it's subtree
> merged (thus requiring more work to correct than a simple patch),
> it would be nifty if it could get corrected so as to make space
> for the up-and-coming git library :-)

That was a bad merge of git-gui on my part.  I thought it was fixed.
It only happened in next, and was there only for a day before
someone pointed it out to me, and I fixed it in the tree.

FWIW, "git mv lib/remote_add.tcl git-gui/lib" is all you need to
fix it.  There's nothing special about the subtree merge.

-- 
Shawn.
