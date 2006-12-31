From: Robert Fitzsimons <robfitz@273k.net>
Subject: Re: Gitweb - caching
Date: Sun, 31 Dec 2006 17:41:23 +0000
Message-ID: <20061231174123.GI6558@localhost>
References: <45979136.3070901@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 18:41:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H14gb-00074E-1t
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 18:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbWLaRlZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 12:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWLaRlZ
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 12:41:25 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:57347 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030373AbWLaRlY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 12:41:24 -0500
Received: from 213-202-128-191.bas502.dsl.esat.net ([213.202.128.191] helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1H14gA-0003Bb-J0; Sun, 31 Dec 2006 17:41:02 +0000
To: "J.H." <warthog19@eaglescrag.net>
Content-Disposition: inline
In-Reply-To: <45979136.3070901@eaglescrag.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-0.012, required 7,
	autolearn=disabled, RCVD_IN_NERDS_IE -2.00, RCVD_IN_SORBS_DUL 1.99)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35703>

> Thoughts or comments are welcome.

Interesting work, John.  Some initial comments:

* It's a very intrusive set of changes.
* An infinite expiry date isn't valid for all pages.
* The other HTTP headers can change depending on the page returned.
* A single cache directory is going to have problems as the number of
  cached files grows.

What are the benefits of doing this inside of gitweb instead of using
something like mod_cache or mod_perl handlers?

Robert
