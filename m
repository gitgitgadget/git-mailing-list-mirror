From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 0/9] List commonly used (or recognized) commands
Date: Fri, 25 Jul 2008 14:52:11 -0500
Message-ID: <20080725195211.GF21117@spearce.org>
References: <1217015167-4680-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:53:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMTLk-0007RI-Fx
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbYGYTwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 15:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbYGYTwM
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:52:12 -0400
Received: from george.spearce.org ([209.20.77.23]:57426 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbYGYTwM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 15:52:12 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5D4CF383A5; Fri, 25 Jul 2008 19:52:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1217015167-4680-1-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90107>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> This series adds support to jgit to list commonly used subcommands
> if the user just executes `jgit` with no subcommand requested:
> 
>   $ jgit
>   jgit --git-dir GIT_DIR --help (-h) --show-stack-trace command [ARG ...]
>   
>   The most commonly used commands are:
>    fetch  Update remote refs from another repository
>    log    View commit history
>    push   Update remote repository from local refs
>    tag    Create a tag

Scratch that.  This series is busted if you install jgit and actually
try to use it.  No subcommands get registered.  I suspect it is due
to the shell script+ZIP file we have in the CLASSPATH confusing the
JRE and making it impossible to read correctly.

-- 
Shawn.
