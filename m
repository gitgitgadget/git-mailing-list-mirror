From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 1.5.3 plans and preparations
Date: Thu, 2 Aug 2007 10:26:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708021021060.14781@racer.site>
References: <7vfy32z9hv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 11:27:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGWxV-00088W-GL
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 11:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314AbXHBJ0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 05:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754192AbXHBJ0l
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 05:26:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:51393 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753718AbXHBJ0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 05:26:39 -0400
Received: (qmail invoked by alias); 02 Aug 2007 09:26:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 02 Aug 2007 11:26:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18iuy4/UCkiU9gLkL+YVkZ5oZPObD7sVhe4dWY4c/
	bk79WazzpGR8xR
X-X-Sender: gene099@racer.site
In-Reply-To: <7vfy32z9hv.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54529>

Hi,

whew, what a bunch of changes!

On Thu, 2 Aug 2007, Junio C Hamano wrote:

>   - "git-filter-branch" lets you rewrite the revision history of
>     the current branch, creating a new branch. You can specify a
>     number of filters to modify the commits, files and trees.

It is no longer the current branch, not even by default.  You can rewrite 
one or more branches, and you have to specify them.

>   - "git commit --amend" is now compatible with various message source
>     options such as -m/-C/-c/-F.

Urgh.  That makes it much more easy for new users to shoot themselves in 
the foot.  By "-C" and "-F" you do not even see the runstatus anymore, 
since no editor was fired up.  Please say something like "use with care", 
or "do not try this at home", too.

Ciao,
Dscho
