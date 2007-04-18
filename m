From: Yann Dirson <ydirson@altern.org>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 22:54:21 +0200
Message-ID: <20070418205420.GC8524@nan92-1-81-57-214-146.fbx.proxad.net>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <200704171818.28256.andyparkins@gmail.com> <8b65902a0704180540l721b9b1dj6f6e068f0d7e5119@mail.gmail.com> <200704181426.29969.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Guilhem Bonnefille <guilhem.bonnefille@gmail.com>,
	Tomash Brechko <tomash.brechko@gmail.com>,
	Pietro Mascagni <pietromas@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 22:55:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeHBe-0004Vg-Ka
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 22:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992690AbXDRUzb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 16:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992692AbXDRUzb
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 16:55:31 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:45020 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992690AbXDRUza (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 16:55:30 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D49085E0BB;
	Wed, 18 Apr 2007 22:55:29 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 4051D1F06B; Wed, 18 Apr 2007 22:54:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200704181426.29969.andyparkins@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44946>

On Wed, Apr 18, 2007 at 02:26:17PM +0100, Andy Parkins wrote:
> On Wednesday 2007 April 18 13:40, Guilhem Bonnefille wrote:
> 
> > An other point is that CVS/SVN actions for our developers are
> > "trivial": update or commit, nothing more (even tags are made by
> 
> > In my mind, git-svn or even git-svnserve, are THE tools to introduce
> > Git in teams not convinced by the power of DVCS. Or perhaps someone
> > will create a porcelain that offers the same simple interface of
> > CVS/SVN and will integrate it in all the fantastic IDE ;-)
> 
> It's already there.  The git porcelain can do almost anything.  If you were so 
> inclined you could write a fake svn command that translated all those calls 
> to git.
> 
> svn add = git add
> svn update = git pull
> svn commit = git commit -a && git push

It's even possible to write those as git aliases, so you can have "git
update" and "git ci" behave as cvs/svn users would expect.
