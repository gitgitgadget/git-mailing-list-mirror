From: Adam Spiers <git@adamspiers.org>
Subject: git-icing: sugary wrapper around git-cherry
Date: Sat, 27 Apr 2013 14:21:19 +0100
Message-ID: <20130427132118.GA25295@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 27 15:21:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW548-0002vd-Pe
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 15:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324Ab3D0NVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 09:21:21 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:36547 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935Ab3D0NVU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 09:21:20 -0400
Received: from localhost (b.e.f.2.d.7.2.8.6.2.c.b.e.a.d.1.0.d.3.7.6.a.1.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:11a6:73d0:1dae:bc26:827d:2feb])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 4B18758EB2
	for <git@vger.kernel.org>; Sat, 27 Apr 2013 14:21:19 +0100 (BST)
Content-Disposition: inline
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222644>

Hi all,

I just wrote a wrapper around git cherry which adds a splash of
colour, and facilitates exclusion of commits which should never be
upstreamed, by using a git-notes(1) namespace as a blacklist.

It's just a quick hack and Ruby probably won't be to everyone's taste,
but I thought I'd mention it just in case it's of use / interest.

    https://github.com/aspiers/git-config/blob/master/bin/git-icing

I'm not sure whether it would make sense to move this functionality
into git cherry itself.  Adding (optional) colour support would bring
it in line with some of the other porcelain, I suppose.

There are other git utilities in that repository which may also be of
interest:

    https://github.com/aspiers/git-config/blob/master/README.md

(I do not claim that any of them are beautiful code, but they work for
me ;-)

Regards,
Adam
