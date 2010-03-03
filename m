From: Steven Drake <sdrake@xnet.co.nz>
Subject: Re: [PATCH 1/1] Add commit log message spell checking feature.
Date: Wed, 3 Mar 2010 20:21:49 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1003032018330.21953@vqena.qenxr.bet.am>
References: <alpine.LNX.2.00.1002281258340.15334@vqena.qenxr.bet.am> <7e21d6cd64aa088763c3ff11d6cbe78899ae7f10.1267314986.git.sdrake@xnet.co.nz> <20100228163339.GA9399@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 03 08:30:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmj2a-0001mJ-9B
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 08:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894Ab0CCHa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 02:30:26 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:43075 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257Ab0CCHaW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 02:30:22 -0500
Received: from idran.drake.org.nz (ip-118-90-92-73.xdsl.xnet.co.nz [118.90.92.73])
	by ananke.wxnz.net (Postfix) with ESMTP id 05412170851;
	Wed,  3 Mar 2010 20:30:19 +1300 (NZDT)
In-Reply-To: <20100228163339.GA9399@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141438>

On Sun, 28 Feb 2010, Jeff King wrote:
> On Sun, Feb 28, 2010 at 01:03:00PM +1300, Steven Drake wrote:
> 
> > Add 'git commit --spell' to run a spell checker on commit log message.
> > The `commit.spell` configuration variable can be used to enable the spell
> > checker by default and can be turned off by '--no-spell'.
> 
> Isn't this exactly the sort of thing the commit-msg hook is for?

Plus as I have just found out all hooks are run with stdin as '/dev/null' so
there is no way of running an interactive command like 'ispell' from a hook!

-- 
Steven
  1: Linux - will work for fish.
  2: The Linux penguin - looks stuffed to the brim with herring.
  ( make your own conclusions )
