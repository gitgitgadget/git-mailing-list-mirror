From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Why does "git log --reverse -1" print the HEAD commit?
Date: Sat, 31 May 2008 17:33:27 +0300
Message-ID: <20080531143327.GA4121@mithlond.arda.local>
References: <20080531141102.GA3035@mithlond.arda.local> <20080531142408.GL29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat May 31 16:34:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2SAX-0003Sj-PT
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 16:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbYEaOdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 10:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbYEaOdg
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 10:33:36 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:32933 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752552AbYEaOdf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 10:33:35 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.rokki.sonera.fi (8.5.014)
        id 483E82F1001A95F9; Sat, 31 May 2008 17:33:29 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K2S99-00015p-6e; Sat, 31 May 2008 17:33:27 +0300
Content-Disposition: inline
In-Reply-To: <20080531142408.GL29404@genesis.frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83389>

Miklos Vajna wrote (2008-05-31 16:24 +0200):

> On Sat, May 31, 2008 at 05:11:02PM +0300, Teemu Likonen
> <tlikonen@iki.fi> wrote:
> > It feels wrong that "git log -1" and "git log --reverse -1" both
> > print the same commit: HEAD. Why is that?
> > 
> > Since "git log --reverse" starts from the bottom I'd have expected
> > "-1" to print one commit from the bottom.
> 
> -1 limits the commit list to one element and then it prints that range
> in reverse order, which is the same for a single commit.

Oh yeah, that's the logic, thanks. I find it counter-intuitive but I'll
survive.
