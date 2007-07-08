From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Sun, 08 Jul 2007 20:15:57 +0200
Message-ID: <20070708181557.GL1528MdfPADPa@greensroom.kotnet.org>
References: <11839118073186-git-send-email-skimo@liacs.nl>
 <1183911808787-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0707081729040.4248@racer.site> <46912726.5080807@midwinter.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 20:16:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7bIg-0005jf-H6
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 20:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbXGHSQA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 14:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754694AbXGHSP7
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 14:15:59 -0400
Received: from psmtp02.wxs.nl ([195.121.247.11]:55128 "EHLO psmtp02.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754923AbXGHSP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 14:15:59 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp02.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JKV007AEHEL2Q@psmtp02.wxs.nl> for git@vger.kernel.org; Sun,
 08 Jul 2007 20:15:58 +0200 (MEST)
Received: (qmail 4882 invoked by uid 500); Sun, 08 Jul 2007 18:15:57 +0000
In-reply-to: <46912726.5080807@midwinter.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51899>

On Sun, Jul 08, 2007 at 11:04:22AM -0700, Steven Grimm wrote:
> This command points us in the direction of a "remove/rename this file in 
> history" feature that doesn't require forking tens of thousands of child 
> processes on a repo with lots of history. For that alone I think it's 
> worthwhile, even though it's not there yet; that will never happen with 
> a shell script. And yeah, that's not a frequent operation, but it's sure 
> nice when even the infrequent operations are lightning fast.

I couldn't come up with a clean interface to specify removes/renames
on the command line (other than copying the external command idea from
cg-admin-rewritehist), but this is one of the operations I have to
perform on the project I'm cleaning up, so if you have any suggestions,
I'd be interested to hear them.

skimo
