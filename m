From: Michael Gebetsroither <gebi@sbox.tugraz.at>
Subject: Re: [BUG] git-gui loose object warning every hour
Date: Fri, 20 Jun 2008 02:40:25 +0200
Organization: www.grml.org
Message-ID: <g3eu9p$j8k$2@ger.gmane.org>
References: <g3et71$j8k$1@ger.gmane.org> <20080620003216.GR11793@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 02:41:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Uh4-0001cV-Iq
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 02:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbYFTAkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 20:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbYFTAkj
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 20:40:39 -0400
Received: from main.gmane.org ([80.91.229.2]:53427 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbYFTAkj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 20:40:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K9Ug6-00027v-KZ
	for git@vger.kernel.org; Fri, 20 Jun 2008 00:40:34 +0000
Received: from 84.119.25.105 ([84.119.25.105])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 00:40:34 +0000
Received: from gebi by 84.119.25.105 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 00:40:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 84.119.25.105
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85581>

* Shawn O. Pearce <spearce@spearce.org> wrote:
> Michael Gebetsroither <gebi@sbox.tugraz.at> wrote:

>> The loose object warning from git-gui poped up 3 times in the last 4
>> hours (i've gc'ed the repo every time).
>
> This isn't a per-hour warning.  What's happening is there are loose
> objects which git-gc has not pruned away.  Try running git-prune in
> the repository to decrease the loose object count.

I've clicked yes (to remove the loose objects) on every popup of the
loose object warning dialog.

>> I've already set gc.auto=0 so i do _NOT_ want git to do anything
>> automatically.
>
> Hmm.  Maybe git-gui should look at this flag on startup and if set
> simply not perform the loose object count check.

That would be nice, yes.

cu,
michael
-- 
It's already too late!
