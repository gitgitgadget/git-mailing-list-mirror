From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: use POSIX::sigprocmask to block signals
Date: Tue, 10 Apr 2012 21:11:20 +0000
Message-ID: <20120410211120.GA27555@dcvr.yhbt.net>
References: <cover.1333381684.git.rkagan@mail.ru>
 <9eaaebac91dc2b1a45a4dec77142be0b0b338056.1333381684.git.rkagan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roman Kagan <rkagan@mail.ru>
X-From: git-owner@vger.kernel.org Tue Apr 10 23:11:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHiLW-0005Ry-2j
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 23:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759424Ab2DJVLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 17:11:22 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41352 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754967Ab2DJVLV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 17:11:21 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE1691F5AD;
	Tue, 10 Apr 2012 21:11:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <9eaaebac91dc2b1a45a4dec77142be0b0b338056.1333381684.git.rkagan@mail.ru>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195130>

Roman Kagan <rkagan@mail.ru> wrote:
> +		my $signew = POSIX::SigSet->new(SIGINT, SIGHUP, SIGTERM,
> +			SIGALRM, SIGPIPE, SIGUSR1, SIGUSR2);

Considering your 2/2 patch, can we remove SIGPIPE here?
Otherwise, I think this series is good.  Thanks!
