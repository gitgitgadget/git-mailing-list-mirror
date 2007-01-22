From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: commit message columns
Date: Mon, 22 Jan 2007 16:23:59 -0500
Message-ID: <20070122212359.GC29975@spearce.org>
References: <20070122211902.GC6614@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 22:28:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H96e8-0007AV-2T
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 22:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbXAVVYF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 16:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932794AbXAVVYE
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 16:24:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40667 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932787AbXAVVYD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 16:24:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H96ds-0007vi-FL; Mon, 22 Jan 2007 16:23:52 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B528720FBAE; Mon, 22 Jan 2007 16:23:59 -0500 (EST)
To: "J. Bruce Fields" <bfields@fieldses.org>
Content-Disposition: inline
In-Reply-To: <20070122211902.GC6614@fieldses.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37458>

"J. Bruce Fields" <bfields@fieldses.org> wrote:
> Uh, I feel like I must be missing something simple here--when editing
> commit messages, you'd like the editor (vim in my case) to wrap text
> sooner than it normally would, since commit messages are displayed
> indented.  What's the easiest way to ensure this always happens?

<shameless-plug>
Use git-gui.  The message buffer window doesn't linewrap nor does
it scroll, so you learn to linewrap on your own.  :-)
</shameless-plug>

When I'm not in git-gui I use vile and have a macro in it to
pass the current paragraph of text through:

  fmt --crown-margin --width=70 --uniform-spacing

works reasonably well.

-- 
Shawn.
