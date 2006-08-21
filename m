From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [RFC] adding support for md5
Date: Mon, 21 Aug 2006 13:44:30 -0700
Message-ID: <20060821204430.GA2700@tuatara.stupidest.org>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com> <Pine.LNX.4.64.0608191339010.11811@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Rientjes <rientjes@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 22:44:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFGdP-0003Lj-O6
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 22:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWHUUoc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 16:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWHUUoc
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 16:44:32 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:14007 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751049AbWHUUoc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 16:44:32 -0400
Received: (qmail 93604 invoked from network); 21 Aug 2006 20:44:31 -0000
Received: from unknown (HELO stupidest.org) (cwedgwood@sbcglobal.net@70.231.243.138 with login)
  by smtp112.sbc.mail.mud.yahoo.com with SMTP; 21 Aug 2006 20:44:30 -0000
Received: by tuatara.stupidest.org (Postfix, from userid 10000)
	id 262F81811BD6; Mon, 21 Aug 2006 13:44:30 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608191339010.11811@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25817>

On Sat, Aug 19, 2006 at 01:50:32PM -0700, Linus Torvalds wrote:

> I can see the point of configurable hashes, but it would be for a
> stronger hash than sha1, not for a (much) weaker one.

Why any configuration option at all?  What in practice does it really
buy?

If someone (eventually) wants to do something malicious (which right
now requires some effort and would probably not go undetected) there
are probably easier ways to achieve this (like posting a patch with a
non-obvious subtle side-effect).
