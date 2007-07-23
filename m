From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: If NEEDS_LIBICONV is set for Solaris 8, it does not build git
	for me
Date: Mon, 23 Jul 2007 20:51:11 +0200
Message-ID: <20070723185111.GA16085@cip.informatik.uni-erlangen.de>
References: <20070722104045.GF4760@cip.informatik.uni-erlangen.de> <7v8x98qc3k.fsf@assigned-by-dhcp.cox.net> <878x97eznf.fsf@sparse.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, GIT <git@vger.kernel.org>,
	Paul Jakma <paul@clubi.ie>
To: Jason Riedy <ejr@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:51:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID301-0005Tj-NW
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 20:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762353AbXGWSvO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 14:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761686AbXGWSvN
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 14:51:13 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:46625 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760835AbXGWSvN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 14:51:13 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id C28123F41B; Mon, 23 Jul 2007 20:51:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <878x97eznf.fsf@sparse.dyndns.org>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53460>

Hello,

> I didn't even know you could patch 5.8 enough to use that compiler
> version.  I can't imagine what strange combinations of C89 and C99
> features are available.

I even think that Forte 11 was one of the first who supported C99 in the
first place.  However my intention is the following: I build git on
Solaris 5.8 because it works on any system that is 5.8 or higher (5.9,
5.10 and the upcomming 5.11). Good in theory. But not in practice since
they bumped the perl version (I did not thought of that before). With
high probability I could work around that. But at the moment I don't
care that much because I have a build host for every major release of
Solaris and I don't use the perl part of git not that much. However
having git on Solaris is a real pleasure. Together with sudo and vim.

        Thomas
