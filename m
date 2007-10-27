From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 5/8] push, send-pack: support pushing HEAD to real ref
 name
Date: Sat, 27 Oct 2007 18:03:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710271756140.7345@iabervon.org>
References: <119350380778-git-send-email-prohaska@zib.de>
 <11935038081211-git-send-email-prohaska@zib.de> <11935038081650-git-send-email-prohaska@zib.de>
 <1193503808519-git-send-email-prohaska@zib.de> <11935038083369-git-send-email-prohaska@zib.de>
 <11935038084055-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 00:03:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iltkj-0001Jp-1c
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 00:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbXJ0WDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 18:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbXJ0WDU
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 18:03:20 -0400
Received: from iabervon.org ([66.92.72.58]:55399 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbXJ0WDU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 18:03:20 -0400
Received: (qmail 25969 invoked by uid 1000); 27 Oct 2007 22:03:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Oct 2007 22:03:18 -0000
In-Reply-To: <11935038084055-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62514>

On Sat, 27 Oct 2007, Steffen Prohaska wrote:

> This teaches "push <remote> HEAD" to resolve HEAD on the local
> side to its real ref name, e.g. refs/heads/master, and then
> use the real ref name on the remote side to search a matching
> remote ref.

I'd prefer this to be in set_refspecs in builtin-push. That way, it only 
applies to command-line arguments and matches your description better. (If 
you use a symbolic name on the command line, it follows it, and acts 
exactly as if you used the name it points to).

	-Daniel
*This .sig left intentionally blank*
