From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 1 Jan 2007 16:40:23 -0500
Message-ID: <20070101214023.GB23857@fieldses.org>
References: <11676088584199-git-send-email-bfields@fieldses.org> <1167608858759-git-send-email-bfields@fieldses.org> <11676088582634-git-send-email-bfields@fieldses.org> <7vd55zd1nm.fsf@assigned-by-dhcp.cox.net> <7vwt47bjwa.fsf@assigned-by-dhcp.cox.net> <20070101213906.GA23857@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 01 22:40:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1UtR-0007lT-FJ
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 22:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbXAAVkZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 16:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbXAAVkZ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 16:40:25 -0500
Received: from mail.fieldses.org ([66.93.2.214]:34694 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932573AbXAAVkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 16:40:25 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H1UtL-0006uy-5L; Mon, 01 Jan 2007 16:40:23 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20070101213906.GA23857@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35746>

On Mon, Jan 01, 2007 at 04:39:06PM -0500, J. Bruce Fields wrote:
> On Sun, Dec 31, 2006 at 05:44:37PM -0800, Junio C Hamano wrote:
> > How about doing this?  The difference this time around is that
> > if you have non-wildcard refspec listed first, which usually
> > is the case for people with established git workflow with
> > existing repositories, we use the old-and-proven rule to
> > merge the first set of refs.  An earlier round botched this
> > completely by basing the logic on lack of branch.*.merge,
> > which broke for many people.
> 
> Updated man page assuming that change; does this look any better?

Also, resend of the following patch:

--b.

[PATCH] Documentation: remove master:origin example from pull-fetch-param.txt

This is no longer a useful example.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/pull-fetch-param.txt |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index e852f41..8d4e950 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -39,10 +39,6 @@ checkout -b my-B remote-B`).  Run `git fetch` to keep track of
 the progress of the remote side, and when you see something new
 on the remote branch, merge it into your development branch with
 `git pull . remote-B`, while you are on `my-B` branch.
-The common `Pull: master:origin` mapping of a remote `master`
-branch to a local `origin` branch, which is then merged to a
-local development branch, again typically named `master`, is made
-when you run `git clone` for you to follow this pattern.
 +
 [NOTE]
 There is a difference between listing multiple <refspec>
-- 
1.5.0.rc0.gac28
