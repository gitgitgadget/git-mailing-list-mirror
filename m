From: William Morgan <wmorgan-git@masanjin.net>
Subject: Re: question about conflict resolution across multiple branches
Date: Sun, 22 Mar 2009 13:05:34 -0700
Message-ID: <1237751617-sup-640@entry>
References: <1237483813-sup-5631@entry> <7viqm58e8r.fsf@gitster.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 22 21:07:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlTwp-0003zQ-7o
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 21:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168AbZCVUFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 16:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754880AbZCVUFh
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 16:05:37 -0400
Received: from masanjin.net ([209.20.72.13]:49712 "EHLO entry.masanjin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754665AbZCVUFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 16:05:36 -0400
Received: from w by entry.masanjin.net with local (Exim 4.69)
	(envelope-from <w@masanjin.net>)
	id 1LlTvK-0004mV-Dz
	for git@vger.kernel.org; Sun, 22 Mar 2009 13:05:34 -0700
In-Reply-To: <7viqm58e8r.fsf@gitster.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114170>

Reformatted excerpts from Junio C Hamano's message of 2009-03-19:
>     $ git diff origin/next >fixup.patch

Ok, this is helpful. So git diff will give me an explicit dump of the
conflict resolution changes, which I can use with git apply --index when
I see the conflict. Sort of a manual, shared, git-rerere.

Wouldn't it be simpler for git format-patch to produce something for a
merge commit with conflicts? (Maybe there's a way and I just can't find
it?)

> Needless to say, you need to be careful when accepting such a fixup
> patch.

More careful than when accepting a "regular" patch?

Thanks for your help!
-- 
William <wmorgan-git@masanjin.net>
