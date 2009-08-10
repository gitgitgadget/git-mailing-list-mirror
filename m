From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Provide a more JavaBeans-style 'getName' accessor
	for the id Signed-off-by: Alex Blewitt <alex.blewitt@gmail.com>
Date: Mon, 10 Aug 2009 13:59:07 -0700
Message-ID: <20090810205907.GY1033@spearce.org>
References: <1241909854-11498-1-git-send-email-alex.blewitt@gmail.com> <20090810155207.GW1033@spearce.org> <E861EAC5-150C-4CF8-AD0F-EBF15CEAE114@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "robin.rosenberg@dewire.com" <robin.rosenberg@dewire.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alex Blewitt <alex.blewitt@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 22:59:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mabxk-0000AM-3z
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 22:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbZHJU7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 16:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbZHJU7H
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 16:59:07 -0400
Received: from george.spearce.org ([209.20.77.23]:53438 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbZHJU7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 16:59:06 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 30D54381FD; Mon, 10 Aug 2009 20:59:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <E861EAC5-150C-4CF8-AD0F-EBF15CEAE114@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125500>

Alex Blewitt <alex.blewitt@gmail.com> wrote:
> That patch was originally mailed on the 11th May. Has it taken until now 
> to notice the problem, or was the other method added in the last month or 
> so? If I'm to blame, I apologise but didn't note any compile time issues 
> at the time.

Arrgh, you are right, I lost this patch in my inbox, and in the
interm we applied new features to RevTag which added getName there.

> On 10 Aug 2009, at 16:52, "Shawn O. Pearce" <spearce@spearce.org> wrote:
>> Obviously you didn't compile test this in JGit:

Never mind.

>> ./org/spearce/jgit/revwalk/RevTag.java:206: getName() in
>> org.spearce.jgit.revwalk.RevTag cannot override getName() in
>> org.spearce.jgit.lib.AnyObjectId; overridden method is final

I can't apply this patch because getName() on RevTag is already
defined with a different meaning.  :-(

-- 
Shawn.
