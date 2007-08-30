From: Bart Trojanowski <bart@jukie.net>
Subject: Re: gitk startup time improvement
Date: Thu, 30 Aug 2007 12:42:02 -0400
Message-ID: <20070830164202.GR10772@jukie.net>
References: <18134.45449.527540.940620@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Aug 30 19:29:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQnpt-0005Wa-BN
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 19:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbXH3R3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 13:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758284AbXH3R3h
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 13:29:37 -0400
Received: from tachyon.jukie.net ([205.150.199.214]:40545 "EHLO jukie.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757383AbXH3R3g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 13:29:36 -0400
X-Greylist: delayed 2848 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Aug 2007 13:29:36 EDT
Received: from tau.jukie.net ([10.10.10.211]:55168)
	by jukie.net with esmtp (Exim 4.50)
	id 1IQn5n-0000N7-Cz; Thu, 30 Aug 2007 12:42:03 -0400
Received: by tau.jukie.net (Postfix, from userid 1000)
	id 5C5C42DC003; Thu, 30 Aug 2007 12:42:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <18134.45449.527540.940620@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57057>

* Paul Mackerras <paulus@samba.org> [070830 08:01]:
> I'd like people to try it.  Comments, bug reports, patches etc. are
> welcome, of course.

I am getting about a 4x improvement (1s vs 4s) running the 'dev' gitk on
the kernel tree, with warm cache.

-Bart

-- 
				WebSig: http://www.jukie.net/~bart/sig/
