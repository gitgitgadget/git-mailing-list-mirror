From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 14:58:34 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901251446260.12651@kiwi.cs.ucla.edu>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0901251916010.14855@racer> <alpine.GSO.2.00.0901251033160.12651@kiwi.cs.ucla.edu>
 <20090125221141.GA17490@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:00:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRDxU-0002zc-BC
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbZAYW6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 17:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbZAYW6j
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 17:58:39 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:39146 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879AbZAYW6j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 17:58:39 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0PMwYm2018009;
	Sun, 25 Jan 2009 14:58:34 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0PMwYoS018005;
	Sun, 25 Jan 2009 14:58:34 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <20090125221141.GA17490@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107119>

On Sun, 25 Jan 2009, Jeff King wrote:

> FWIW, I found it very confusing. I would have expected "diff.options" or 
> "diff.defaults". There is also some precedent in the form of GIT_DIFF_OPTS, 
> but I believe it _only_ handles --unified and -u, so it is not necessarily a 
> useful model.

OK, point taken.  I wasn't trying to be idiosyncratic at all.  Just trying to be 
explicit and avoid all confusion.  Since all diff options already have default 
values, primer looks to me like the layer one step above defaults, hence the 
painting analogy.  Mercurial calls it "defaults", but that doesn't mean we 
should necessarily follow in their footsteps (see 
http://article.gmane.org/gmane.comp.version-control.git/107103).

I think being as clear as possible about what primer is, that is it NOT 
defaults, helps to feel more comfortable with its consequences, i.e. in my 
opinion, that it will not break things.

                                   -- Keith
