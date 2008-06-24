From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 07:59:37 +0300
Message-ID: <20080624045937.GA3125@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 07:02:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB0f6-0003kJ-8A
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 07:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112AbYFXFAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 01:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbYFXFAX
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 01:00:23 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:59097 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754112AbYFXE7o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 00:59:44 -0400
Received: from mithlond.arda.local (80.220.180.140) by jenni2.rokki.sonera.fi (8.5.014)
        id 483E832F012D46DE; Tue, 24 Jun 2008 07:59:39 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KB0cz-000109-Pv; Tue, 24 Jun 2008 07:59:37 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85989>

David Jeske wrote (2008-06-24 01:47 -0000):

> As a new user, I'm finding git difficult to trust, because there are
> operations which are destructive by default and capable of
> inadvertently throwing hours or days of work into the bit bucket.

I'm also quite new and I actually feel safe using git, and it's because
of reflog. No matter what I do (except manual reflog expire) I can see
where I was before with command

  git log --walk-reflogs

and get everything back. I have needed it a couple of times. So the
safety net is there, one just has to learn to trust it. :-)

Git is much safer than the standard Unix tools like rm, mv and cp.
