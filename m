From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] fall back to mozilla's sha.h if openssl/sha.h is not available
Date: Sat, 14 Jul 2007 16:23:50 +0200
Message-ID: <20070714142350.GB2544@steel.home>
References: <11844050771857-git-send-email-madduck@madduck.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "martin f. krafft" <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sat Jul 14 16:23:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9iXM-0002lU-Ae
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 16:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757919AbXGNOXy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 10:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757204AbXGNOXy
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 10:23:54 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:25241 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbXGNOXx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 10:23:53 -0400
Received: from tigra.home (Fc894.f.strato-dslnet.de [195.4.200.148])
	by post.webmailer.de (fruni mo2) (RZmta 8.3)
	with ESMTP id Z000acj6EDmE7s ; Sat, 14 Jul 2007 16:23:50 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B56EB277BD;
	Sat, 14 Jul 2007 16:23:50 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 8FF03C164; Sat, 14 Jul 2007 16:23:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11844050771857-git-send-email-madduck@madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+by+8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52483>

martin f. krafft, Sat, Jul 14, 2007 11:24:37 +0200:
> This should possibly go to configure.ac, but maybe *also* to Makefile to make

Definitely. It should it least skip the test if NO_OPENSSL is already
defined.

> from-source compilations easier. git HEAD already comes with a Makefile (rather
> than a Makefile.in), so I just ran it while testing out patches. I introduced
> the test because I thought the computer could find out about libssl for me,
> rather than myself having to forget to specify NO_OPENSSL every time.

You can simply create a config.mak and put NO_OPENSSL=Yes in it.
It gets included from Makefile.
