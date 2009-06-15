From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/7] Move hex parsing functions to RawParseUtil,
	accept upper case
Date: Mon, 15 Jun 2009 07:36:04 -0700
Message-ID: <20090615143604.GA10817@spearce.org>
References: <1244151843-26954-1-git-send-email-spearce@spearce.org> <1244151843-26954-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 16:36:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGDIP-0001mq-7w
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 16:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758067AbZFOOgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 10:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757398AbZFOOgD
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 10:36:03 -0400
Received: from george.spearce.org ([209.20.77.23]:47174 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755414AbZFOOgC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 10:36:02 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id AB67F381FE; Mon, 15 Jun 2009 14:36:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1244151843-26954-2-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121610>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> This way we can reuse them beyond just the ObjectId family of classes.
> 
> We also now accept upper case hex digits in object ids.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  .../tst/org/spearce/jgit/lib/T0001_ObjectId.java   |   10 ++-
>  .../org/spearce/jgit/lib/AbbreviatedObjectId.java  |    8 +-
>  .../src/org/spearce/jgit/lib/AnyObjectId.java      |   36 ---------
>  .../src/org/spearce/jgit/lib/MutableObjectId.java  |   11 ++-
>  .../src/org/spearce/jgit/lib/ObjectId.java         |   19 +++--
>  .../src/org/spearce/jgit/util/RawParseUtils.java   |   80 ++++++++++++++++++--
>  6 files changed, 101 insertions(+), 63 deletions(-)

Ping on this 7 patch series?  Looks like it got dropped?  Its the
last outstanding current work I have that I think is ready for
merging to master.
 
-- 
Shawn.
