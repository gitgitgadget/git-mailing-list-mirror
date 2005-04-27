From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: I'm missing isofs.h
Date: Wed, 27 Apr 2005 12:45:55 -0400
Message-ID: <20050427164555.GB7070@delft.aura.cs.cmu.edu>
References: <20050426214338.32e9ac27.akpm@osdl.org> <20050427125843.GA9454@delft.aura.cs.cmu.edu> <20050427135840.GE3014@pasky.ji.cz> <20050427164351.GA7070@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 27 18:41:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQpad-0002fl-35
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 18:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVD0QqA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 12:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVD0QqA
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 12:46:00 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:15293 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261772AbVD0Qp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 12:45:56 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DQpff-0005x6-00; Wed, 27 Apr 2005 12:45:55 -0400
To: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Andrew Morton <akpm@osdl.org>
Mail-Followup-To: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Andrew Morton <akpm@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050427164351.GA7070@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2005 at 12:43:51PM -0400, Jan Harkes wrote:
> In any case, when I use
>     cg-diff -r a2755a80f40e5794ddc20e00f781af9d6320fafb: | grep isofs.h
> 
> the missing file does show up,
>     ...
>     Index: fs/isofs/isofs.h
>     +++ fd1621a8c03331bd78abfe52c8c385977d0a9729/fs/isofs/isofs.h (mode:100644 sha1:9ce7b51fb6141ea6b82d85687d490c74755591fb)
>     ...
> 
> so either I'm missing some subtle command line error (missing ':' after
> the tag-id?)

Looks like that actually is the problem, when I run cg-diff -r, but
leave out the ':' the final output does not include the added isofs.h
file.

Jan
