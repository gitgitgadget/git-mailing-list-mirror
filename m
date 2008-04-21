From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: Unresolved issues, "log --graph"
Date: Mon, 21 Apr 2008 10:33:12 -0700
Message-ID: <20080421173312.GA18367@adamsimpkins.net>
References: <7vbq46fe9h.fsf@gitster.siamese.dyndns.org> <20080420154848.GA8647@mithlond.arda.local>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon Apr 21 19:34:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnzu0-0006hP-DT
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 19:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539AbYDURdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 13:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755002AbYDURdQ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 13:33:16 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:51406 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbYDURdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 13:33:16 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id C319B1B5185;
	Mon, 21 Apr 2008 13:33:14 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 9C78F1B518C;
	Mon, 21 Apr 2008 13:33:14 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id EB43B14100C0; Mon, 21 Apr 2008 10:33:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080420154848.GA8647@mithlond.arda.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80029>

On Sun, Apr 20, 2008 at 06:48:48PM +0300, Teemu Likonen wrote:
> Junio C Hamano wrote (2008-04-19 01:19 -0700):
> 
> > Here is an "issues" list I am keeping track of on the back of my head
> > (and in "TODO" file on 'todo' branch, which is not updated often
> > enough).
> 
> > * log --graph (Adam Simpkins)
> 
> Hi Adam, any changes for modifying the "log --graph" patch series to
> make it apply to the current development version of git? It would just
> feel wrong if this apparently well-designed tool was left behind. Of
> course it's up to you.

Yes.  I didn't mean to drop this, I've just haven't had much time to
work on it lately.  I may get a chance to work on it tomorrow,
otherwise I'll do it this coming weekend.

I'll submit a new series of patches to apply the "log --graph" changes
onto master.  I think the only thing that needs to be changed is to
update my code to work with Junio's jc/terminator-separator changes.
It looks like it should be fairly straightforward.

Junio and others, is there anything else I should do to make the "log
--graph" changes ready for pu/next/master?

-- 
Adam Simpkins
adam@adamsimpkins.net
