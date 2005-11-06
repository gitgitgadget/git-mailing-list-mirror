From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Check for differents trees
Date: Sun, 6 Nov 2005 19:24:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511061922570.12750@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051106153830.18963.qmail@web26312.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 19:25:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYpBa-0001Qf-12
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 19:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVKFSYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 13:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVKFSYG
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 13:24:06 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:13754 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751169AbVKFSYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 13:24:05 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B6DFB13EBFF; Sun,  6 Nov 2005 19:24:04 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9A3FC9F1B4; Sun,  6 Nov 2005 19:24:04 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 846CE9BA23; Sun,  6 Nov 2005 19:24:04 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 65C2313EBFF; Sun,  6 Nov 2005 19:24:04 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20051106153830.18963.qmail@web26312.mail.ukl.yahoo.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11220>

Hi,

if you want to know if tree1 and tree2 have *exactly* the same files, you 
only have to compare the sha1 of the two trees. If they are equal you are 
virtually guaranteed that the two trees contain the same files.

Hth,
Dscho
