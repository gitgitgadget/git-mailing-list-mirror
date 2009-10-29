From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [RFC PATCH v2 0/2] git-gui: (un)stage a range of changes at
	once
Date: Thu, 29 Oct 2009 08:34:54 +0100
Message-ID: <20091029073454.GA25843@m62s10.vlinux.de>
References: <1256160023-29629-1-git-send-email-jepler@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 08:35:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3PXT-0003Jf-0B
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 08:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589AbZJ2Hey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 03:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756641AbZJ2Hey
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 03:34:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:37498 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754356AbZJ2Hex (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 03:34:53 -0400
Received: (qmail invoked by alias); 29 Oct 2009 07:34:56 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp029) with SMTP; 29 Oct 2009 08:34:56 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18zrJIk/+Ez7N9LemaRera4Aqh+E48qIIps9ECRiE
	72I2k6quLqv4wO
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 61BAC8C033; Thu, 29 Oct 2009 08:34:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1256160023-29629-1-git-send-email-jepler@unpythonic.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131567>

On Wed, Oct 21, 2009 at 04:20:21PM -0500, Jeff Epler wrote:
> Compared to the first version, I fixed a bug concerning staging line(s)
> when all following lines are deletions (a preexisting bug in git-gui).
> This version is made based off the master branch of git-gui.git, rather
> than the master branch of git.git.
> 
> The first change fixes a long-standing git-gui bug in an area that the
> new feature is rewriting anyway.  If there's interest in the new feature
> then maybe the two should just be squashed (using the message from the
> second).  If not, it'd be nice to see the bugfix applied anyway.
> 
> 
> Jeff Epler (2):
>   Fix applying a line when all following lines are deletions
>   Make it possible to apply a range of changes at once
> 
>  git-gui.sh   |   15 +++-
>  lib/diff.tcl |  224 ++++++++++++++++++++++++++++++++--------------------------
>  2 files changed, 135 insertions(+), 104 deletions(-)

Cc ing Shawn as the git gui maintainer, as he might have missed this series
during his away time.

The original series including user comments can be found at

	http://thread.gmane.org/gmane.comp.version-control.git/130732

whereas the newest version is here:

	http://thread.gmane.org/gmane.comp.version-control.git/130968

--
Peter
