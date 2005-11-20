From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes
 through
Date: Sun, 20 Nov 2005 12:44:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511201242210.27791@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051117230723.GD26122@nowhere.earth>
 <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051119140404.GD3393@nowhere.earth> <20051119141341.GE3393@nowhere.earth>
 <Pine.LNX.4.63.0511191612350.4895@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051119170929.GF3393@nowhere.earth> <pan.2005.11.19.17.23.17.920228@smurf.noris.de>
 <Pine.LNX.4.63.0511200217200.11653@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051120073244.GA7902@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 12:45:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edncl-0002Qs-3q
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 12:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVKTLoa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 06:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVKTLoa
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 06:44:30 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:31451 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750861AbVKTLo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 06:44:29 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 56D6A1402F4; Sun, 20 Nov 2005 12:44:28 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3C1C09F38A; Sun, 20 Nov 2005 12:44:28 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 27B099D8EA; Sun, 20 Nov 2005 12:44:28 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 018C31402F4; Sun, 20 Nov 2005 12:44:28 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20051120073244.GA7902@kiste.smurf.noris.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12379>

Hi,

On Sun, 20 Nov 2005, Matthias Urlichs wrote:

> Why not simply use info/grafts?

'Cause you can't fetch a graft. But I agree, instead of telling somebody: 
"I have this new branch which unifies history", you can send your friend a 
oneliner which appends a graft.

Ciao,
Dscho
