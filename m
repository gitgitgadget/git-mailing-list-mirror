From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 4/5] Expose the critical receive configuration
	options to JGit
Date: Thu, 2 Oct 2008 15:46:43 -0700
Message-ID: <20081002224643.GR21310@spearce.org>
References: <1222824690-7632-1-git-send-email-spearce@spearce.org> <1222824690-7632-4-git-send-email-spearce@spearce.org> <1222824690-7632-5-git-send-email-spearce@spearce.org> <200810012254.09169.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 00:48:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlWy2-0002FY-4N
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 00:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642AbYJBWqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 18:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755609AbYJBWqp
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 18:46:45 -0400
Received: from george.spearce.org ([209.20.77.23]:54525 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125AbYJBWqo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 18:46:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C86C73835F; Thu,  2 Oct 2008 22:46:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200810012254.09169.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97380>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> 
> The repo configuration setup fails. I'll squash this in

Whoops.  Thanks.
 
> I also noted we try to read ~/.gitconfig which may give us som headaches
> later on.

Oy.  Issue #42 on the issue tracker for it.  We shouldn't be reading
that during the tests.

-- 
Shawn.
