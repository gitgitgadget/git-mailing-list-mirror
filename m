From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Wed, 28 Nov 2007 15:59:49 -0600
Message-ID: <474DE4D5.6020407@freescale.com>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site>	<alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org>	<Pine.LNX.4.64.0710260007450.4362@racer.site>	<7v3avy21il.fsf@gitster.siamese.dyndns.org>	<Pine.LNX.4.64.0710261047450.4362@racer.site>	<7v3aurcjpq.fsf@gitster.siamese.dyndns.org>	<Pine.LNX.4.64.0711281307420.27959@racer.site>	<27E5EF3C-19EF-441C-BB12-0F5B29BEAEDB@midwinter.com>	<Pine.LNX.4.64.0711282039430.27959@racer.site>	<8c5c35580711281310h8764a33pba48e65010abf859@mail.gmail.com> <7vhcj63uhw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 23:00:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxUxh-0004K3-A6
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 23:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756579AbXK1WAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 17:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756534AbXK1WAe
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 17:00:34 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:50372 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbXK1WAd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 17:00:33 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id lASLxpux002023;
	Wed, 28 Nov 2007 14:59:51 -0700 (MST)
Received: from [10.214.73.175] (mvp-10-214-73-175.am.freescale.net [10.214.73.175])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id lASLxoNo018759;
	Wed, 28 Nov 2007 15:59:50 -0600 (CST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vhcj63uhw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66435>

Junio C Hamano wrote:

> Maybe not make this part of git-pull at all?  merge and rebase have
> totally different impact on the resulting history, so perhaps a separate
> command that is a shorthand for "git fetch && git rebase" may help
> unconfuse the users.

At long last, we can revive "git update"!

jdl
