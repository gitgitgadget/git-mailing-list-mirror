From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: use SVN::Ra::get_dir2 when possible
Date: Sun, 2 Nov 2014 23:04:51 +0000
Message-ID: <20141102230451.GA18305@dcvr.yhbt.net>
References: <20141031101530.GA29248@dcvr.yhbt.net>
 <1414931516.94573.YahooMailBasic@web172301.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Nov 03 00:04:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xl4Cd-0004zi-M1
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 00:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbaKBXEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2014 18:04:52 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:45988 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377AbaKBXEv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2014 18:04:51 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 743941F8ED;
	Sun,  2 Nov 2014 23:04:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1414931516.94573.YahooMailBasic@web172301.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> Hmm, I see you are filing the problem against subversion. FWIW,
> I am currently using subversion-perl-1.8.10-1.fc20.x86_64 package on fedora 20.
> I'll possibly think about filing one under redhat's bugzilla and
> let them take it upward too.

This is another problem with the vbox repository:
  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=767530#10

And forwarded upstream:
  http://mid.gmane.org/20141101182722.GB20951@freya.jamessan.com
