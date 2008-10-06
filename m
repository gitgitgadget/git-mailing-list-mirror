From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] builtin-commit: avoid always using reduce_heads()
Date: Mon, 6 Oct 2008 07:19:03 -0700
Message-ID: <20081006141903.GB7684@spearce.org>
References: <20081003145915.GB3291@spearce.org> <1223236300-2170-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jnareb@gmail.com, Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	SZEDER GGGbor <szeder@ira.uka.de>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Oct 06 16:23:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmqwc-0003vt-BZ
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 16:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbYJFOTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 10:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbYJFOTF
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 10:19:05 -0400
Received: from george.spearce.org ([209.20.77.23]:59699 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbYJFOTF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 10:19:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4D6A33835F; Mon,  6 Oct 2008 14:19:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1223236300-2170-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97585>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> In case git merge --no-ff is used with --no-commit or we have a
> conflict, write info about if fast forwards are allowed or not to
> $GIT_DIR/MERGE_MODE.
 
> On Fri, Oct 03, 2008 at 07:59:15AM -0700, "Shawn O. Pearce" <spearce@spearce.org> wrote:
> > ./test-lib.sh: line 237:   362 Segmentation fault      git commit -m
> > initial
> > * FAIL 1: setup
> >
> > I leave the debugging to you.  ;-)
> 
> That's weird, make test passed for me before I sent this patch. It was
> based on 15dc66a.
> 
> Now I squashed in Gabor's patch and rebased it against 52e8370, I hope
> it fixed the issue (make test still passes for me).

Yea, Gabor's patch squashed in is what was needed.  This is already
in next; it was there on Friday.  But thanks anyway.

-- 
Shawn.
