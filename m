From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/3] merge-recur: get rid of external call to read-tree
Date: Sun, 30 Jul 2006 20:24:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607302022080.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jul 30 20:24:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7FxY-00027S-2x
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 20:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWG3SYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 14:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWG3SYK
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 14:24:10 -0400
Received: from mail.gmx.de ([213.165.64.21]:15492 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932410AbWG3SYJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jul 2006 14:24:09 -0400
Received: (qmail invoked by alias); 30 Jul 2006 18:24:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 30 Jul 2006 20:24:08 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24464>

Hi,

these three patches refactor the read-tree functionality into 
unpack-trees.[ch], and then use them in merge-recur.

I did not do any benchmarks yet, so this task is up for grabs.

Ciao,
Dscho
