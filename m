From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] GIT_TRACE: show which built-in/external commands are
 executed
Date: Mon, 26 Jun 2006 01:30:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606260129410.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <E1FuSIf-0004jK-Tp@moooo.ath.cx> <7v3bdtv4h3.fsf@assigned-by-dhcp.cox.net>
 <E1FuV62-0004Jd-Ve@moooo.ath.cx> <Pine.LNX.4.63.0606251607090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <E1FuXBk-0001SG-3n@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 01:31:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fue4D-0002co-WE
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 01:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWFYXap (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 19:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWFYXap
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 19:30:45 -0400
Received: from mail.gmx.net ([213.165.64.21]:3488 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751297AbWFYXao (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 19:30:44 -0400
Received: (qmail invoked by alias); 25 Jun 2006 23:30:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 26 Jun 2006 01:30:42 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FuXBk-0001SG-3n@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22648>

Hi,

On Sun, 25 Jun 2006, Matthias Lederhofer wrote:

> > P.S.: Now we only have to convert all "git-" invocations in the scripts to
> > "git " invocations so we can benefit from it. But that would mean two 
> > forks instead of one for the non-builtins. Hmm.
> 
> Why do we not use this policy:
> 
> git-* is guaranteed to be the normal command without any strange alias
> expansion, default parameters or something else a script does not like
> to be changed in the commands. So all scripts use git-*, this will
> prevent a double exec. The path to git-* should be obtained using git
> --exec-path in the beginnig.

That still leaves my problem: GIT_TRACE=1 on scripts is incomplete.

Ciao,
Dscho
