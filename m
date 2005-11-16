From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Wed, 16 Nov 2005 02:05:43 +0100
Message-ID: <200511160205.43443.Josef.Weidendorfer@gmx.de>
References: <1132034390.22207.18.camel@dv> <Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de> <20051115121854.GV30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 16 02:06:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcBkG-0004YX-Hg
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 02:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbVKPBFr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 20:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbVKPBFr
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 20:05:47 -0500
Received: from mail.gmx.de ([213.165.64.20]:47289 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965138AbVKPBFr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 20:05:47 -0500
Received: (qmail invoked by alias); 16 Nov 2005 01:05:45 -0000
Received: from p5496C7F9.dip0.t-ipconnect.de (EHLO linux) [84.150.199.249]
  by mail.gmx.net (mp021) with SMTP; 16 Nov 2005 02:05:45 +0100
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20051115121854.GV30496@pasky.or.cz>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11982>

On Tuesday 15 November 2005 13:18, Petr Baudis wrote:
> being the canonical format in the next major release after 1.0, giving

Talking about versions...
Do we have an easy way to detect the format version of a git repository?
If not, I suggest git-init-db to add something like
	echo "1" > .git/version
and let all the git-tools which read/write any files in .git themself
test against version 1. Or is this overkill?

Josef
