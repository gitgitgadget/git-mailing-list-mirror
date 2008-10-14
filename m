From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: EGIT compare editor
Date: Tue, 14 Oct 2008 08:05:01 -0700
Message-ID: <20081014150501.GD4856@spearce.org>
References: <48F4AA33.40605@oanda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chris Dumoulin <dumoulin@oanda.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 17:12:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KplTT-0005Aj-Qo
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 17:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbYJNPFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 11:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbYJNPFD
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 11:05:03 -0400
Received: from george.spearce.org ([209.20.77.23]:60457 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbYJNPFD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 11:05:03 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0329738360; Tue, 14 Oct 2008 15:05:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48F4AA33.40605@oanda.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98191>

Chris Dumoulin <dumoulin@oanda.com> wrote:
> I seem to have successfully installed EGIT in Eclipse 3.4.1, but I can't  
> figure out how to bring up the compare editor to view diffs.
>
> I expect that after right-clicking on a changed file, I would have some  
> option under "Compare With" or "Team" that would allow me to diff the  
> current file against the HEAD or some other revision using the compare  
> editor, but I can't seem to find any way to do this. How do I bring up  
> the compare editor to view diffs?

Robin knows the Eclipse integration better than I, but we may be
missing the feature to compare the working directory revision to
the last committed revision (or the index revision).

I'm pretty sure the compare editor is available in the History view
(Team -> Show resource in History) by double clicking the file
path when a commit node is selected.  But that's obviously only
historical diffs.

-- 
Shawn.
