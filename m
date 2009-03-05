From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] Clarify the "cannot lock existing info/refs" error
Date: Thu, 5 Mar 2009 09:50:52 +0100
Message-ID: <20090305085052.GA24669@localhost>
References: <1236181026-15385-1-git-send-email-johnflux@gmail.com> <20090304192853.GA10567@localhost> <43d8ce650903050000g4466ab2fne5fb8ed009808346@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 09:52:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf9K2-00080u-PG
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 09:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbZCEIvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 03:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753602AbZCEIvH
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 03:51:07 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:35012 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbZCEIvG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 03:51:06 -0500
Received: from darc.dyndns.org ([84.154.68.174]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Mar 2009 09:50:58 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Lf9I4-0006Y7-Fw; Thu, 05 Mar 2009 09:50:52 +0100
Content-Disposition: inline
In-Reply-To: <43d8ce650903050000g4466ab2fne5fb8ed009808346@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 05 Mar 2009 08:50:58.0622 (UTC) FILETIME=[80E56DE0:01C99D6F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112269>

On Thu, Mar 05, 2009 at 08:00:37AM +0000, John Tapsell wrote:
> On google I found that people had been getting that error if they have
> the wrong password.

That's easy enough to verify. Using the wrong username/password I get

	error: Cannot access URL $url, return code 22
	error: failed to push some refs to '$url'

which is not very helpful, but otherwise unrelated.

> -fprintf(stderr, "Error: cannot lock existing info/refs\n");
> +error("cannot lock existing info/refs on remote server\n");

That's a less ambiguous but equally unhelpful error message.
