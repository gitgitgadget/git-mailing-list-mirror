From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why not clone to a remote directory over SSH
Date: Thu, 24 Nov 2005 00:45:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511240043300.11106@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051123211601.GA2260@hpsvcnb.fc.hp.com> <20051123230838.GN3968@reactrix.com>
 <4384F7F6.10404@op5.se> <20051123232829.GO3968@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 00:47:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef4Ip-0002Y1-NV
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 00:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030515AbVKWXpX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 18:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030518AbVKWXpW
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 18:45:22 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:8841 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030515AbVKWXpU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 18:45:20 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 54B5B13FB4B; Thu, 24 Nov 2005 00:45:19 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3CDE59F3ED; Thu, 24 Nov 2005 00:45:19 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2852C9989F; Thu, 24 Nov 2005 00:45:19 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B7B2113FB4B; Thu, 24 Nov 2005 00:45:18 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051123232829.GO3968@reactrix.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12664>

Hi,

On Wed, 23 Nov 2005, Nick Hengeveld wrote:

> If the server is DAV-enabled, a local git-init-db could use HTTP to
> create an empty remote repository, and git-http-push can already send
> local changes including merges etc. to such a remote repository.
> 
> Want to host your project using GIT?  Just use your .Mac iDisk.

That would be cool! And git-clone could be patched to do just that.

BTW, is it possible to convince git-http-push to store packs on the 
server?

For that matter, is it possible to generate the file(s) needed for a dumb 
server on the client side?

Ciao,
Dscho
