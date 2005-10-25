From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/4] Make git-clone work on a USB stick
Date: Wed, 26 Oct 2005 01:38:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510260138300.30576@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Oct 26 01:40:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUYNo-0004S8-Dv
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 01:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbVJYXjB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 19:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVJYXjB
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 19:39:01 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:7827 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932480AbVJYXjA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 19:39:00 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D579B13EEF1; Wed, 26 Oct 2005 01:38:59 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B7FE0B0D71; Wed, 26 Oct 2005 01:38:59 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 97629B00FD; Wed, 26 Oct 2005 01:38:59 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E591913EEF1; Wed, 26 Oct 2005 01:38:58 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10634>

When I tried to git-clone something to a USB stick so that I could
carry the repository to a friend with a slow modem, I got stuck.
There were several issues (mostly having to do with limitations of
the FAT format), but none of them show stoppers.

This patch series solves all of these issues.
