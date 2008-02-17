From: Charles Bailey <charles@hashpling.org>
Subject: Re: [RFH] Add some very basic tests for git mergetool
Date: Sun, 17 Feb 2008 13:10:34 +0000
Message-ID: <20080217131034.GA32254@hashpling.org>
References: <20080217103545.GA24158@hashpling.org> <20080217125714.GA3925@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 14:11:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQjId-0003LH-Hv
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 14:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbYBQNKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 08:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbYBQNKo
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 08:10:44 -0500
Received: from pih-relay08.plus.net ([212.159.14.134]:45696 "EHLO
	pih-relay08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbYBQNKo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 08:10:44 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1JQjHz-0003vd-RJ; Sun, 17 Feb 2008 13:10:39 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1HDAYk2001501;
	Sun, 17 Feb 2008 13:10:34 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1HDAYQ8001500;
	Sun, 17 Feb 2008 13:10:34 GMT
Content-Disposition: inline
In-Reply-To: <20080217125714.GA3925@steel.home>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: dd45edd2eea66ec50ca383b45d4f0cb8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74128>

On Sun, Feb 17, 2008 at 01:57:14PM +0100, Alex Riesen wrote:
> I removed your delay and the test works every time.
> Could you strace the test (with "-ff -e open")?

OK, I've just tried it again a few times and it now seems to work for
me with and without the delay and with and without strace.  I'm not
sure what was wrong before.  Sorry for wasting you time, but it
definitely was broken for me before.

> > I'm not sure if there's a shell usleep instead of having to "sleep 1",
> 
> Just FYI: coreutils' sleep allows for subsecond sleeps.

Useful to know, thanks.
