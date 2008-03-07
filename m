From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/5] Split-up "unpack_trees()" cleanup series
Date: Thu, 6 Mar 2008 19:13:25 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803061901480.19665@iabervon.org>
References: <cover.1204777699.git.torvalds@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 01:14:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXQDt-0007CK-C5
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 01:14:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761506AbYCGAN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 19:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760279AbYCGAN1
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 19:13:27 -0500
Received: from iabervon.org ([66.92.72.58]:60496 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759711AbYCGAN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 19:13:26 -0500
Received: (qmail 16186 invoked by uid 1000); 7 Mar 2008 00:13:25 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Mar 2008 00:13:25 -0000
In-Reply-To: <cover.1204777699.git.torvalds@linux-foundation.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76437>

On Wed, 5 Mar 2008, Linus Torvalds wrote:

> Ok, here's the patch I sent out earlier, except now it's been split up
> into a series fo five patches (and has some trivial one-liner cleanups
> here and there, mainly to shrink the patches a bit)
> 
> It's a series of five patches:
>  -  Add 'df_name_compare()' helper function
>  - Make 'traverse_tree()' use linked structure rather than 'const char *base'
>  - Add return value to 'traverse_tree()' callback
>  - Make 'traverse_trees()' traverse conflicting DF entries in parallel
>  - Move 'unpack_trees()' over to 'traverse_trees()' interface

This all looks good to me.

	-Daniel
*This .sig left intentionally blank*
