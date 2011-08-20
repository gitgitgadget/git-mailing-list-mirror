From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn --stdlayout 's little quirk.
Date: Sat, 20 Aug 2011 18:35:04 +0000
Message-ID: <20110820183504.GA32179@dcvr.yhbt.net>
References: <1313859988.60143.YahooMailClassic@web29518.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: madduck@madduck.net, git@vger.kernel.org
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Aug 20 20:35:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuqO2-00080C-Df
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 20:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662Ab1HTSfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 14:35:07 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47029 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754388Ab1HTSfG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 14:35:06 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3726C2100F;
	Sat, 20 Aug 2011 18:35:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1313859988.60143.YahooMailClassic@web29518.mail.ird.yahoo.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179770>

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> first of all, thanks for a great tool - use it daily!

You're welcome :>

> I think I found a small bug in git 1.7.6. Having "trunk" at the end of
> the url in combination of --stdlayout is wrong, but it looks like that
> git-svn tries to cope, but doesn't go try far enough:
> 
> Doing this:
> ----------------
> git svn clone --stdlayout http://quick-settings.googlecode.com/svn/trunk/ android-quick-settings

--stdlayout expects the "root" path of the code you're interested
in (not necessarily the SVN repository root, but in this case they
could be the same).

Try the following instead:

git svn clone --stdlayout \
  http://quick-settings.googlecode.com/svn android-quick-settings

-- 
Eric Wong
