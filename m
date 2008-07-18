From: Jonathan Corbet <corbet@lwn.net>
Subject: gitdm v0.10 available
Date: Fri, 18 Jul 2008 15:46:57 -0600
Organization: LWN.net
Message-ID: <20080718154657.7ff0cf9e@bike.lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Cc: Greg KH <greg@kroah.com>
To: LKML <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 23:47:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJxny-0003JU-V9
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 23:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345AbYGRVrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 17:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbYGRVq7
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 17:46:59 -0400
Received: from vena.lwn.net ([206.168.112.25]:54904 "EHLO vena.lwn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932AbYGRVq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 17:46:59 -0400
Received: from bike.lwn.net (jon-dsl [199.45.162.133])
	by vena (Postfix) with ESMTP id 92BD316C766;
	Fri, 18 Jul 2008 15:46:58 -0600 (MDT)
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.13.4; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89081>

Gitdm (the "git data miner") is the tool that Greg KH and I have used
to crank out statistics on where kernel patches come from.  For the
curious, I have (finally) put up a public repository for gitdm at:

	git://git.lwn.net/gitdm.git

That repository is currently tagged at v0.10, for whatever that's worth.

There is a mildly redacted version of the configuration files used in
the creation of kernel statistics at:

	http://lwn.net/images/gitdm/gitdm-config-2.6.26.tar.bz2

If nothing else, the domain->company mapping files should be useful for
anybody who might be interested in using gitdm on projects other than
the kernel.

Please be warned that gitdm is not a polished release of a
production-quality tool; it's something which has been made to work
just well enough for what we needed to do at any given time.  Needless
to say, patches to make it better are welcome.

jon
