From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Recoding of {git,cg}-log output
Date: Mon, 27 Feb 2006 01:36:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602270133330.5275@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44024384.4060406@people.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 27 01:36:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDWNU-0007uC-MS
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 01:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWB0Agi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 19:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWB0Agi
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 19:36:38 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:50095 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750706AbWB0Agh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 19:36:37 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id 27A441CAB;
	Mon, 27 Feb 2006 01:36:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 1B70FA0C;
	Mon, 27 Feb 2006 01:36:34 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id F38BF1DE9;
	Mon, 27 Feb 2006 01:36:33 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Krzysiek Pawlik <krzysiek.pawlik@people.pl>
In-Reply-To: <44024384.4060406@people.pl>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16813>

Hi,

On Mon, 27 Feb 2006, Krzysiek Pawlik wrote:

> First: a little "why": having /usr/bin/vim as PAGER allows to enter
> UTF-8 commit messages quite easily, the problem is when git-log (or
> cg-log) is run in terminal that's not UTF-8.

Of course, you could always set up a script doing the recoding and the 
paging, like

-- snip --
#!/bin/sh

iconv -f UTF-8 -t ISO-8859-2 "$@" | vim
-- snap --

and point your PAGER to that script (which is untested BTW). The advantage 
of this approach compared to adjusting git is that other programs use 
PAGER, too.

Hth,
Dscho
