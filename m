From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 14:34:33 -0500
Message-ID: <1128022473.14595.6.camel@cashmere.sps.mot.com>
References: <433BC9E9.6050907@pobox.com>
	 <200509292108.11092.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 21:36:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL4Bv-0004ZS-Su
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 21:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbVI2TfJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 15:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbVI2Te7
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 15:34:59 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:41211 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S964806AbVI2Teu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 15:34:50 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id j8TJgjIZ014147;
	Thu, 29 Sep 2005 12:42:45 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j8TJecl7029581;
	Thu, 29 Sep 2005 14:40:39 -0500 (CDT)
To: Oliver Neukum <oliver@neukum.org>
In-Reply-To: <200509292108.11092.oliver@neukum.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9499>

On Thu, 2005-09-29 at 14:08, Oliver Neukum wrote:

> Unfortunately, following the instructions to the letter produces this:
> oliver@oenone:~/linux-2.6> git checkout
> usage: read-tree (<sha> | -m <sha1> [<sha2> <sha3>])

Yeah.  See if you still have a .git/HEADS that symlinks
to a valid place or not...?

jdl
