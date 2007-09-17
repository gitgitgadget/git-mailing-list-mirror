From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: List of bugs and suggestions
Date: Tue, 18 Sep 2007 00:26:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709180023060.28586@racer.site>
References: <20070917225441.GA32647@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT list <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 01:27:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXPzm-0001MP-Pi
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 01:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654AbXIQX1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 19:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754454AbXIQX1J
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 19:27:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:45067 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754422AbXIQX1H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 19:27:07 -0400
Received: (qmail invoked by alias); 17 Sep 2007 23:27:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 18 Sep 2007 01:27:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/s7BoxMeXs2GlVRv+6/ALSjAH+6JYH2YQxFd8bcl
	AhMh5E0hqg9xM2
X-X-Sender: gene099@racer.site
In-Reply-To: <20070917225441.GA32647@nan92-1-81-57-214-146.fbx.proxad.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58497>

Hi,

On Tue, 18 Sep 2007, Yann Dirson wrote:

> 	stash:
> 
> - "git stash show junk" acts like "git stash show"
> 
> - changes stashed in the index are unstashed only in workdir.  If that's 
> intended, a note in the "stash apply" doc would be useful; but then I am 
> left puzzled as to the usefulness of storing the index state in the 
> stash branch: it could surely be applied by a variant of "stash apply", 
> but such a command does not seem to exist yet ?

It does, but it is not documented: "git stash apply --index".

> 	misc git:
> 
> - git has problems with cascaded alternates that use relative paths.

Known error, Pasky has lamented about that already.  I think we could get 
away with using make_absolute_path() cleverly.

Ciao,
Dscho
