From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Request: timeout option for remote operations, esp. "git fetch"
Date: Sun, 10 Nov 2013 20:17:51 +0000
Message-ID: <20131110201751.GA18513@dcvr.yhbt.net>
References: <527BC8DC.7010108@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Nov 10 21:18:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfbSQ-0002AU-9s
	for gcvg-git-2@plane.gmane.org; Sun, 10 Nov 2013 21:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953Ab3KJURy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 15:17:54 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:33183 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821Ab3KJURx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 15:17:53 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081171FD47;
	Sun, 10 Nov 2013 20:17:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <527BC8DC.7010108@zytor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237592>

"H. Peter Anvin" <hpa@zytor.com> wrote:
> When a remote server is unavailable or very slow, some git commands can
> stall out indefinitely.  It would be a very good thing if remote
> commands -- but especially git fetch -- could be given a timeout.

We've had SO_KEEPALIVE on git and ssh transports since e47a8583 (2011-12-06)
SO_KEEPALIVE for http was added recently (a15d069a) and will be in git 1.8.5

Do you want a shorter timeout for slow (but still alive) servers?
