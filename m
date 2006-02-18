From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Junio, you are a genius.
Date: Sat, 18 Feb 2006 03:12:00 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602180307100.6646@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Feb 18 03:12:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAHZu-0005Qq-UD
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 03:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWBRCME (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 21:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWBRCMD
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 21:12:03 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:61669 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750746AbWBRCMB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 21:12:01 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 1110D1467DC
	for <git@vger.kernel.org>; Sat, 18 Feb 2006 03:12:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 04CC5B07
	for <git@vger.kernel.org>; Sat, 18 Feb 2006 03:12:01 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id CB1941467DC
	for <git@vger.kernel.org>; Sat, 18 Feb 2006 03:12:00 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16382>

Hi,

Earlier, I avoided to repack too often, since "repack -a -d" was too 
expensive, and small incremental packs were inefficient.

Now, with the reusing delta patch, "repack -a -d" is marginally less 
efficient than incremental packs. No longer worry about when to repack: 
Just do it! No need for incremental packs!

Hero!

Ciao,
Dscho
