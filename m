From: Johan Herland <johan@herland.net>
Subject: Re:
Date: Fri, 08 May 2009 01:57:15 +0200
Message-ID: <200905080157.15605.johan@herland.net>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504>
 <alpine.LFD.2.01.0905071613130.4983@localhost.localdomain>
 <alpine.DEB.1.10.0905071629230.15782@asgard>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bevan Watkiss <bevan.watkiss@cloakware.com>,
	'Alex Riesen' <raa.lkml@gmail.com>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri May 08 01:57:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2DSx-0005QF-Ob
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 01:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbZEGX5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 19:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbZEGX5S
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 19:57:18 -0400
Received: from mx.getmail.no ([84.208.15.66]:35433 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751298AbZEGX5S (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 19:57:18 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJA00JBET7G7880@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 08 May 2009 01:57:16 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJA006C1T7F14C0@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 08 May 2009 01:57:16 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.5.7.234631
User-Agent: KMail/1.11.2 (Linux/2.6.29-ARCH; KDE/4.2.2; x86_64; ; )
In-reply-to: <alpine.DEB.1.10.0905071629230.15782@asgard>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118543>

On Friday 08 May 2009, david@lang.hm wrote:
> removing the index and doing a checkout would be a reasonable thing to do
> (at least conceptually), I will admit that I don't remember ever seeing a
> command (or discussion of one) that would let me do that.

What about:

  rm .git/index
  git checkout -f

or maybe:

  git update-index --no-assume-unchanged --refresh
  git checkout -f

Hm?

....Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
