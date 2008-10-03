From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Broken index file - any hope?
Date: Fri, 3 Oct 2008 15:07:50 -0700
Message-ID: <20081003220750.GY21310@spearce.org>
References: <48E693E9.708@gmx.de> <20081003215319.GX21310@spearce.org> <48E696CB.6040405@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonas Schneider <JonasSchneider@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 04 00:10:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlspZ-0005l3-C3
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 00:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbYJCWHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 18:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752740AbYJCWHv
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 18:07:51 -0400
Received: from george.spearce.org ([209.20.77.23]:39143 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbYJCWHv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 18:07:51 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5B9E93835F; Fri,  3 Oct 2008 22:07:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48E696CB.6040405@gmx.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97458>

Jonas Schneider <JonasSchneider@gmx.de> wrote:
> Shawn O. Pearce schrieb:
>>   git read-tree --reset HEAD
> Sadly, this doesnt help. I still get the same error.
> But, if I remove the corrupt index file, I get this:
>
> fatal: just how do you expect me to merge 0 trees?

Yea, so that sounds like "git log" doesn't work because HEAD isn't
pointing at a valid branch.

> Does not look like a good sign :/
> Are all my branches (branch==tree?) gone? (okay, werent that much)

Yes, a branch contains a series of trees.  The current tree of a
branch is the tree of the most recent commit on that branch.

They may be gone.

-- 
Shawn.
