From: Zefram <zefram@fysh.org>
Subject: Re: ghost refs
Date: Tue, 20 Apr 2010 13:02:28 +0100
Message-ID: <20100420120228.GM17930@lake.fysh.org>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com> <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com> <20100407210010.GB27012@coredump.intra.peff.net> <loom.20100420T085842-887@post.gmane.org> <20100420115124.GB22907@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <yann.dirson@bertin.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 20 14:02:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4CA4-0003bt-Bo
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 14:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab0DTMCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 08:02:34 -0400
Received: from lake.fysh.org ([81.94.195.195]:46063 "EHLO lake.fysh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754223Ab0DTMCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 08:02:33 -0400
Received: from zefram by lake.fysh.org with local (Exim 4.69 #1 (Debian))
	id 1O4C9s-0001Pn-8E; Tue, 20 Apr 2010 13:02:28 +0100
Content-Disposition: inline
In-Reply-To: <20100420115124.GB22907@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145367>

Jeff King wrote:
>  2. Make a refs/dead hierarchy so that the reflogs don't interfere with
>     new branches. This just pushes off the problem, though, for when
>     you try to delete "foo/bar" and see that "refs/dead/foo" is already
>     blocking its spot in the reflog graveyard.

This is easily solved by tweaking the name for dead reflogs.
logs/dead_refs/foo~ doesn't clash with logs/dead_refs/foo/bar~.

You might also want to stick a sequence number into the filename, for
when you delete more than one foo/bar branch.

-zefram
