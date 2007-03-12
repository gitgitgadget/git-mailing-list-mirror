From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH 0/2] Make gc a builtin.
Date: Mon, 12 Mar 2007 09:36:12 -0400
Message-ID: <20070312133612.GD4372@thunk.org>
References: <11736508181273-git-send-email-jbowes@dangerouslyinc.com> <20070312025736.GA28505@thunk.org> <Pine.LNX.4.63.0703121222350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Bowes <jbowes@dangerouslyinc.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 12 14:36:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQkhN-00020C-VW
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 14:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965544AbXCLNgX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 09:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965574AbXCLNgX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 09:36:23 -0400
Received: from thunk.org ([69.25.196.29]:47339 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965544AbXCLNgW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 09:36:22 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HQkmx-0006tw-27; Mon, 12 Mar 2007 09:42:11 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HQkhA-0006Sk-3k; Mon, 12 Mar 2007 09:36:12 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703121222350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42027>

On Mon, Mar 12, 2007 at 12:23:41PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 11 Mar 2007, Theodore Tso wrote:
> 
> > On Sun, Mar 11, 2007 at 06:06:56PM -0400, James Bowes wrote:
> > > The following two patches make git-gc a builtin command.
> > 
> > What's the advantage in making git-gc a builtin command?
> 
> Portability. Plus, James wanted to get involved in Git development, and 
> building in gc really was the shortest path into that.
> 

I'm not sure I understand the portability argument?  All of the
platforms that git currently supports will handle shell scripts,
right?  

Heck, git-commit is still a shell script, and that's a rather, ah,
fundamental command, isn't it? 

						- Ted
