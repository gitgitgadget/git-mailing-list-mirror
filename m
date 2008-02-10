From: "Nikita V. Youshchenko" <yoush@debian.org>
Subject: Re: fetching a single commit from remote repo
Date: Sun, 10 Feb 2008 20:17:03 +0300
Message-ID: <200802102017.03879@blacky.localdomain>
References: <1530970.y9vPlhFxz8@yoush.homelinux.org> <alpine.LSU.1.00.0802101644540.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 18:48:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOGHm-000885-HW
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 18:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbYBJRrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 12:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751963AbYBJRri
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 12:47:38 -0500
Received: from zigzag.lvk.cs.msu.su ([158.250.17.23]:59929 "EHLO
	zigzag.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbYBJRri (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 12:47:38 -0500
X-Greylist: delayed 1816 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Feb 2008 12:47:37 EST
Received: from Debian-exim by zigzag.lvk.cs.msu.su with spam-scanned (Exim 4.50)
	id 1JOFnk-0004Bm-Qs
	for git@vger.kernel.org; Sun, 10 Feb 2008 20:17:18 +0300
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	zigzag.lvk.cs.msu.su
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.5 tests=ALL_TRUSTED,BAYES_00 
	autolearn=unavailable version=3.1.7-deb
Received: from ppp85-140-99-143.pppoe.mtu-net.ru ([85.140.99.143] helo=blacky)
	by zigzag.lvk.cs.msu.su with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JOFne-0004BU-Bp; Sun, 10 Feb 2008 20:17:06 +0300
Received: from nikita by blacky with local (Exim 4.63)
	(envelope-from <yoush@debian.org>)
	id 1JOFnb-0003dJ-T7; Sun, 10 Feb 2008 20:17:04 +0300
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LSU.1.00.0802101644540.11591@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73382>

> Hi,
>
> On Sun, 10 Feb 2008, Nikita V. Youshchenko wrote:
> > I'm looking for a way to fetch a single snapshot, without history,
> > from remote git repository.
> >
> > I've found how to do it with a head (clone --depth 1, or fetch --depth
> > 1).
> >
> > Is it possible to do the same with non-head and non-tagged commit, if
> > only sha1 name of the commit is known?
> > Looks like fetch and fetch-pack only take ref names :(
>
> Yes, for security reasons.

I can't understand what security issues this may cause ...

If one has enough access to a repository to clone it, he already has a way 
to download each and every object from there.

Ability to fetch the tree corresponding to particular commit won't add any 
new permissions to him, will it?

I'm looking for a way to get a copy of a particular previous state of the 
project tree, without having to download entire tree. Something similar 
checking out particular svn revision.
This is going to be wrapped into a script, which is intended to be executed 
by people without any knowledge of any VC system at all. Commit id could 
be a parameter for such a script.

Nikita
