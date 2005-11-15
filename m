From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/3] Support setting SymrefsOnly=true from scripts
Date: Tue, 15 Nov 2005 22:36:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511152233430.2152@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Nov 15 22:37:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec8TK-0005sR-Dz
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 22:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbVKOVgH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 16:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbVKOVgH
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 16:36:07 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:4556 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750935AbVKOVgG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 16:36:06 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AD56C13F700; Tue, 15 Nov 2005 22:36:05 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8ECB5B51E5; Tue, 15 Nov 2005 22:36:05 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 695C4B51D2; Tue, 15 Nov 2005 22:36:05 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5214D13F700; Tue, 15 Nov 2005 22:36:05 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11944>

Hi,

this series of patches does three things:

	- support for setting config variables
	- ditto, but from scripts
	- set SymrefsOnly=true right from the start with

		git-init-db --dont-use-symrefs

Ciao,
Dscho
