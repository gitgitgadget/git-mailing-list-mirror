From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] RevWalk: Fix RevSort.REVERSE combined with
	RevSort.TOPO
Date: Sun, 7 Sep 2008 14:03:08 -0700
Message-ID: <20080907210308.GA15460@spearce.org>
References: <1220821208-13420-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 23:04:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcRQf-0003OE-EL
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 23:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573AbYIGVDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 17:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755583AbYIGVDJ
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 17:03:09 -0400
Received: from george.spearce.org ([209.20.77.23]:36187 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755571AbYIGVDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 17:03:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 70A5B3835C; Sun,  7 Sep 2008 21:03:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1220821208-13420-1-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95176>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> From: Shawn O. Pearce <sop@google.com>
> 
> The reverse sort was using the initial pending queue, not the
> generator that comes before it in the workflow.  This caused
> a combination of TOPO and REVERSE to return no commits.
> 
> Signed-off-by: Shawn O. Pearce <sop@google.com>

Arrrgh.  Wrong email.

Drop the From and fix the SOB to be:

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
