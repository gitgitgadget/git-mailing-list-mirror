From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 2/2] Add a ref log reader class
Date: Fri, 12 Jun 2009 12:52:52 -0700
Message-ID: <20090612195251.GQ16497@spearce.org>
References: <20090607224754.GF16497@spearce.org> <1244482112-5935-1-git-send-email-robin.rosenberg@dewire.com> <1244482112-5935-2-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 21:53:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFCo8-0001jR-J5
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 21:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbZFLTwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 15:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754943AbZFLTwu
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 15:52:50 -0400
Received: from george.spearce.org ([209.20.77.23]:35863 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176AbZFLTwt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 15:52:49 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 175F1381FD; Fri, 12 Jun 2009 19:52:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1244482112-5935-2-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121445>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> This reader allows the caller to the reflog entries for a given ref.
> 
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  .../tst/org/spearce/jgit/lib/ReflogReaderTest.java |  187 ++++++++++++++++++++
>  .../src/org/spearce/jgit/lib/ReflogReader.java     |  181 +++++++++++++++++++
>  .../src/org/spearce/jgit/lib/Repository.java       |    9 +
>  3 files changed, 377 insertions(+), 0 deletions(-)
>  create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReflogReaderTest.java
>  create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/ReflogReader.java

Tests fail, I suspect time zone failure (I am in PST):

  ComparisonFailure: expected:<2009-05-22T[23]:36:40> but was:<2009-05-22T[14]:36:40>
  at org.spearce.jgit.lib.ReflogReaderTest.testReadOneLine(ReflogReaderTest.java:86)

Otherwise, it looks sane to me.

-- 
Shawn.
