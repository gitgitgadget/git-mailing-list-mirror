From: Sven Verdoolaege <skimo@kotnet.org>
Subject: git and Solaris 8
Date: Mon, 18 Sep 2006 15:41:00 +0200
Message-ID: <20060918134100.GL1221MdfPADPa@greensroom.kotnet.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 15:41:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPJMy-0003tE-PZ
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 15:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbWIRNlF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 09:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWIRNlF
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 09:41:05 -0400
Received: from smtp16.wxs.nl ([195.121.247.7]:5533 "EHLO smtp16.wxs.nl")
	by vger.kernel.org with ESMTP id S1751541AbWIRNlC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 09:41:02 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp16.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0J5S00D1SJCCYT@smtp16.wxs.nl> for git@vger.kernel.org; Mon,
 18 Sep 2006 15:41:01 +0200 (CEST)
Received: (qmail 12294 invoked by uid 500); Mon, 18 Sep 2006 13:41:00 +0000
To: Peter Eriksen <s022018@student.dtu.dk>, Paul Jakma <paul@clubi.ie>,
	Junio C Hamano <junkio@cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27246>

Commits 2fd955cc0b49de9e64b2f073ce76033975f0be24 and
e15f545155bb4b2cad4475a25cad8fb576d37dee seem to contradict each other.
The first claims that NEEDS_LIBICONV is needed on Solaris 10,
while the second claims that it is not needed on Solaris 9 and up.

All I know is that I have a Solaris *8* machine here and that I _don't_
need NEEDS_LIBICONV.  There is no -liconv on this machine.
(I'm CC'ing Uwe, because he apparently also has access to a Solaris 8
machine).

So is the current setting correct on some versions of Solaris 8
and if so, is there some way to change this setting from the command
line ?

Btw, like Uwe, I also don't have a "gtar" and "ginstall" on this machine.

SunOS billie 5.8 Generic_117350-39 sun4u sparc

skimo
