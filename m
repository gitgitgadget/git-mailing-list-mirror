From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: why multiple password prompts?
Date: Sat, 29 Mar 2008 15:05:34 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803291418120.19665@iabervon.org>
References: <alpine.WNT.1.10.0803291141550.11992@znlsyl> <alpine.LNX.1.00.0803291241020.19665@iabervon.org> <m37iflv54l.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul <lists@pote.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 20:06:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfgNw-0001sW-TJ
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 20:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958AbYC2TFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 15:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbYC2TFn
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 15:05:43 -0400
Received: from iabervon.org ([66.92.72.58]:52368 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753921AbYC2TFm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 15:05:42 -0400
Received: (qmail 11279 invoked by uid 1000); 29 Mar 2008 19:05:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Mar 2008 19:05:34 -0000
In-Reply-To: <m37iflv54l.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78479>

On Sat, 29 Mar 2008, Jakub Narebski wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Sat, 29 Mar 2008, Paul wrote:
> 
> Paul who?

How should I know?

> >> When I do a simple git-pull over SSH, why does it typically prompt
> >> me for my SSH password two or three times? And no, I am not
> >> inputting it wrong.
> > 
> > In some versions of git, it makes separate connections to find out
> > what the remote's state is and to fetch the actual data. A third
> > connection should only be needed if there are new tags to fetch, and
> > that would be after some of the messages.
> > 
> > One of the changes in the upcoming release is to reduce this to one,
> > except for an occasional second one.
> 
> The way to avoid multiple prompt for SSH password is to set up SSH key
> infrastructure, so you can login using SSH keys which does not require
> you to enter password, with the possible exception of adding key to
> keyring if it is protected by password.

Sure, but it's inconvenient to wrap git-fetch and git-pull in 
ssh-agent/ssh-add/kill if you want to get exactly one password prompt per 
logical remote-using operation. Personally, I like that when I 
do operations involving authorized access to a remote machine, I need to 
enter my password. But once per command is all I want.

	-Daniel
*This .sig left intentionally blank*
