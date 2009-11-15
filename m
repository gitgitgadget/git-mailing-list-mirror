From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Nov 2009, #03; Sun, 15)
Date: Sun, 15 Nov 2009 17:26:51 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911151711170.14365@iabervon.org>
References: <7vtywwm6i4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 23:27:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9nYh-0001Cd-94
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 23:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbZKOW0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 17:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbZKOW0q
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 17:26:46 -0500
Received: from iabervon.org ([66.92.72.58]:51043 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbZKOW0p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 17:26:45 -0500
Received: (qmail 2968 invoked by uid 1000); 15 Nov 2009 22:26:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Nov 2009 22:26:51 -0000
In-Reply-To: <7vtywwm6i4.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132970>

On Sun, 15 Nov 2009, Junio C Hamano wrote:

> * sr/vcs-helper (2009-11-06) 12 commits
>  - Add Python support library for remote helpers
>  - Basic build infrastructure for Python scripts
>  - Allow helpers to request the path to the .git directory
>  - Allow helpers to report in "list" command that the ref is unchanged
>  - Allow helper to map private ref names into normal names
>  - Add support for "import" helper command
>  - Allow specifying the remote helper in the url
>  - Add a config option for remotes to specify a foreign vcs
>  - Allow fetch to modify refs
>  - Use a function to determine whether a remote is valid
>  - Allow programs to not depend on remotes having urls
>  - Fix memory leak in helper method for disconnect
> 
> Re-rolled series that contains Daniel's and Johan's.
> Any comments?  Is everybody happy?

My initial cleanup for "Allow helper to map private ref names into normal 
names" was wrong (and the original was supposed to be RFC, and isn't 
signed-off); I identified the bug he reported in it, but haven't gotten 
positive test results from him yet, and the series obviously needs a 
proper version rolled in before it goes into next.

	-Daniel
*This .sig left intentionally blank*
