From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Hosting from Windows XP.
Date: Mon, 26 Jan 2009 08:31:24 -0800
Message-ID: <20090126163124.GA31810@spearce.org>
References: <c115fd3c0901260827ge5e4b29w871b345da2373f6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 17:33:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRUOR-0001nU-5e
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 17:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbZAZQb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 11:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbZAZQb0
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 11:31:26 -0500
Received: from george.spearce.org ([209.20.77.23]:51210 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbZAZQbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 11:31:25 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id BEF6738210; Mon, 26 Jan 2009 16:31:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <c115fd3c0901260827ge5e4b29w871b345da2373f6b@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107229>

Tim Visher <tim.visher@gmail.com> wrote:
> I'm trying to get git set up for my company.  We're stuck using
> Windows for the foreseeable future so for now I have to host the
> central integration repository out of a Windows box.  I figured the
> easiest way to do this, short of installing cygwin, would be to do a
> simple msysgit install and then run git daemon with the relevant repo
> copied over onto the server.  Then devs could track that repo.
> However, it appears that msysgit does not install git daemon.

git-daemon isn't ported yet, due to its heavy reliance on POSIX
behavior during fork+exec.
 
> I may totally be missing something here, but I don't know what.  Short
> of the question is, how do I host a repo out of Windows?

I think your options are limited to:

- Use Cygwin
- Use a virtual machine running Linux with git inside it
- Use JGit and its daemon

-- 
Shawn.
