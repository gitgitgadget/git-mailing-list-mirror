From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org rsync processes
Date: Wed, 21 Sep 2005 08:12:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509210808080.2553@g5.osdl.org>
References: <4331537F.8060402@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: webmaster@kernel.org, git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 21 17:14:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI6Gm-00022a-GW
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 17:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVIUPMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 11:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVIUPMO
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 11:12:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45767 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751073AbVIUPMN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 11:12:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8LFC7Bo028795
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Sep 2005 08:12:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8LFC5Df010466;
	Wed, 21 Sep 2005 08:12:06 -0700
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <4331537F.8060402@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9049>



On Wed, 21 Sep 2005, A Large Angry SCM wrote:
>
> Did the kernel.org rsync processes get stuck again?

It may still see the effect of a disk failure.. According to hpa as of 
Monday evening:

> zeus2.kernel.org is coming back online after a severe disk failure.
> It's pretty out of date (in particular, it's missed the daily --checksum
> syncs), and I think it's still rebuilding its RAID, so it's running slow.

So it looks like kernel.org just had a few difficult days (fist the move
of master, then some problems at the outer fringes).

		Linus
