From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/2] Switch usage of AnyObjectId.toString() to new
	AnyObjectId.name()
Date: Wed, 3 Sep 2008 20:23:58 -0700
Message-ID: <20080904032358.GB3262@spearce.org>
References: <20080903090157.GB23406@diku.dk> <20080903170438.GA28315@spearce.org> <20080903213114.GA6316@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Sep 04 05:25:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb5Sz-00043k-Ee
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 05:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbYIDDX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 23:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbYIDDX7
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 23:23:59 -0400
Received: from george.spearce.org ([209.20.77.23]:34793 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516AbYIDDX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 23:23:59 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8F52638375; Thu,  4 Sep 2008 03:23:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080903213114.GA6316@diku.dk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94883>

Jonas Fonseca <fonseca@diku.dk> wrote:
> Shawn O. Pearce <spearce@spearce.org> wrote Wed, Sep 03, 2008:
> > Hmm.  I had to squash this into it just to fix most of the code and
> > make it pass tests, let alone fix the fetch and push implementations.
> > Most of the library plain up and broke with this toString change.
> >
> > Missing T0001_ObjectId suggests to me that your method of running
> > the tests isn't working right.
> 
> I can see that I am off to a good start leaving everything in a nice
> broken mess. My only excuse is that while writing the patch I was still
> trying to set up the tests to run properly. After applying your fix
> and rerunning the tests pass here also.
> 
> And, lessons learnt: also run the jgit programs to get wider coverage.
> (Uh, sounds like wiki material ... :)

No big deal.  The jgit pgm package has no tests.  It needs tests.
Running them by hand to test the sucks.  Really I was just trying
to make you aware of the fact that your test runner wasn't working
correctly.
 
> > And this is only JGit.  I haven't even started to look into EGit.
> > Though I don't expect you to fix EGit since you are working on
> > NetBeans.  :-)
> 
> It is clearly a bigger tasks than I had expected and maybe not a good
> starting point for contributing to JGit. However, in the longer run this
> interface change will remove some unpleasant surprises.

Robin filled in the EGit stuff.  I'll go through it again once more
tomorrow and hopefully we can apply the whole series and move on.

-- 
Shawn.
