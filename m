From: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 22:19:57 +0200
Message-ID: <20050429201957.GJ17379@opteron.random>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Mackall <mpm@selenic.com>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 22:13:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRbqo-0005cC-JH
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbVD2URO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbVD2UP3
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:15:29 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:29544
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262384AbVD2UOw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 16:14:52 -0400
Received: by opteron.random (Postfix, from userid 500)
	id E598A1C1593; Fri, 29 Apr 2005 22:19:57 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <3817.10.10.10.24.1114756831.squirrel@linux1>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 02:40:31AM -0400, Sean wrote:
> There isn't anything preventing optomized transfer protocols for git. 

such a system might fall apart under load, converting on the fly from
git to network-optimized format sound quite expensive operation, even
ignorign the initial decompression of the payload. If something it
should be pre-converted to mercurial, so you checkout from mercurial and
you apply to local git.
