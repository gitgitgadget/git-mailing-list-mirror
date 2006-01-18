From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Something wrong with pickaxe?
Date: Thu, 19 Jan 2006 00:23:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601190004130.15298@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jan 19 00:23:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzMeW-00042I-Hv
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 00:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbWARXXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 18:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbWARXXl
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 18:23:41 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:63156 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1161044AbWARXXl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 18:23:41 -0500
Received: from amavis.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP id EB188E107C
	for <git@vger.kernel.org>; Thu, 19 Jan 2006 00:23:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id DEADE1C84
	for <git@vger.kernel.org>; Thu, 19 Jan 2006 00:23:37 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id C0A391874
	for <git@vger.kernel.org>; Thu, 19 Jan 2006 00:23:37 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id A6E871412FC
	for <git@vger.kernel.org>; Thu, 19 Jan 2006 00:23:37 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14869>

Hi,

it is a fact that I'm stupid, but in this case it might be a bug, too. 
When I call

	git-whatchanged -Sget_remote_heads 1baaae5e fetch-pack.c

the first shown commit is d1c133f5. However, if I substitute the 
"-Sget_remote_heads" by "-p" I see that the diff of commit 1baaae5e *does* 
change a line containing that text.

What am I doing wrong?

Ciao,
Dscho
