From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH RFC] rebase--interactive: if preserving merges, use
	first-parent to limit what is shown.
Date: Tue, 7 Oct 2008 07:38:02 -0700
Message-ID: <20081007143802.GI8203@spearce.org>
References: <48E8DD7E.9040706@redhat.com> <20081006102118.3e817a0f.stephen@exigencecorp.com> <20081006212021.04ba9214.stephen@exigencecorp.com> <20081007013654.274e5cf6.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avi Kivity <avi@redhat.com>, git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 16:40:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnDiX-00028E-Lq
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 16:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbYJGOiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 10:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbYJGOiF
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 10:38:05 -0400
Received: from george.spearce.org ([209.20.77.23]:52184 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbYJGOiE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 10:38:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 62A743835F; Tue,  7 Oct 2008 14:38:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081007013654.274e5cf6.stephen@exigencecorp.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97709>

Stephen Haberman <stephen@exigencecorp.com> wrote:
> However, lest I burn my "PATCH v2" opportunity, I'm holding off on
> posting the updated patch. It works and passes tests but I'm sure I'll
> tinker with it some more over the next few days. It will also likely
> conflict with my pu sh/maint-rebase3 patch, so I don't know whether to
> base it on top of that one or not (guessing not).

When a patch series is in `pu` it can be rebased/replaced/amended
at any time.  That's why I parked it there.  The pu branch rewinds
and is rebuilt on a daily basis.  Any commits not yet merged into
maint, master or next are automatically rebased onto the latest
maint or master branch and get merged into that day's pu.

So don't hold back on posting patches.  Folks expect to see
patches on this list; talking is less productive than posting code.
Showing code that purports to solve a problem, or that at least
displays a problem concretely is worthy of discussion.

And don't worry about replacing what is currently in pu.  Its easily
done by the maintainer.  However don't expect daily updates to a
topic in pu.  Junio (and I) just don't have the bandwidth to keep
replacing patches every day.
 
-- 
Shawn.
