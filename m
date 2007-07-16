From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: question about git-submodule
Date: Mon, 16 Jul 2007 12:39:55 +0200
Message-ID: <20070716103954.GM999MdfPADPa@greensroom.kotnet.org>
References: <20070715135057.GI2568@steel.home>
 <20070715135453.GE7106@genesis.frugalware.org>
 <20070715140244.GF999MdfPADPa@greensroom.kotnet.org>
 <20070715142624.GF7106@genesis.frugalware.org>
 <20070715144835.GI999MdfPADPa@greensroom.kotnet.org>
 <20070715150540.GH7106@genesis.frugalware.org>
 <20070715152101.GJ999MdfPADPa@greensroom.kotnet.org>
 <20070715154028.GI7106@genesis.frugalware.org>
 <20070715214530.GK999MdfPADPa@greensroom.kotnet.org>
 <20070715222948.GL7106@genesis.frugalware.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: VMiklos <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 12:40:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IANzk-0008Qs-CM
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 12:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674AbXGPKj5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 06:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754745AbXGPKj5
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 06:39:57 -0400
Received: from smtp17.wxs.nl ([195.121.247.8]:59769 "EHLO smtp17.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051AbXGPKj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 06:39:56 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp17.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JL9006C4PMJXG@smtp17.wxs.nl> for git@vger.kernel.org; Mon,
 16 Jul 2007 12:39:55 +0200 (CEST)
Received: (qmail 2545 invoked by uid 500); Mon, 16 Jul 2007 10:39:55 +0000
In-reply-to: <20070715222948.GL7106@genesis.frugalware.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52656>

On Mon, Jul 16, 2007 at 12:29:48AM +0200, VMiklos wrote:
> 2) is it possible to do this without step b)?
> 
> i mean adding something like: "Subproject commit HEAD" or "Subproject
> commit mybranch"

No.  You have to specify the specific revision of the subproject
that is included in any revision of the superproject.

Imagine someone making an incompatible change to a subproject.
You do not want to get this change in your copy of the superproject
unless the superproject has been adapted to this change.

skimo
