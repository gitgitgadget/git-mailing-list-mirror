From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [RFC PATCH] git-gui: Allow staging multiple lines at once
Date: Thu, 22 Oct 2009 21:51:16 +0200
Message-ID: <20091022195116.GB3944@book.hvoigt.net>
References: <20091019195456.GA11121@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Thu Oct 22 21:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N13gx-0003rn-9v
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 21:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837AbZJVTvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 15:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbZJVTvN
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 15:51:13 -0400
Received: from darksea.de ([83.133.111.250]:43123 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752494AbZJVTvN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 15:51:13 -0400
Received: (qmail 25664 invoked from network); 22 Oct 2009 21:51:16 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 22 Oct 2009 21:51:16 +0200
Content-Disposition: inline
In-Reply-To: <20091019195456.GA11121@unpythonic.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131049>

On Mon, Oct 19, 2009 at 02:54:57PM -0500, Jeff Epler wrote:
> When applying less than a full hunk, it's still often desirable to apply
> a number of consecutive lines.
> 
> This change makes it possible to sweep out a range of lines in the diff view
> with the left mouse button, then right click and "Stage Lines For Commit".
> 
> The selected lines may span multiple hunks.

Thanks a lot! Very nice. I've been planning to implement this sometime
myself but never got around it.

Tested it and it works like a charm. I will include Shawn in the CC: so
he can comment.

cheers Heiko
