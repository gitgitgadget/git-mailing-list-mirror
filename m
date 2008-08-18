From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Enable diff=java for all *.java source files
Date: Sun, 17 Aug 2008 22:49:37 -0700
Message-ID: <20080818054937.GC7376@spearce.org>
References: <1218814822-23307-1-git-send-email-spearce@spearce.org> <200808180738.21572.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 07:50:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUxdb-0006t1-CG
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 07:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbYHRFti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 01:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbYHRFti
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 01:49:38 -0400
Received: from george.spearce.org ([209.20.77.23]:48473 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbYHRFth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 01:49:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6547A38375; Mon, 18 Aug 2008 05:49:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200808180738.21572.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92683>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > diff --git a/.gitattributes b/.gitattributes
> > new file mode 100644
> > index 0000000..f57840b
> > --- /dev/null
> > +++ b/.gitattributes
> > @@ -0,0 +1 @@
> > +*.java diff=java
> 
> Is there any reason this isn't the default in git?

Because uh.  Nobody submitted a patch to make it the default?

It does seem like it would be a good idea to make it the default.
Its unlikely the C function header pattern is ever going to produce a
more reasonable hunk header for a *.java file than the Java pattern.

-- 
Shawn.
