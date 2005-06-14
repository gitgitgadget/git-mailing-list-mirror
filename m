From: Thomas Arendsen Hein <thomas@intevation.de>
Subject: Re: hgweb and gitweb: Commit times displayed incorrectly
Date: Tue, 14 Jun 2005 18:25:41 +0200
Message-ID: <20050614162541.GA27165@intevation.de>
References: <42AEFB66.80902@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jun 14 18:22:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiEAq-0006JA-T8
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 18:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVFNQ0a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 12:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVFNQ0a
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 12:26:30 -0400
Received: from aktaia.intevation.org ([212.95.126.10]:14776 "EHLO
	mail.intevation.de") by vger.kernel.org with ESMTP id S261232AbVFNQ0J
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2005 12:26:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.intevation.de (Postfix) with ESMTP
	id A3E0436FBD; Tue, 14 Jun 2005 18:26:03 +0200 (CEST)
Received: from thetis.hq (thetis.hq [192.168.11.13])
	by mail.intevation.de (Postfix) with SMTP
	id 2694B36F0E; Tue, 14 Jun 2005 18:26:02 +0200 (CEST)
Received: (nullmailer pid 27670 invoked by uid 10004);
	Tue, 14 Jun 2005 16:25:41 -0000
To: mercurial@selenic.com, git@vger.kernel.org
Mail-Followup-To: mercurial@selenic.com, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <42AEFB66.80902@gorzow.mm.pl>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl> [20050614 17:45]:
> Who is wrong there, especially with hours count?
> Here it's 17:43 +0200
> 
> hgweb:
> *16 hours ago: *

http://www.kernel.org/hg/?cmd=changelog;rev=30069

> gitweb:
> /11 hours ago/

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=log;h=e2c16499515aa044676a14b97a1b8a35f879152a

> My clone:
> author Jon Smirl <jonsmirl@gmail.com> Mon, 13 Jun 2005 15:52:36 -0700
> committer Linus Torvalds <torvalds@ppc970.osdl.org> Mon, 13 Jun 2005 20:58:58 -0700

Both are correct.

hgweb uses the timestamp of the "author" line, gitweb uses the
timestamp of the "commiter" line. Mercurial (hg) doesn't distinguish
author and commiter, therefore it uses the earlier time.

Regards,
Thomas Arendsen Hein

-- 
Email: thomas@intevation.de
http://intevation.de/~thomas/
