From: Mark Burton <markb@ordern.com>
Subject: Re: Git commit won't add an untracked file given on the command
 line
Date: Tue, 18 Nov 2008 21:47:30 +0000
Organization: Order N Ltd.
Message-ID: <20081118214730.005fc72d@crow>
References: <20081118211237.234d8035@crow>
	<200811182227.20076.fge@one2team.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Galiegue <fge@one2team.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 22:49:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2YRP-0006gy-Pl
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 22:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbYKRVri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 16:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752597AbYKRVrh
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 16:47:37 -0500
Received: from c2beaomr09.btconnect.com ([213.123.26.187]:22300 "EHLO
	c2beaomr09.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbYKRVrh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 16:47:37 -0500
Received: from crow.ordern.com (host86-128-20-200.range86-128.btcentralplus.com [86.128.20.200])
	by c2beaomr09.btconnect.com (MOS 3.8.6-GA)
	with ESMTP id BFO08197;
	Tue, 18 Nov 2008 21:47:31 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id ED66A190CA9;
	Tue, 18 Nov 2008 21:47:30 +0000 (GMT)
In-Reply-To: <200811182227.20076.fge@one2team.com>
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2beaomr09.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0203.492337F7.00E0,ss=1,fgs=0,
	ip=86.128.20.200,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101289>


Hi Francis,

> You must "git add .gitignore" first. And yes, this is by design.

Err, that's a bit odd isn't it because "git add" stages the content into
the index but the whole point of specifying files on the command line
to "git commit" is to commit the changes in the specified files while
ignoring what's currently in the index (so says the man page for commit).

Cheers,

Mark
