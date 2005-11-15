From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 12:09:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1132034390.22207.18.camel@dv> <7vveyuqto5.fsf@assigned-by-dhcp.cox.net>
 <1132042427.3512.50.camel@dv> <7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net>
 <7vd5l2mco1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 12:11:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebyh9-00022C-Oi
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 12:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVKOLJp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 06:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbVKOLJp
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 06:09:45 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:65457 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751423AbVKOLJo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 06:09:44 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7B09813F776; Tue, 15 Nov 2005 12:09:43 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5D99C9F2E2; Tue, 15 Nov 2005 12:09:43 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3C2BD9F2B4; Tue, 15 Nov 2005 12:09:43 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DC73113F776; Tue, 15 Nov 2005 12:09:42 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5l2mco1.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11896>

Hi,

I think Junio is right: we should not force everybody not to use symlinks, 
only because there happens to be VFAT-, SMB- or HTTP-shared repositories. 
As Junio says, if there are people experiencing problems because they lack 
symbolic links, they should fix it.

On the other hand, I think it would be useful to be able to configure the 
behaviour via .git/config.

Ciao,
Dscho
