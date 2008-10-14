From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] remote.c: correct the check for a leading '/' in a remote
 name
Date: Tue, 14 Oct 2008 16:35:58 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0810141633321.19665@iabervon.org>
References: <J-KL1Cgc2b78Lced5uBNDhP0MHdg91do73K_0waicFQYbDZHjYkocw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Oct 14 22:37:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpqdp-0004DK-Un
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 22:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbYJNUgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 16:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754017AbYJNUgB
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 16:36:01 -0400
Received: from iabervon.org ([66.92.72.58]:41197 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753838AbYJNUgA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 16:36:00 -0400
Received: (qmail 32498 invoked by uid 1000); 14 Oct 2008 20:35:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Oct 2008 20:35:58 -0000
In-Reply-To: <J-KL1Cgc2b78Lced5uBNDhP0MHdg91do73K_0waicFQYbDZHjYkocw@cipher.nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98209>

On Tue, 14 Oct 2008, Brandon Casey wrote:

> This test is supposed to disallow remote entries in the config file of the
> form:
> 
>    [remote "/foobar"]
>       ...
> 
> The leading slash in '/foobar' is not acceptable.
> 
> Instead it was incorrectly testing that the subkey had no leading '/', which
> had no effect since the subkey pointer was made to point at a '.' in the
> preceding lines.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>

Good catch; looks like I was checking for a mistake that nobody ever 
makes, but it's still good to check.

Acked-by: Daniel Barkalow <barkalow@iabervon.org>
