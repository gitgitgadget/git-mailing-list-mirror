From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] GIT_TRACE: show which built-in/external commands are executed
Date: Wed, 28 Jun 2006 20:22:13 +0200
Message-ID: <E1Fveg1-0006u8-D7@moooo.ath.cx>
References: <E1FuSIf-0004jK-Tp@moooo.ath.cx> <7v3bdtv4h3.fsf@assigned-by-dhcp.cox.net> <E1FuV62-0004Jd-Ve@moooo.ath.cx> <Pine.LNX.4.63.0606251607090.29667@wbgn013.biozentrum.uni-wuerzburg.de> <E1FuXBk-0001SG-3n@moooo.ath.cx> <Pine.LNX.4.63.0606260129410.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 20:22:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvegA-0003dW-2o
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 20:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWF1SWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 14:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWF1SWT
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 14:22:19 -0400
Received: from moooo.ath.cx ([85.116.203.178]:14543 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750804AbWF1SWS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 14:22:18 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606260129410.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22815>

> That still leaves my problem: GIT_TRACE=1 on scripts is incomplete.
Ok, I see what you mean.

This actually affects all scripts which are called as git-foo instead
of git foo (but built-in commands show up anyway). So I'd add a
warning to the documentation in which cases GIT_TRACE will not show
that a command is executed.
In the git repository I found 47 shell scripts (git-* without the
header file) which would be affected. Searching for all occurences of
git-(one of those shell-scripts) I found 50 lines of code which use
it. If there is any interest in changing this I can try to change
this.
