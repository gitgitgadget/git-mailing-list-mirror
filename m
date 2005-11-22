From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: 2.6.15-rc2 tag
Date: Tue, 22 Nov 2005 15:17:26 -0500
Message-ID: <20051122201726.GB8738@fieldses.org>
References: <20051121212549.GA23213@fieldses.org> <20051122193418.GC5628@fieldses.org> <Pine.LNX.4.64.0511221200340.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 21:21:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eeea4-0006F4-Bu
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 21:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbVKVUR3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 15:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbVKVUR2
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 15:17:28 -0500
Received: from mail.fieldses.org ([66.93.2.214]:41685 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S965165AbVKVUR1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 15:17:27 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.54)
	id 1EeeZy-0002Zc-N1; Tue, 22 Nov 2005 15:17:26 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511221200340.13959@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12573>

On Tue, Nov 22, 2005 at 12:01:08PM -0800, Linus Torvalds wrote:
> On Tue, 22 Nov 2005, J. Bruce Fields wrote:
> >
> > I'm still not getting a 2.6.15-rc2 tag with either git-clone or
> > git-fetch --tags.  Any ideas?  Is the problem with me or with the
> > repository?
> 
> Try using 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> instead. Does that help? 

Yup, thanks.  Is there any reason to ever use http to get to your
repository?

> I don't understand how http:// works (or doesn't), so..

>From a quick look in ethereal, it seems to be fetching

http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/info/refs

which has a list of tags that doesn't include 2.6.15-rc2.  What
generates that file?  Is it broken?

--b.
