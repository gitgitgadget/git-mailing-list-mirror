From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: finding deleted file names
Date: Thu, 3 Jul 2008 20:32:24 +0000
Message-ID: <20080703203224.GA7663@spearce.org>
References: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com> <20080703103658.GA11571@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Geoff Russell <geoffrey.russell@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 03 22:33:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEVUY-0001pm-Mh
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 22:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756008AbYGCUc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 16:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755983AbYGCUc0
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 16:32:26 -0400
Received: from george.spearce.org ([209.20.77.23]:42876 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957AbYGCUcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 16:32:25 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DCD2A382A1; Thu,  3 Jul 2008 20:32:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080703103658.GA11571@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87317>

Jeff King <peff@peff.net> wrote:
> On Thu, Jul 03, 2008 at 09:31:55AM +0930, Geoff Russell wrote:
> 
> > git diff --diff-filter=D --name-only HEAD@{'7 days ago'}
> > 
> > finds files deleted during the last 7 days, but if my repository is
> > only 6 days old I get a
> > fatal error.
> > 
> > fatal: bad object HEAD@{7 days ago}
> 
> This should issue a warning, but use the oldest reflog entry. However,
> there is a slight problem with that. See below for details.
> 
> Shawn, does this seem sane to you?

Yea, this is the only reasonable thing to do here.  Ack.

-- 
Shawn.
