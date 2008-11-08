From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: absurdly slow git-diff
Date: Sat, 8 Nov 2008 10:27:42 +0530
Message-ID: <20081108045742.GA26716@toroid.org>
References: <20081107200126.GA20284@toroid.org> <alpine.LFD.2.00.0811071335010.3468@nehalem.linux-foundation.org> <alpine.DEB.1.10.0811071503120.8736@alien.or.mcafeemobile.com> <alpine.DEB.1.10.0811071517280.8736@alien.or.mcafeemobile.com> <alpine.LFD.2.00.0811071540340.3468@nehalem.linux-foundation.org> <alpine.DEB.1.10.0811071547080.8736@alien.or.mcafeemobile.com> <alpine.LFD.2.00.0811071554590.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 06:01:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyfwd-00077M-QM
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 06:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbYKHE5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 23:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752783AbYKHE5q
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 23:57:46 -0500
Received: from fugue.toroid.org ([85.10.196.113]:59031 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752666AbYKHE5p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 23:57:45 -0500
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 8251555834E;
	Sat,  8 Nov 2008 05:57:43 +0100 (CET)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 7424A3880C3; Sat,  8 Nov 2008 10:27:42 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811071554590.3468@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100376>

At 2008-11-07 15:57:23 -0800, torvalds@linux-foundation.org wrote:
>
> > Yeah, similar. Mine is below. There's one less branch in the for
> > loops.
> 
> ..and has a comment and made the magic constant be named.

It works fine for me (the time went from 5m17s to 1.8s).

(By the way, my test case is certainly very odd, but it is a real file
from my test suite, albeit with the content x'ed away; and the change
was to adjust the expected output for all the items. I wasn't looking
for bugs. :-)

Thanks for the explanation and the patch.

-- ams
