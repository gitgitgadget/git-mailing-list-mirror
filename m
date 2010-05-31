From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 0/3] git-instaweb: Support for 'plackup' and
 improvements
Date: Mon, 31 May 2010 23:15:09 +0200
Message-ID: <20100531211509.GB27342@machine.or.cz>
References: <1275073885-26537-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 31 23:15:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJCKP-0000QA-7m
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 23:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661Ab0EaVPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 17:15:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45452 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752025Ab0EaVPO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 17:15:14 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 277358620A1; Mon, 31 May 2010 23:15:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1275073885-26537-1-git-send-email-jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148054>

On Fri, May 28, 2010 at 09:11:22PM +0200, Jakub Narebski wrote:
> This series adds support for 'plackup' web server (PSGI/Plack based
> server script) to git-instaweb.  Because the web server (by default
> pure-Perl HTTP::Server::PSGI aka PLACK_SERVER=Standalone) can take a
> while to start, it required adding waiting for web server to be ready
> before starting web browser.
> 
> This series also contains somewhat unrelated fixup, namely that
> git-instaweb removes pidfile after stopping web server.  This is
> probably important only to web servers which do not have daemon mode,
> and are "daemonized" (which includes generating pidfile) by
> git-instaweb itself.

I did not test the series, but looking over it, all appears sane, so

Acked-by: Petr Baudis <pasky@suse.cz>
