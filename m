From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: RPM to GIT tree integration?
Date: Fri, 6 Feb 2009 13:29:17 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902061318310.19665@iabervon.org>
References: <b2cdc9f30902060905mb605a93oe8f9cc5795f3e008@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 19:30:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVVTS-00049J-Qx
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 19:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbZBFS3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 13:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbZBFS3T
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 13:29:19 -0500
Received: from iabervon.org ([66.92.72.58]:38195 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbZBFS3T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 13:29:19 -0500
Received: (qmail 32500 invoked by uid 1000); 6 Feb 2009 18:29:17 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Feb 2009 18:29:17 -0000
In-Reply-To: <b2cdc9f30902060905mb605a93oe8f9cc5795f3e008@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108767>

On Fri, 6 Feb 2009, Alex Bennee wrote:

> Hi,
> 
> This is a wild shot in the dark but I thought I'd better ask in case
> some one has. Has anyone created a script/tool that can take a src RPM and
> apply it's patches (in sequence) to an existing GIT tree?

I haven't heard of one, but it would probably be easy to do with 
git-fast-import; you could take a look at 
contrib/fast-import/import-tars.perl.

> In my case I just want a GIT tree for a vendor kernel. I could just
> prep an SRC RPM and commit the thing wholesale into GIT and start
> hacking but then I'd loose all the history benefits.

I think the biggest benefit would actually be identifying the upstream 
kernel that has the patches applied to it, which takes a certain amount of 
inspection and familiarity with Linus's kernel repository, but not really 
a tool.

	-Daniel
*This .sig left intentionally blank*
