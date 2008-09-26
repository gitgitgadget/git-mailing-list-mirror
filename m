From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Help identify aspell version on Windows too
Date: Fri, 26 Sep 2008 07:31:19 -0700
Message-ID: <20080926143119.GX3669@spearce.org>
References: <1222378282-21757-1-git-send-email-hendeby@isy.liu.se> <48DC815C.6030401@viscovery.net> <48DCA5F3.4090009@isy.liu.se> <48DCAC08.9060004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 26 16:32:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjEMv-0004D3-7g
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 16:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbYIZObU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 10:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752463AbYIZObU
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 10:31:20 -0400
Received: from george.spearce.org ([209.20.77.23]:46931 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbYIZObT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 10:31:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4CE7F3835F; Fri, 26 Sep 2008 14:31:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48DCAC08.9060004@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96855>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> 
> My situation is this: I fire up git-gui, and because I have some stale
> .git/GITGUI_MSG file, the commit message box is not empty. Aspell begins
> its work, and git-gui correctly marks spelling mistakes in the first line.
> Even if I type new text, delete old text, or change the whole text by
> clicking "Amend", no new spelling mistakes are marked for the whole session.

Hmm.  Sounds to me like aspell crashes and dies after a while.

When aspell terminates on its own git-gui doesn't try to restart it.
I've never seen it abort on my Mac, or my Linux systems.  Or even
on Windows when I was using the Cygwin version of aspell.

-- 
Shawn.
