From: Petr Baudis <pasky@suse.cz>
Subject: Re: pack count on repo.or.cz [was "Medium term dreams"]
Date: Tue, 2 Sep 2008 03:04:10 +0200
Message-ID: <20080902010410.GI10360@machine.or.cz>
References: <7vsksjsbcc.fsf@gitster.siamese.dyndns.org> <20080902000037.GA11869@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 02 03:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaKL5-0006zY-Lc
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 03:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbYIBBEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 21:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753415AbYIBBET
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 21:04:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51498 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375AbYIBBES (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 21:04:18 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id AF6E63939B3B; Tue,  2 Sep 2008 03:04:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080902000037.GA11869@coredump.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94634>

On Mon, Sep 01, 2008 at 08:00:37PM -0400, Jeff King wrote:
> It looks like the gc.autopacklimit defaults to 50, which would have
> helped this. Pasky, is repo.or.cz not gc-ing? Or gc-ing with different
> parameters? Or is this an artifact of the forking infrastructure (i.e.,
> these packs are actually split across multiple modules)?

Unfortunately, I'm not aware how to decreate the packs count with
current Git without losing _any_ objects. So yes, you could say that
this is an artifact of the forking infrastructure - we just can't afford
to lose objects.

I've been meaning to look into this for few... years now, but there is
always too many more important things to do. If anyone wants to help
out, you're welcome to! :-)

Maybe I should just give up on the whole alternates idea. Unless the
referenced object store is practically static, it just does not seem
as a feasible thing to do with Git at all, and disk space is cheap.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
