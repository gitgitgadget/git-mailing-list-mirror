From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 2/3] Teach git diff-tree --stdin to diff trees
Date: Sat, 9 Aug 2008 12:00:49 +0200
Message-ID: <20080809100049.GB10804@diana.vm.bytemark.co.uk>
References: <20080808204348.7744.46006.stgit@yoghurt> <20080808204829.7744.11661.stgit@yoghurt> <20080808214523.GA31424@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 09 11:39:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRkvU-0000u2-Db
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 11:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbYHIJix convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2008 05:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbYHIJix
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 05:38:53 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1514 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbYHIJix (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 05:38:53 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KRlFh-00038Y-00; Sat, 09 Aug 2008 11:00:49 +0100
Content-Disposition: inline
In-Reply-To: <20080808214523.GA31424@sigill.intra.peff.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91760>

On 2008-08-08 17:45:23 -0400, Jeff King wrote:

> Hmm. Just looking at this as a git user, I would have expected it to
> take one or more hashes, separated by spaces. If only one, then it
> must be a commit, and it is diffed against its parents. If more than
> one, then each must be a tree-ish. So you could diff a commit
> against a tree (or a tag against a commit, or...).

I agree.

> And I think it might even be easier to code. ;)

Not for someone who's almost entirely unfamiliar with the git API.
=46inding the right functions to call takes a lot of time ... which is
why I decided to chicken out and implement only the subset I actually
needed. But it can be added later -- perhaps by me.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
