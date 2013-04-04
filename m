From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2 1/2] perl: redirect stderr to /dev/null instead of
 closing
Date: Thu, 4 Apr 2013 21:14:00 +0000
Message-ID: <20130404211400.GA27728@dcvr.yhbt.net>
References: <20130404011653.GA28492@dcvr.yhbt.net>
 <801ebb2a75d7cddfeee70eb86e8854c78d22eb3e.1365107899.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marcin Owsiany <marcin@owsiany.pl>,
	Petr Baudis <pasky@ucw.cz>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 04 23:14:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNrUP-0000Hw-37
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 23:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763812Ab3DDVOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 17:14:03 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46081 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763433Ab3DDVOC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 17:14:02 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0665E1F5B8;
	Thu,  4 Apr 2013 21:14:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <801ebb2a75d7cddfeee70eb86e8854c78d22eb3e.1365107899.git.trast@inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220107>

Thomas Rast <trast@inf.ethz.ch> wrote:
> As pointed out by Eric Wong (thanks), the initial close needs to go:
> die() would again write nowhere if we close STDERR beforehand.
> 
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>

Acked-by: Eric Wong <normalperson@yhbt.net>
Thanks.
