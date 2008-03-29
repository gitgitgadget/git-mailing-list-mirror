From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: why multiple password prompts?
Date: Sat, 29 Mar 2008 12:48:02 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803291241020.19665@iabervon.org>
References: <alpine.WNT.1.10.0803291141550.11992@znlsyl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paul <lists@pote.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 17:48:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfeEb-0002qP-G2
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 17:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbYC2QsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 12:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbYC2QsG
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 12:48:06 -0400
Received: from iabervon.org ([66.92.72.58]:37101 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752775AbYC2QsE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 12:48:04 -0400
Received: (qmail 32186 invoked by uid 1000); 29 Mar 2008 16:48:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Mar 2008 16:48:02 -0000
In-Reply-To: <alpine.WNT.1.10.0803291141550.11992@znlsyl>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78472>

On Sat, 29 Mar 2008, Paul wrote:

> When I do a simple git-pull over SSH, why does it typically prompt me for my
> SSH password two or three times? And no, I am not inputting it wrong.

In some versions of git, it makes separate connections to find out what 
the remote's state is and to fetch the actual data. A third connection 
should only be needed if there are new tags to fetch, and that would be 
after some of the messages.

One of the changes in the upcoming release is to reduce this to one, 
except for an occasional second one.

	-Daniel
*This .sig left intentionally blank*
