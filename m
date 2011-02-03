From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Thu, 03 Feb 2011 19:01:34 +0100
Message-ID: <m2fws5m1z5.fsf@igel.home>
References: <20110202022909.30644.qmail@science.horizon.com>
	<alpine.LFD.2.00.1102030036420.12104@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: George Spelvin <linux@horizon.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 03 19:01:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl3V1-0007AH-8p
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 19:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756673Ab1BCSBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 13:01:37 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:55016 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab1BCSBg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 13:01:36 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 5574E1C0F591;
	Thu,  3 Feb 2011 19:01:35 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 134361C000B3;
	Thu,  3 Feb 2011 19:01:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id zUBOg2qlopk8; Thu,  3 Feb 2011 19:01:34 +0100 (CET)
Received: from igel.home (ppp-88-217-126-183.dynamic.mnet-online.de [88.217.126.183])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu,  3 Feb 2011 19:01:34 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 18896CA2A0; Thu,  3 Feb 2011 19:01:34 +0100 (CET)
X-Yow: Are we THERE yet??
In-Reply-To: <alpine.LFD.2.00.1102030036420.12104@xanadu.home> (Nicolas
	Pitre's message of "Thu, 03 Feb 2011 01:16:10 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165987>

Nicolas Pitre <nico@fluxnic.net> writes:

> This has _nothing_ about any autoconf convention.  GNU autoconf requires 
> stupid things like having a bunch of files such as CREDITS, INSTALL, 
> CHANGELOG, and other whatnots even if you have nothing to put in them, 
> in which case they still have to be there but empty.  It also dictates 
> the exact name your directories must have, etc.

That's automake, not autoconf (and only the default automake operation).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
