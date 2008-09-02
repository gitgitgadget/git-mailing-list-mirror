From: Petr Baudis <pasky@suse.cz>
Subject: Re: pack count on repo.or.cz [was "Medium term dreams"]
Date: Tue, 2 Sep 2008 15:08:01 +0200
Message-ID: <20080902130801.GN10360@machine.or.cz>
References: <7vsksjsbcc.fsf@gitster.siamese.dyndns.org> <20080902000037.GA11869@coredump.intra.peff.net> <20080902010410.GI10360@machine.or.cz> <20080902011433.GA12682@coredump.intra.peff.net> <20080902111531.GL10360@machine.or.cz> <20080902115424.GA11303@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 02 15:09:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaVdD-0008F2-EA
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 15:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbYIBNIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 09:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbYIBNII
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 09:08:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39236 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbYIBNIH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 09:08:07 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 9BC1C3939B36; Tue,  2 Sep 2008 15:08:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080902115424.GA11303@coredump.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94670>

On Tue, Sep 02, 2008 at 07:54:24AM -0400, Jeff King wrote:
> So did you check for loose objects? That is what you should get if there
> were any objects that would have been lost. If there aren't any new
> loose objects, then there were no objects that would be lost.

Before:

rover:/srv/git/git.git# l objects~/??/* | wc -l
3343
rover:/srv/git/git.git# l objects~/pack/* | wc -l
750

After:

rover:/srv/git/git.git# l objects/??/* | wc -l
2920
rover:/srv/git/git.git# l objects/pack/* | wc -l
590

> As to why the other packs weren't pruned, I don't know. In my example,
> you can see that the pruning happens as we expect. So either there is a
> bug in git-prune-packed, or there is something we're not realizing.

Well, that's my question here. :-)

If you're still interested in looking into this further, you can wget -r
or rsync over the git.git repository from repo.or.cz.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
