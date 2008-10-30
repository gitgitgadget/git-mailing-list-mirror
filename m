From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: Using the --track option when creating a branch
Date: Thu, 30 Oct 2008 14:52:52 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-10-30-14-52-52+trackit+sam@rfc1149.net>
References: <18696.32778.842933.486171@lisa.zopyra.com>
	<1225343538.10803.9.camel@maia.lan>
	<18697.41702.241183.408377@lisa.zopyra.com>
	<18697.42140.459170.891195@lisa.zopyra.com> <4909A7C4.30507@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 30 14:54:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvXyd-00069A-8e
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 14:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555AbYJ3NxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 09:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754531AbYJ3NxE
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 09:53:04 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:38901 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbYJ3NxD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 09:53:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id CB86011144D;
	Thu, 30 Oct 2008 14:52:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from zoidberg.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SyFY8gyk8Uq4; Thu, 30 Oct 2008 14:52:53 +0100 (CET)
Received: from mail2.rfc1149.net (willow.rfc1149.net [IPv6:2001:6f8:37a:2::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by zoidberg.rfc1149.net (Postfix) with ESMTPS id A38BC110584;
	Thu, 30 Oct 2008 14:52:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 00A5FC40BC;
	Thu, 30 Oct 2008 14:52:53 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3afg6GtwhOK4; Thu, 30 Oct 2008 14:52:52 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id BF866C40BD; Thu, 30 Oct 2008 14:52:52 +0100 (CET)
In-Reply-To: <4909A7C4.30507@op5.se> (Andreas Ericsson's message of "Thu\, 30 Oct 2008 13\:25\:40 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99469>

>>>>> "Andreas" == Andreas Ericsson <ae@op5.se> writes:

Andreas> This particular bikeshed was painted a long time ago, with
Andreas> the consensus going in favour of "git push" pushing all
Andreas> *matching* refspecs.

I still don't understand why this is useful, especially when git push
already has a "--all" option.

I know that I've never had the intent to push all the refs without
thinking about it first. Most of the time, I intend to push only
the current branch I am in.

The current behaviour made me remove the branches I was not actively
on locally, because I would get errors from "git push" all the time
saying that I was not up-to-date in those branches.

Note that the "git pull" issue is completely different, as it merges
or fast forwards the current branch only.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
