From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "make test" fails with current HEAD
Date: Fri, 18 Nov 2005 11:35:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511181134080.8037@wbgn013.biozentrum.uni-wuerzburg.de>
References: <pan.2005.11.17.15.31.56.755022@smurf.noris.de>
 <7v7jb6o1kl.fsf@assigned-by-dhcp.cox.net> <20051118075117.GK31613@kiste.smurf.noris.de>
 <7vbr0imlha.fsf@assigned-by-dhcp.cox.net> <pan.2005.11.18.08.56.22.908009@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 11:37:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed3bD-0007jl-3Y
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 11:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbVKRKf2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 05:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbVKRKf2
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 05:35:28 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:45468 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1161022AbVKRKf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 05:35:27 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A8A0413FFC5; Fri, 18 Nov 2005 11:35:26 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 871429F34D; Fri, 18 Nov 2005 11:35:26 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7334C9CC6E; Fri, 18 Nov 2005 11:35:26 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6571A13FFC5; Fri, 18 Nov 2005 11:35:26 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.11.18.08.56.22.908009@smurf.noris.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12221>

Hi,

On Fri, 18 Nov 2005, Matthias Urlichs wrote:

> So the trivial fix is to emit our own "Binary files FOO and BAR differ"
> line if the exit status is 2.

>From my diff man page:

-- snip --
DIAGNOSTICS
       An  exit status of 0 means no differences were found, 1 means some 
       differences were found, and 2 means trouble.
-- snap --

The exit value 2 is ambiguous for at least one version of GNU diff.

Hth,
Dscho
