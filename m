From: Matt Mackall <mpm@selenic.com>
Subject: Mercurial v0.4d
Date: Wed, 4 May 2005 11:18:02 -0700
Message-ID: <20050504181802.GS22038@waste.org>
References: <20050504025852.GK22038@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261311AbVEDSWB@vger.kernel.org Wed May 04 20:20:17 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261311AbVEDSWB@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTOTI-0006Hr-7d
	for glk-linux-kernel@gmane.org; Wed, 04 May 2005 20:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVEDSWB (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Wed, 4 May 2005 14:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVEDSVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 14:21:51 -0400
Received: from waste.org ([216.27.176.166]:55188 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261311AbVEDSSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 14:18:08 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j44II2tY018704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 May 2005 13:18:02 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j44II2Iu018701;
	Wed, 4 May 2005 13:18:02 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050504025852.GK22038@waste.org>
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

A new version of Mercurial is available at:
 
  http://selenic.com/mercurial/

This fixes a handful of bugs reported last night, most notably failing
to pull from the http repo. This turned out to be a failure to quote
'%' characters. Thanks to everyone for their feedback.
 
Once you've got the new version installed, to pull the repo:

  hg init
  hg merge http://selenic.com/hg
  hg checkout    # 'hg co' works too

The web protocol is painfully slow, mostly because it makes an http
round trip per file revision to pull. I'm about to start working on a
replacement that minimizes round trips.

-- 
Mathematics is the supreme nostalgia of our time.
