From: Heikki Orsila <shd@modeemi.fi>
Subject: Re: [PATCH] Add SVN->Git conversion example to documentation
Date: Sun, 15 Jun 2008 00:50:48 +0300
Message-ID: <20080614215048.GO10527@jolt.modeemi.cs.tut.fi>
References: <20080614180929.GA26449@zakalwe.fi> <20080614190648.GF29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Heikki Orsila <heikki.orsila@iki.fi>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jun 14 23:52:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7dff-0007FI-4e
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 23:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002AbYFNVvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 17:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754923AbYFNVvd
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 17:51:33 -0400
Received: from mail.cs.tut.fi ([130.230.4.42]:51458 "EHLO mail.cs.tut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754620AbYFNVvc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 17:51:32 -0400
Received: from amavis1.cs.tut.fi (amavis1.cs.tut.fi [130.230.4.69])
	by mail.cs.tut.fi (Postfix) with ESMTP id 35D1D321B;
	Sun, 15 Jun 2008 00:51:29 +0300 (EEST)
Received: from mail.cs.tut.fi ([130.230.4.42])
 by amavis1.cs.tut.fi (amavis1.cs.tut.fi [130.230.4.69]) (amavisd-maia, port 10024)
 with ESMTP id 00816-22; Sun, 15 Jun 2008 00:51:28 +0300 (EEST)
Received: from modeemi.modeemi.cs.tut.fi (modeemi.modeemi.cs.tut.fi [130.230.72.134])
	by mail.cs.tut.fi (Postfix) with ESMTP id 105F6320E;
	Sun, 15 Jun 2008 00:51:18 +0300 (EEST)
Received: from jolt.modeemi.cs.tut.fi (jolt.modeemi.cs.tut.fi [130.230.72.144])
	by modeemi.modeemi.cs.tut.fi (Postfix) with ESMTP id C871322201;
	Sun, 15 Jun 2008 00:50:48 +0300 (EEST)
Received: by jolt.modeemi.cs.tut.fi (Postfix, from userid 16311)
	id BB8A65055F; Sun, 15 Jun 2008 00:50:48 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20080614190648.GF29404@genesis.frugalware.org>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Maia Mailguard 1.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85045>

On Sat, Jun 14, 2008 at 09:06:48PM +0200, Miklos Vajna wrote:
> On Sat, Jun 14, 2008 at 09:09:29PM +0300, Heikki Orsila <heikki.orsila@iki.fi> wrote:
> > +------------------------------------------------------------------------
> > +# Convert all branches of an SVN repository to a Git repository:
> > +
> > +	git svn clone --no-metadata -A authors.txt SVN_URL foo.git
> 
> Don't you need -s here?

It seems not.

> 2) I would mention that one still needs a trick if he/she wants to allow
> others to clone this repo, with something like:
> 
> git config remote.origin.url .
> git config remote.origin.fetch +refs/remotes/tags/*:refs/tags/*
> git config --add remote.origin.fetch +refs/remotes/*:refs/heads/*
> git fetch

Will add.

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
