From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Teach runstatus about --untracked
Date: Wed, 13 Sep 2006 02:10:40 -0400
Message-ID: <20060913061040.GA3590@coredump.intra.peff.net>
References: <Pine.LNX.4.63.0609122243360.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Sep 13 08:11:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNNxc-0000AP-IM
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 08:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWIMGKo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 02:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbWIMGKo
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 02:10:44 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:21645 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751592AbWIMGKn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 02:10:43 -0400
Received: (qmail 18361 invoked from network); 13 Sep 2006 02:09:53 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 13 Sep 2006 02:09:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2006 02:10:40 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609122243360.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26901>

On Tue, Sep 12, 2006 at 10:45:12PM +0200, Johannes Schindelin wrote:

> +	if (!s->untracked)
> +		dir.show_other_directories = 1;

This should also set dir.hide_empty_directories to match the original
behavior.

-Peff
