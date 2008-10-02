From: David Soria Parra <sn_@gmx.net>
Subject: Re: [PATCH] Solaris: Use OLD_ICONV to avoid compile warnings
Date: Thu, 02 Oct 2008 12:09:26 +0200
Message-ID: <48E49DD6.7000708@gmx.net>
References: <1222906127-16900-1-git-send-email-sn_@gmx.net> <20081002010816.GA27415@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 02 12:12:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlLA6-0005t9-9T
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 12:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbYJBKJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 06:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbYJBKJg
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 06:09:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:38257 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752360AbYJBKJg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 06:09:36 -0400
Received: (qmail invoked by alias); 02 Oct 2008 10:09:34 -0000
Received: from krlh-5d854aba.pool.einsundeins.de (EHLO Tokyo.lan) [93.133.74.186]
  by mail.gmx.net (mp027) with SMTP; 02 Oct 2008 12:09:34 +0200
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX1/8UVwS1c38KWuZtAIO4iY+pvPfwc6etI6tuBbB1j
	hbW4Q6kjT15MrS
User-Agent: Thunderbird 2.0.0.17 (Macintosh/20080914)
In-Reply-To: <20081002010816.GA27415@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97303>

Jeff King schrieb:
> Do you also unset NEEDS_LIBICONV (and which version of Solaris are you
> running)?  Our Makefile sets it to "yes" for Solaris 8, but my build box
> requires that it be unset. I'm not sure if my setup is somehow
> deficient, or if it is only other versions that need it.

I'm using OpenSolaris which is identified as SunOS 5.11. Therefore the 
Makefile doesn't set NEEDS_LIBICONV. I'm not sure if it's needed on 
Solaris 8 or not, but it's not needed on OpenSolaris.

David
