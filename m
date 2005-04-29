From: Olivier Galibert <galibert@pobox.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Sat, 30 Apr 2005 00:30:52 +0200
Message-ID: <20050429223052.GD28540@dspnet.fr.eu.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1> <20050429201957.GJ17379@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, Matt Mackall <mpm@selenic.com>,
	Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 00:25:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRdvL-0003BX-VL
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 00:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbVD2WbC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 18:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbVD2WbC
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 18:31:02 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:1033 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S263034AbVD2Wa5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 18:30:57 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 4BA1E34D1A; Sat, 30 Apr 2005 00:30:52 +0200 (CEST)
To: Andrea Arcangeli <andrea@suse.de>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andrea Arcangeli <andrea@suse.de>, Sean <seanlkml@sympatico.ca>,
	Matt Mackall <mpm@selenic.com>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050429201957.GJ17379@opteron.random>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 10:19:57PM +0200, Andrea Arcangeli wrote:
> such a system might fall apart under load, converting on the fly from
> git to network-optimized format sound quite expensive operation, even
> ignorign the initial decompression of the payload.

Nothing a little caching can't solve.  Given that git's objects are
immutable caching is especially easy to do, you can have the delta
reference indexes in the filename.

  OG.

