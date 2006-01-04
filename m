From: Darrin Thompson <darrint@progeny.com>
Subject: git-ls-files -o no recurse?
Date: Wed, 04 Jan 2006 13:51:32 -0500
Message-ID: <1136400692.5919.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 04 19:51:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuDja-0004lp-7p
	for gcvg-git@gmane.org; Wed, 04 Jan 2006 19:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbWADSvj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jan 2006 13:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965267AbWADSvj
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jan 2006 13:51:39 -0500
Received: from zealot.progeny.com ([216.37.46.162]:21481 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S965266AbWADSvi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2006 13:51:38 -0500
Received: from localhost.localdomain (morimoto.progeny.com [192.168.1.53])
	by morimoto.progeny.com (Postfix) with ESMTP id 55A506378E
	for <git@vger.kernel.org>; Wed,  4 Jan 2006 13:51:32 -0500 (EST)
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14179>

git-ls-files -o reports _all_ the unknown files it finds in a work area.
Subversion and probably other systems "simply ignore all the files 
and directories inside an unknown directory and just note the directory
as unknown." (A quote from my porcelain's mailing list.)

I'd like to make this friendly behavior the default in my porcelain.
Unfortunately, getting the same result from a porcelain requires
implementing a non-trivial algorithm to discover common prefixes, worry
about performance on large projects, etc.

Would it be hard to make git-ls-files optionally do this?

--
Darrin
