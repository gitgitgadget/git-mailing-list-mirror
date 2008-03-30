From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: why multiple password prompts?
Date: Sun, 30 Mar 2008 17:56:58 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803301755200.19665@iabervon.org>
References: <alpine.WNT.1.10.0803291141550.11992@znlsyl>  <alpine.LNX.1.00.0803291241020.19665@iabervon.org> <3e8340490803301334g2127451cu6e9dc71eefa6241c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul <lists@pote.com>, git@vger.kernel.org
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 30 23:57:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg5X4-0002EZ-ES
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 23:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbYC3V5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 17:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753897AbYC3V5A
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 17:57:00 -0400
Received: from iabervon.org ([66.92.72.58]:45907 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878AbYC3V47 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 17:56:59 -0400
Received: (qmail 6900 invoked by uid 1000); 30 Mar 2008 21:56:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Mar 2008 21:56:58 -0000
In-Reply-To: <3e8340490803301334g2127451cu6e9dc71eefa6241c@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78516>

On Sun, 30 Mar 2008, Bryan Donlan wrote:

> git.git's master branch seems to be hitting ssh twice fairly reliably...
> [bd@shion git-test] SSH_AUTH_SOCK= ~/src/git/git-pull
> bd@130.111.246.25's password:
> bd@130.111.246.25's password:
> remote: Counting objects: 5, done.
> remote: Compressing objects: 100% (2/2)remote: , done.
> remote: Total 3 (delta 0), reused 0 (delta 0)
> Unpacking objects: 100% (3/3), done.
> From ssh+git://bd@130.111.246.25/home/bd/git-test
>    b0b8450..57a92a7  master     -> origin/master
> Updating b0b8450..57a92a7
> Fast forward
>  fob |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> [bd@shion git-test] ~/src/git/git --version
> git version 1.5.5.rc2
> 
> The remote's still on 1.5.4.4 if it matters...

No, but ~/src/git/git-pull will run the installed git-fetch, not the 
locally built one, IIRC.

	-Daniel
*This .sig left intentionally blank*
