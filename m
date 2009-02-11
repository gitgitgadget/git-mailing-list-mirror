From: Peter Baumann <waste.manager@gmx.de>
Subject: How to use path limiting (using a glob)?
Date: Wed, 11 Feb 2009 20:14:32 +0100
Message-ID: <20090211191432.GC27232@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 20:15:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXKYl-0002O9-N9
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 20:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbZBKTOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 14:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbZBKTOT
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 14:14:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:48851 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750793AbZBKTOS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 14:14:18 -0500
Received: (qmail invoked by alias); 11 Feb 2009 19:14:06 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp060) with SMTP; 11 Feb 2009 20:14:06 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+iLqke9ceiDgO9+E5Gb/RkPmwCzoFBoRjKYdt7IK
	FKrY7IAfAg/Sye
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id CCB551997B; Wed, 11 Feb 2009 20:14:32 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109506>

Hallo,

after reading Junio's nice blog today where he explained how to use git grep
efficiently, I saw him using a glob to match for the interesting files:

	 $ git grep -e ';;' -- '*.c'

Is it possible to have the same feature in git diff and the revision
machinery? Because I tried

	$ cd $path_to_your_git_src_dir
	$ git log master -p -- '*.h'
	.... No commit shown 

	$ git diff --name-only v1.5.0  v1.6.0 -- '*.c'

and both don't return anything.

Grettings,
Peter Baumann
