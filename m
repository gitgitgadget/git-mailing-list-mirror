From: Petr Baudis <pasky@suse.cz>
Subject: Failed git commands and StGIT
Date: Fri, 9 Jun 2006 20:36:23 +0200
Message-ID: <20060609183623.GJ11941@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 09 20:36:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Folq6-0005wY-U2
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 20:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWFISgG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 14:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWFISgG
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 14:36:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5524 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030351AbWFISgE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 14:36:04 -0400
Received: (qmail 3010 invoked by uid 2001); 9 Jun 2006 20:36:23 +0200
To: catalin.marinas@gmail.com
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21537>

  Hi,

  a user at #git just came with a problem with stg refresh - it turned
out that he did not have his environment set up properly, but what is
troublesome that stg refresh just said that "git-commit-tree failed" and
did not show the actual error message - looking at the code, you
probably want to keep fd 3 on the parent process' stderr, that is use
open2, not open3.

  The user has used StGIT 0.9.

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
