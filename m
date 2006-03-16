From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Thu, 16 Mar 2006 13:27:37 -0600
Message-ID: <1142537257.17536.137.camel@cashmere.sps.mot.com>
References: <20060314211022.GA12498@localhost.localdomain>
	 <Pine.LNX.4.64.0603141351470.3618@g5.osdl.org>
	 <20060314224027.GB14733@localhost.localdomain>
	 <Pine.LNX.4.64.0603141506130.3618@g5.osdl.org>
	 <7vek13ieap.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0603151450070.3618@g5.osdl.org>
	 <7vlkvbffhz.fsf@assigned-by-dhcp.cox.net>
	 <20060316075324.GA19650@pfit.vm.bytemark.co.uk>
	 <7vmzfq8zmr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Mar 16 20:28:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJy8d-00087h-6f
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 20:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbWCPT14 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 14:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbWCPT14
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 14:27:56 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:19593 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1752437AbWCPT1z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 14:27:55 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k2GJfopM005695
	for <git@vger.kernel.org>; Thu, 16 Mar 2006 12:41:50 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k2GJc6qF019964
	for <git@vger.kernel.org>; Thu, 16 Mar 2006 13:38:06 -0600 (CST)
To: Git List <git@vger.kernel.org>
In-Reply-To: <7vmzfq8zmr.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17644>

On Thu, 2006-03-16 at 04:14, Junio C Hamano wrote:

> And the second issue is the last point in the "implications"
> list above.  You are right, and I stand corrected.  Our scripts
> should consistently use dash form.
> 
> One thing that bothers me is that we need to keep encouraging
> users to use dashless form from the command line, while we
> update our scripts to use dash form.  What a contradicting and
> confusing situation X-<.

I think it has a philosophical rationale, though.

While we want to proved an abstraction layer to the
user through the "git" wrapper, we still want to be
precise internally within the scripts themselves.

Or so.

jdl
