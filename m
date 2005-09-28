From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: git cvsimport?
Date: Wed, 28 Sep 2005 17:18:12 +0200
Message-ID: <20050928151812.GS15165MdfPADPa@greensroom.kotnet.org>
References: <20050928124029.1BF6D352B7B@atlas.denx.de>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 17:22:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKdhJ-0001SW-5t
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 17:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbVI1PSO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 11:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbVI1PSO
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 11:18:14 -0400
Received: from smtp13.wxs.nl ([195.121.6.27]:31200 "EHLO smtp13.wxs.nl")
	by vger.kernel.org with ESMTP id S1751046AbVI1PSO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2005 11:18:14 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp13.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0INJ003NK96C21@smtp13.wxs.nl> for git@vger.kernel.org; Wed,
 28 Sep 2005 17:18:13 +0200 (CEST)
Received: (qmail 32082 invoked by uid 500); Wed, 28 Sep 2005 15:18:12 +0000
In-reply-to: <20050928124029.1BF6D352B7B@atlas.denx.de>
To: Wolfgang Denk <wd@denx.de>
Mail-followup-to: Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9431>

On Wed, Sep 28, 2005 at 02:40:29PM +0200, Wolfgang Denk wrote:
> 
> I have problems importing a CVS repository:
> 
> -> git cvsimport -v -d :pserver:denx@cvs.semihalf.com:/cvs -C /home/git/duts duts
> cvs_direct initialized to CVSROOT /cvs
> cvs rlog: Logging duts
> cvs rlog: Logging duts/core
> NOTICE: used alternate strip path /home/cvs/duts/core/duts
> DONE; creating master branch
> cp: cannot stat `/home/git/duts/.git/refs/heads/origin': No such file or directory
> usage: git-read-tree (<sha> | -m [-u | -i] <sha1> [<sha2> [<sha3>]])
> checkout failed: 256
> -> git --version
> git version 0.99.7
> 
> Am I doing anything wrong here?
> 

What does 

cvsps -u -A --cvs-direct --root :pserver:denx@cvs.semihalf.com:/cvs duts

say ?

skimo
