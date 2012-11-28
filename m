From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: What is --follow-parent / --no-follow-parent for?
Date: Wed, 28 Nov 2012 21:20:44 +0000
Message-ID: <20121128212044.GA18206@dcvr.yhbt.net>
References: <20121120073153.GA340@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Leske <Sebastian.Leske@sleske.name>
X-From: git-owner@vger.kernel.org Wed Nov 28 22:21:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdp40-0007TP-VM
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 22:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326Ab2K1VUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 16:20:45 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:54298 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932307Ab2K1VUo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 16:20:44 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BB051F6D5;
	Wed, 28 Nov 2012 21:20:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20121120073153.GA340@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210779>

Sebastian Leske <Sebastian.Leske@sleske.name> wrote:
> However, this does not make sense to me: This sounds like there is no
> good reason *not* to enable this option.  So why is it there? And in
> what situation might I want to use "--no-follow-parent"?

Speed.  Following long/convoluted histories can take a long time.
Sometimes the user doesn't care about ancient history.
