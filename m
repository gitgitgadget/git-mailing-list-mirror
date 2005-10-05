From: Andy Isaacson <adi@hexapodia.org>
Subject: clone: I'm only doing a max of 256 requests
Date: Wed, 5 Oct 2005 12:13:00 -0700
Message-ID: <20051005191300.GC17475@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 05 21:15:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENEhO-0008Bd-WF
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 21:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbVJETNB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 15:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbVJETNB
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 15:13:01 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:17474 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S965070AbVJETNB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 15:13:01 -0400
Received: by straum.hexapodia.org (Postfix, from userid 22448)
	id 98F4F258; Wed,  5 Oct 2005 12:13:00 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9726>

Trying to do a local clone of the linux-mips.org git repo:

% git clone /home/adi/linux/git/lmo/linux foo
defaulting to local storage area
fatal: I'm only doing a max of 256 requests
% git -v
git version 0.99.8.GIT

I got git/lmo/linux from http://www.linux-mips.org/pub/scm/linux.git.

Am I doing something wrong, or what?  (And how should I be starting to
debug this?  The git programs don't seem to have a useful --verbose
option.  It would be nice if "git -v clone" would tell me what it is
doing.)

-andy
