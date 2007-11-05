From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: fix dcommit clobbering when committing a series of diffs
Date: Mon, 5 Nov 2007 08:40:12 -0800
Message-ID: <20071105164012.GA29921@hand.yhbt.net>
References: <1194261708-32256-1-git-send-email-normalperson@yhbt.net> <20071105142254.GA20277@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 05 17:40:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip503-0007ku-ER
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 17:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbXKEQkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 11:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804AbXKEQkO
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 11:40:14 -0500
Received: from hand.yhbt.net ([66.150.188.102]:51361 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbXKEQkN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 11:40:13 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 15BAD7DC0FE;
	Mon,  5 Nov 2007 08:40:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071105142254.GA20277@xp.machine.xx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63525>

Peter Baumann <waste.manager@gmx.de> wrote:
> On Mon, Nov 05, 2007 at 03:21:47AM -0800, Eric Wong wrote:
> > +
> > +test_expect_success 'unrelated some unrelated changes to git' "
> 
> The first unrelated seems odd here.

Oops, must have been a brain glitch.  Good catch, thanks.

-- 
Eric Wong
