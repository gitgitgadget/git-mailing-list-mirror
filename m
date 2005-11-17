From: Martin Atukunda <matlads@dsmagic.com>
Subject: Re: [PATCH] Add .git/version
Date: Thu, 17 Nov 2005 22:08:48 +0300
Message-ID: <20051117190848.GA5745@igloo.ds.co.ug>
References: <11322339372137-git-send-email-matlads@dsmagic.com> <200511171644.48438.Josef.Weidendorfer@gmx.de> <437CB0CA.6070306@op5.se> <200511171741.23147.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 17 20:12:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecp8P-0005xL-U1
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 20:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbVKQTJW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 14:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbVKQTJW
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 14:09:22 -0500
Received: from metronet39.infocom.co.ug ([217.113.73.39]:62981 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP id S932486AbVKQTJW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 14:09:22 -0500
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id 5A5895160
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 22:10:58 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.54)
	id 1Ecp7o-0001av-LV
	for git@vger.kernel.org; Thu, 17 Nov 2005 22:08:48 +0300
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200511171741.23147.Josef.Weidendorfer@gmx.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12137>

On Thu, Nov 17, 2005 at 05:41:23PM +0100, Josef Weidendorfer wrote:
> On Thursday 17 November 2005 17:33, Andreas Ericsson wrote:
> > > Why? Ideally, the git commands first should check if they can handle the
> > > repository format. If they can not handle the version, they should bail
> > > out with an error [*]
> > > Now suppose we want to release Git 2 without change the repository
> > > format at all. Thus, even if Git 1 tool *would* work with repositories
> > > created by Git 2, they will fail in the version check!
> > > 
> > 
> > Not that I have an opinion on these changes, but Netscape 7 still 
> > handles HTTP 1.1. Just because we up the major-number for git doesn't 
> > mean we have to do the same for the repository format version.
> 
> Of course we do not want that.
> My comment was about this, as the proposed patch installed a
> .git/version file with the git version in it, which would lead to
> this strange result.
> 
I agree, I'll resubmit a patch to create a .git/version file that simply
says 1.

which specific git commands would most likely want to know about the
version of the repo format? I could look at them to see what needs to be
changed so that they don't corrupt a repo, or as Johannes said, the use
of this file would become handy only when an incompatible change is
made. In which case, init-db.c just creates it for now, as a simple safe
guard.

- Martin -

-- 
Due to a shortage of devoted followers, the production of great leaders has been discontinued.
