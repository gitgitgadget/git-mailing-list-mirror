From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Documentation/git-gc.txt: change --aggressive
	description
Date: Tue, 13 May 2008 14:08:42 +0300
Message-ID: <20080513110842.GB3088@mithlond.arda.local>
References: <1210672413-8761-1-git-send-email-pdebie@ai.rug.nl> <20080513105728.GA3088@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Tue May 13 13:09:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvsO6-0007c3-7r
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 13:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759878AbYEMLIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 07:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759917AbYEMLIs
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 07:08:48 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:47108 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759878AbYEMLIr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 07:08:47 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.rokki.sonera.fi (8.5.014)
        id 48232FF00038C394; Tue, 13 May 2008 14:08:44 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JvsN8-00012c-BB; Tue, 13 May 2008 14:08:42 +0300
Content-Disposition: inline
In-Reply-To: <20080513105728.GA3088@mithlond.arda.local>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82016>

Teemu Likonen wrote (2008-05-13 13:57 +0300):

> Pieter de Bie wrote (2008-05-13 11:53 +0200):
> 
> > I keep seeing people regularly packing their repo with git gc
> > --aggressive. However, in my experience, this seldom results in
> > a smaller repository. This can be because the repository was
> > repacked tightly previously (for example, with a high --window
> > value) or because incremental "git gc" just makes better packs
> > anyway. Throwing away that information is often not a good idea.
> >
> > The documentation for the --aggressive flag was misleading, in that
> > it hints that you'll get a smaller pack, which is often not the
> > case.
> 
> This patch might be a good thing. But from ordinary user's point of
> view this raises questions: if gc --aggressive really is not that
> aggressive then the option itself is misleading. Why not change gc
> --aggressive to be really effective? Using high --window/--depth value
> etc.

I mean, what I'm seeing many places is suggestions to run

  git repack -a -d -f --window=100 --depth=100

to get the repo small. _If_ there's such a common need for this then
wouldn't it be good thing if there was easy and self-descriptive command
for it, such as gc --aggressive?
