From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH 6/7] include $PATH in generating list of commands for "help -a"
Date: Sun, 28 Oct 2007 19:44:32 -0700
Message-ID: <20071029024431.GA12459@srparish.net>
References: <1193474215-6728-6-git-send-email-srp@srparish.net> <1193582654-12100-1-git-send-email-srp@srparish.net> <Pine.LNX.4.64.0710281642220.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 29 03:44:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImKcS-0005Z4-1X
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 03:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbXJ2Cog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 22:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbXJ2Cog
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 22:44:36 -0400
Received: from smtp-gw5.mailanyone.net ([208.70.128.56]:60111 "EHLO
	smtp-gw5.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbXJ2Cof (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 22:44:35 -0400
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP quinn@srparish.net)
	id 1ImKcC-00006P-BW; Sun, 28 Oct 2007 21:44:34 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 501
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Sun, 28 Oct 2007 19:44:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710281642220.4362@racer.site>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62594>

On Sun, Oct 28, 2007 at 04:51:00PM +0000, Johannes Schindelin wrote:

> > +static void subtract_cmds(struct cmdnames *a, struct cmdnames *b) {
> 
> Maybe "exclude_cmds()", and choose more suggestive names for the 
> parameters?

I was thinking set operations when i named this (hense "a" and "b"),
but i'll try this out.

sRp

-- 
Scott Parish
http://srparish.net/
