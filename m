From: Mike Hommey <mh@glandium.org>
Subject: Re: git-svn fetch updating master
Date: Thu, 16 Aug 2007 10:27:06 +0200
Organization: glandium.org
Message-ID: <20070816082706.GA29521@glandium.org>
References: <20070815181228.GA6363@glandium.org> <20070816080349.GA16849@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Aug 16 10:28:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILai8-0005pE-Uc
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 10:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbXHPI2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 04:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbXHPI2F
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 04:28:05 -0400
Received: from vawad.err.no ([85.19.200.177]:39363 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342AbXHPI2B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 04:28:01 -0400
Received: from aputeaux-153-1-17-6.w82-124.abo.wanadoo.fr ([82.124.59.6] helo=vaio.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1ILahx-0004oE-9F; Thu, 16 Aug 2007 10:27:57 +0200
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1ILah8-0007gq-G7; Thu, 16 Aug 2007 10:27:06 +0200
Content-Disposition: inline
In-Reply-To: <20070816080349.GA16849@muzzle>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55991>

On Thu, Aug 16, 2007 at 01:03:49AM -0700, Eric Wong <normalperson@yhbt.net> wrote:
> Mike Hommey <mh@glandium.org> wrote:
> > Hi,
> > 
> > I was wondering why the master branch was hardcoded to be updated in
> > post_fetch_checkout() in git-svn. Why not allow to use another branch ?
> 
> It shouldn't update master if it the branch already exists and is a
> valid ref.
> 
> The default for git-clone is to create "master", too, so I wanted
> git-svn clone behavior to be the same.

git-svn fetch is not only invoqued at cloning time...

My problem is that I (purposely) removed the master branch, so git-svn fetch
is creating it again every time I run to update the svn branch...

Mike
