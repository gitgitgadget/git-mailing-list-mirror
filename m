From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH] "git help" and "git help -a" shouldn't exit(1) unless
	they error
Date: Sun, 21 Oct 2007 23:19:19 -0700
Message-ID: <20071022061918.GM16291@srparish.net>
References: <20071021214744.GH16291@srparish.net> <20071022054741.GP14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 08:19:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjqdT-00067Z-1e
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 08:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbXJVGTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 02:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbXJVGTW
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 02:19:22 -0400
Received: from smtp-gw5.mailanyone.net ([208.70.128.56]:35871 "EHLO
	smtp-gw5.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXJVGTV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 02:19:21 -0400
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1IjqdE-0004GP-7t; Mon, 22 Oct 2007 01:19:20 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Sun, 21 Oct 2007 23:19:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071022054741.GP14735@spearce.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61953>

On Mon, Oct 22, 2007 at 01:47:41AM -0400, Shawn O. Pearce wrote:

> The issue here is t0000-basic.sh runs "../git" and tests that the
> exit status is 1.  If it isn't (the patch above makes it 0) we just
> abort the test suite entirely.

Shoot, i hadn't realized i had effected the "git" case. I'll
look into this further.

By the way, should i expect all the tests to pass from the unmodified
public HEAD? (they don't for me)

sRp

-- 
Scott Parish
http://srparish.net/
