From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC/PATCH 3/4] Add git-sequencer test suite (t3350)
Date: Sat, 5 Jul 2008 19:31:30 +0200
Message-ID: <20080705173130.GA8099@leksak.fem-net>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <1214879914-17866-3-git-send-email-s-beyer@gmx.net> <1214879914-17866-4-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 19:32:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFBcp-00028s-GM
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 19:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbYGERbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 13:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535AbYGERbq
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 13:31:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:35079 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752113AbYGERbp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 13:31:45 -0400
Received: (qmail invoked by alias); 05 Jul 2008 17:31:43 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp015) with SMTP; 05 Jul 2008 19:31:43 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+9ontWKtu9UsXxyLFnZf+8Jvoahk35NKA7KBcCf7
	Un0K0OrXoLFy1h
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KFBbe-0006nX-RR; Sat, 05 Jul 2008 19:31:30 +0200
Content-Disposition: inline
In-Reply-To: <1214879914-17866-4-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87454>

Hi,

I've just noticed that those tag names:
  +	git tag A &&
  +	git tag B &&
  +	git tag C &&
  +	git tag D &&
  +	git tag E &&
  +	git tag F &&
  +	git tag I &&
  +ref refs/tags/CE
are perhaps a bad idea, because they could also be an abbreviated SHA1.
As it seems, git does not think this is ambiguous, since the exact tag
name exists.
So it could make sense to add a non-[0-9A-Fa-f] prefix, but it does not
seem to be necessary.  Hmmm, so this mail is just a mental note :)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
