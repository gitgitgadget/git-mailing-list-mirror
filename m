From: Petr Baudis <pasky@suse.cz>
Subject: [HUP] Pulling broken by late Cogito commits
Date: Sat, 13 Aug 2005 19:13:45 +0200
Message-ID: <20050813171345.GI5608@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 13 19:14:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3za5-0003nC-Qd
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 19:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVHMRNs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 13:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVHMRNs
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 13:13:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17933 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932218AbVHMRNs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 13:13:48 -0400
Received: (qmail 11113 invoked by uid 2001); 13 Aug 2005 17:13:45 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hi,

  if you are following Cogito development closely, please note that
pulling over HTTP and SSH was broken by a late Cogito commit (74b4f7).
This also means that you won't be able to pull the fix (which I just
committed and might take a short while to mirror out) if you pull Cogito
over HTTP.

  cg-pull and cg-update will print the new commit ID on stdout, like:

	Tree change:
	ce471851ee8b6147ac57b211d9d76c3e4d625598:75d9f4a22abefd561147f88be9b7eb81af420f1b

  The second ID (75d9f4a22abefd561147f88be9b7eb81af420f1b) is the new
commit - but it won't get saved and therefore merged. You need to do
that manually; e.g. if the stock Cogito is the origin branch (the usual
setup), do this:

	echo 75d9f4a22abefd561147f88be9b7eb81af420f1b >.git/refs/heads/origin

  Then run cg-merge or rerun cg-update.

  Sorry for any inconvenience,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
