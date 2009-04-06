From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT] [PATCH RFC v1 0/5] Add (static) ignore functionality to
	EGit
Date: Mon, 6 Apr 2009 10:03:26 -0700
Message-ID: <20090406170326.GI23604@spearce.org>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl> <20090405210248.GA23604@spearce.org> <49DA3305.7090601@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Mon Apr 06 19:07:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqsFo-0000p9-KS
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 19:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbZDFRD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 13:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbZDFRD2
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 13:03:28 -0400
Received: from george.spearce.org ([209.20.77.23]:59175 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbZDFRD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 13:03:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A4D1938211; Mon,  6 Apr 2009 17:03:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49DA3305.7090601@pelagic.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115856>

"Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl> wrote:
> Shawn O. Pearce wrote:
> > JGit and EGit are holding the line on Java 5 support; that means
> > that String.isEmpty() must be spelled as String.length() == 0
> > (isEmpty was added in Java 6).
> 
> just looked in the project settings for org.spearce.egit.core and it has
> java 1.5 style specified _and_ eclipse does not give me a warning on the
> *.isEmpty() calls. Am i missing something here?

Your workspace default JRE must be set to a Java 6.  Switch it to
Java 5 in the workspace settings.

-- 
Shawn.
