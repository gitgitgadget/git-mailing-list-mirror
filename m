From: Alex Bennee <kernel-hacker@bennee.com>
Subject: RE: Merging commits together into a super-commit
Date: Thu, 10 May 2007 12:32:28 +0100
Organization: Insert joke here
Message-ID: <1178796748.5806.102.camel@murta.transitives.com>
References: <000e01c792f5$0861abd0$0b0aa8c0@abf.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Raimund Bauer <ray@softwarelandschaft.com>
X-From: git-owner@vger.kernel.org Thu May 10 13:32:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm6sX-0002OT-2h
	for gcvg-git@gmane.org; Thu, 10 May 2007 13:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbXEJLcJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 07:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754173AbXEJLcJ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 07:32:09 -0400
Received: from mx.transitive.com ([217.207.128.220]:59822 "EHLO
	pennyblack.transitives.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751349AbXEJLcI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2007 07:32:08 -0400
Received: from [192.168.2.164] (helo=[192.168.2.164])
	by pennyblack.transitives.com with esmtp (Exim 4.50)
	id 1Hm6cU-0006pq-Qx; Thu, 10 May 2007 11:15:39 +0000
In-Reply-To: <000e01c792f5$0861abd0$0b0aa8c0@abf.local>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46858>

On Thu, 2007-05-10 at 13:19 +0200, Raimund Bauer wrote:
> > Hi,
>  <snip> 
> You don't want to be 
> > correcting a whole bunch of merge failures for every commit 
> > in your current tree.
> > 
> > So far the only was I can see to do this is a:
> > 
> > git-diff master..HEAD > my.patch
> > 
> > And then re-applying your patch in stages, manually doing the commits.
> > 
> > Am I missing something?
> 
> git merge --squash ?

Hmm, that would do although it only works on whole trees, you can't
specify a range of commits. So you would have to cherrypick groups of
changes onto other branches and then merge them together with a couple
of --squashes

However thanks for pointing that one out :-)

-- 
Alex, homepage: http://www.bennee.com/~alex/
A pretty woman can do anything; an ugly woman must do everything.
