From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] Convert t6022 to use git-merge instead of git-pull
Date: Sat, 28 Apr 2007 12:11:59 +0100
Message-ID: <46332BFF.2050805@shadowen.org>
References: <20070425200718.GB30061@steel.home> <7vzm4wupew.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 28 13:12:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hhkqb-0005Ur-JX
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 13:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055AbXD1LL5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 07:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754114AbXD1LL5
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 07:11:57 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:3834 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055AbXD1LLz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 07:11:55 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1Hhkrd-0001C0-SC; Sat, 28 Apr 2007 12:13:17 +0100
User-Agent: Icedove 1.5.0.9 (X11/20061220)
In-Reply-To: <7vzm4wupew.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.2.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45775>

Junio C Hamano wrote:
> Is this really necessary?
> 
> I would rather want to leave some tests use "git merge" while
> some others use "git pull ." to catch breakage of either form.

If we are saying git pull . foo and git merge foo forms are the same
then perhaps that whole bunch of tests should be converted such that
they are in for cmd in "merge" "pull ." loop, so we test both always.

-apw
