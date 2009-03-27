From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: patch series starting with [JGIT PATCH 1/5] Remove dead/unused
	reset method from CountingOutputStream
Date: Fri, 27 Mar 2009 07:55:50 -0700
Message-ID: <20090327145550.GN23521@spearce.org>
References: <1238030515-31768-1-git-send-email-spearce@spearce.org> <200903270911.54571.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marek Zawirski <marek.zawirski@gmail.com>,
	Daniel Cheng <j16sdiz+freenet@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 15:57:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnDUp-0000Gi-Da
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 15:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbZC0Ozw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 10:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbZC0Ozw
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 10:55:52 -0400
Received: from george.spearce.org ([209.20.77.23]:45455 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbZC0Ozw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 10:55:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8CFFB38211; Fri, 27 Mar 2009 14:55:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200903270911.54571.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114902>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> Seems fine. While verifying this I got this error.
> 
> jgit push sftp://me@calhost/home/me/tmp/cb/.git master:master
> 
> Counting objects:       20464
> Compressing objects:    100% (20464/20464)
> Writing objects:        100% (20464/20464)
> fatal: Can't write /home/me/tmp/cb/.git/objects/../HEAD: Failure
> fatal: sftp://me@localhost/home/me/tmp/cb/.git: cannot create HEAD

I can't reproduce this error with sftp://.

At first, it failed to push because my target directory didn't exist.

After I made the target directory, I also had to create below it
"refs", "objects", "objects/pack" in order to get the push to
succeed, and then it went through clean.
 
-- 
Shawn.
