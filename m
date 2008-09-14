From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git at Better SCM Initiative comparison of VCS (long)
Date: Sun, 14 Sep 2008 14:06:48 -0700
Message-ID: <20080914210648.GB26608@spearce.org>
References: <200809131906.18746.jnareb@gmail.com> <20080914144306.GF28210@dpotapov.dyndns.org> <200809141948.07160.jnareb@gmail.com> <20080914194802.GH28210@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Alexey Mahotkin <squadette@gmail.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 23:07:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Keyp2-0004Su-1X
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 23:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249AbYINVGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 17:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754188AbYINVGt
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 17:06:49 -0400
Received: from george.spearce.org ([209.20.77.23]:60681 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064AbYINVGs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 17:06:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 14E273835F; Sun, 14 Sep 2008 21:06:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080914194802.GH28210@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95862>

Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Sun, Sep 14, 2008 at 07:48:05PM +0200, Jakub Narebski wrote:
> > 
> > [...] if it is possible
> > using current hooks infrastructure to restrict changes coming from
> > some account in such a way as to allow it only if all changes are
> > restricted to specified directory. 
> 
> I believe the update hook should be able to do that. You have oldrev and
> newrev, so you can run "git diff --name-only oldrev newrev" and see what
> files are going to change. And then verify that the user has the write
> access to this directories or files.
> 
> I have not tried it yet, and I don't think we have a ready example of
> how to do that, but I believe that the example of the update hook that
> restricts user access based on the target branch can be used as a
> starting point.

contrib/hooks/update-paranoid can do both branch and file path
level restrictions.  I used it at my prior day-job to prevent some
accidental changes from folks who didn't usually need to modify
certain parts of the repository.

-- 
Shawn.
