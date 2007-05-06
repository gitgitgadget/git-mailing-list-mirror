From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Document the fact that commit -a is the way to go for
 simple operations
Date: Sun, 06 May 2007 19:07:48 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705061904050.24220@xanadu.home>
References: <11784859173386-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon May 07 01:08:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkpps-0008Md-Eo
	for gcvg-git@gmane.org; Mon, 07 May 2007 01:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbXEFXHy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 19:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbXEFXHy
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 19:07:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44885 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbXEFXHx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 19:07:53 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHN007YG6X3PN80@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 06 May 2007 19:07:51 -0400 (EDT)
In-reply-to: <11784859173386-git-send-email-Matthieu.Moy@imag.fr>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46393>

On Sun, 6 May 2007, Matthieu Moy wrote:

> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  Documentation/git-commit.txt |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 2895225..d024c03 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -54,7 +54,8 @@ OPTIONS
>  -a|--all::
>  	Tell the command to automatically stage files that have
>  	been modified and deleted, but new files you have not
> -	told git about are not affected.
> +	told git about are not affected.  You should use it for most
> +        trivial operations.

I don't think this patch is worth it.  If anything it might create more 
confusion.

There are many ways to commit without -a which still could be considered 
amongst "most trivial operations".


Nicolas
