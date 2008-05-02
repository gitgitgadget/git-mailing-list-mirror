From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Make words boundary for --color-words configurable
Date: Fri, 2 May 2008 13:01:54 +0300
Message-ID: <20080502100154.GB11420@mithlond.arda.local>
References: <1209699564-2800-1-git-send-email-pkufranky@gmail.com> <alpine.DEB.1.00.0805020839200.2691@eeepc-johanness> <20080502081408.GA11420@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 02 12:02:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrs6S-0003aM-29
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 12:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758389AbYEBKCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 06:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758586AbYEBKCH
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 06:02:07 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:33431 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752482AbYEBKCG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 06:02:06 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.0.013.9)
        id 481789310027FC84; Fri, 2 May 2008 13:02:02 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Jrs5S-0003Mu-Eh; Fri, 02 May 2008 13:01:54 +0300
Content-Disposition: inline
In-Reply-To: <20080502081408.GA11420@mithlond.arda.local>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80976>

Teemu Likonen wrote (2008-05-02 11:14 +0300):

> > On Fri, 2 May 2008, Ping Yin wrote:
> > 
> > > Previously --color-words only allow spaces as words boundary.
> > > However, just space is not enough. For example, when i rename
> > > a function from foo to bar, following example doesn't show as
> > > expected when using --color-words.

> Just a quick note from someone who is not so much a programmer but who
> uses Git to track text/LaTex/etc. files with human languages: 

And let me add a sidenote that, at least to me, --color-words is the
tool for doing diffs of human language text files. I think it's a lot
more useful than normal diff.
