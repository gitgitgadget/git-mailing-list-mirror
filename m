From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT] Re: blinking test WindowCacheGetTest.testCache_TooSmallLimit
Date: Fri, 24 Jul 2009 15:51:18 -0700
Message-ID: <20090724225118.GZ11191@spearce.org>
References: <85647ef50907220623i2b7e50dal67650a638921ec0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 00:51:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUTbq-0001Cx-2D
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993AbZGXWvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754965AbZGXWvS
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:51:18 -0400
Received: from george.spearce.org ([209.20.77.23]:60919 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919AbZGXWvS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 18:51:18 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D80F9381FD; Fri, 24 Jul 2009 22:51:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <85647ef50907220623i2b7e50dal67650a638921ec0f@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123970>

Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
> The test WindowCacheGetTest.testCache_TooSmallLimit sometimes fails
> (on less than third of runs on Windows) with the following stacktrace:
> 
> junit.framework.AssertionFailedError
> at junit.framework.Assert.fail(Assert.java:47)
> at junit.framework.Assert.assertTrue(Assert.java:20)
> at junit.framework.Assert.assertTrue(Assert.java:27)
> at org.spearce.jgit.lib.WindowCacheGetTest.checkLimits(WindowCacheGetTest.java:112)
> at org.spearce.jgit.lib.WindowCacheGetTest.testCache_TooSmallLimit(WindowCacheGetTest.java:106)
> 
> This happens on Windows and Linux, but I do not know about
> frequency on Linux.

I'd say the frequency on Linux is about 1/6 for me.  I have yet to
be bothered enough to track it down, but its starting to get there.
Maybe I'll try to look at it tomorrow.

-- 
Shawn.
