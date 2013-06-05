From: Andreas Krey <a.krey@gmx.de>
Subject: Re: git-daemon: needs /root/.config/git/config?
Date: Wed, 5 Jun 2013 13:43:59 +0200
Message-ID: <20130605114359.GA1675@inner.h.apk.li>
References: <20130604141314.GD22308@pomac.netswarm.net> <20130604160815.GB15953@sigill.intra.peff.net> <20130605111918.GE22308@pomac.netswarm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ian Kumlien <pomac@vapor.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 13:44:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkC8Z-000758-Ut
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 13:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120Ab3FELoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 07:44:13 -0400
Received: from continuum.iocl.org ([217.140.74.2]:51919 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab3FELoK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 07:44:10 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r55BhxY03429;
	Wed, 5 Jun 2013 13:43:59 +0200
Content-Disposition: inline
In-Reply-To: <20130605111918.GE22308@pomac.netswarm.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226447>

On Wed, 05 Jun 2013 13:19:18 +0000, Ian Kumlien wrote:
...
> Well, I have no idea of how to control HOME in xinetd - access to the
> machine is limited and x doesn't give that much access (nothing really
> important is actually stored in /root)

Make xinetd execute '/usr/bin/env HOME=/home/yourstruly git ...'
instead of 'git ...'.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
