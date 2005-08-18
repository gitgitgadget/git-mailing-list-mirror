From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Subject: [PATCH] Updates to glossary
Date: Thu, 18 Aug 2005 17:17:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508181702051.23242@iabervon.org>
References: <Pine.LNX.4.63.0508182117160.6210@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 23:15:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5riI-0007bd-6q
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 23:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVHRVOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 17:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbVHRVOL
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 17:14:11 -0400
Received: from iabervon.org ([66.92.72.58]:14861 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932448AbVHRVOK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2005 17:14:10 -0400
Received: (qmail 9397 invoked by uid 1000); 18 Aug 2005 17:17:34 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Aug 2005 17:17:34 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508182117160.6210@wgmdd8.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 18 Aug 2005, Johannes Schindelin wrote:

>  tree object::
> -	An object containing a list of blob and/or tree objects.
> -	(A tree usually corresponds to a directory without
> -	subdirectories).
> +	An object containing a list of file names and modes along with refs
> +	to the associated blob and/or tree objects. A tree object is
> +	equivalent to a directory.

Actually, it contains object names, not refs, to be completely precise.
(refs would imply an additional indirection.)

	-Daniel
*This .sig left intentionally blank*
