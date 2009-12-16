From: Eric Paris <eparis@redhat.com>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Wed, 16 Dec 2009 08:41:25 -0500
Message-ID: <1260970885.2788.87.camel@localhost>
References: <1260822484.9379.53.camel@localhost>
	 <20091214211142.GC9364@coredump.intra.peff.net>
	 <1260825629.9379.56.camel@localhost>
	 <20091215023918.GA14689@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0912142245240.23173@xanadu.home>
	 <1260851180.9379.88.camel@localhost>
	 <alpine.LFD.2.00.0912152201300.23173@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Dec 16 14:41:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKu8I-0005Rz-MZ
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 14:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933910AbZLPNlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 08:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933892AbZLPNlc
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 08:41:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19384 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932547AbZLPNlb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 08:41:31 -0500
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBGDfRsF023468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 16 Dec 2009 08:41:27 -0500
Received: from [10.11.8.210] (vpn-8-210.rdu.redhat.com [10.11.8.210])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nBGDfQV6000647;
	Wed, 16 Dec 2009 08:41:26 -0500
In-Reply-To: <alpine.LFD.2.00.0912152201300.23173@xanadu.home>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135328>

On Tue, 2009-12-15 at 22:03 -0500, Nicolas Pitre wrote:
> On Mon, 14 Dec 2009, Eric Paris wrote:
> 
> > The alternative repo is slowing pushing up to that same location.  That
> > tar is 855838982, so just a tad bit smaller.
> 
> It doesn't appear to be complete yet, and not progressing either.

The alternative repo is now available (but the original is down)

I tried to run git gc --aggressive last night while I slept and got this
as output, maybe it helps point to a solution/problem?  The git reflog
portion ran for 5 hours and 36 minutes and appears to have finished.

$ git gc --aggressive
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
warning: reflog of 'refs/remotes/audit/master' references pruned commits
warning: reflog of 'refs/remotes/btrfs/enospc' references pruned commits
warning: reflog of 'refs/remotes/btrfs/merge' references pruned commits
warning: reflog of 'refs/remotes/btrfs/for-linus' references pruned commits
warning: reflog of 'refs/remotes/security-testing/for-linus' references pruned commits
error: Could not read 29b6c2fb1390b4fd350a5ecc78f1156fc5d91e9f
fatal: bad tree object 29b6c2fb1390b4fd350a5ecc78f1156fc5d91e9f
error: failed to run repack
