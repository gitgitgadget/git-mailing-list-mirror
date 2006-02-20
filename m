From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: Prepend the history of one git tree to another
Date: Mon, 20 Feb 2006 11:43:45 +0100
Message-ID: <20060220104345.GG26454@cip.informatik.uni-erlangen.de>
References: <20060220090909.GT6558@cip.informatik.uni-erlangen.de> <43F99684.5070403@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 20 11:43:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FB8WD-0004h1-D6
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 11:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWBTKnq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 05:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWBTKnq
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 05:43:46 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:32431 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S964861AbWBTKnq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 05:43:46 -0500
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 31E8E305D9; Mon, 20 Feb 2006 11:43:45 +0100 (CET)
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <43F99684.5070403@op5.se>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16476>

Hello Andreas,

> Something like this might do the trick, depending on how linear your 
> ancestry graph is:

> $ cd blastwave
> $ first=$(git rev-list HEAD | tail -n 1)
> $ git format-patch -k --stdout $first..HEAD > ../blw.mbox
> $ cd ../blastwave.old
> $ git am -k -3 ../blw.mbox

My graph is very linear. However. I have binaries checked into my tree.
I am not sure if format-patch can handle this.

        Thomas
