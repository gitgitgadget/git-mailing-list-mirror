From: David Bryson <david@statichacks.org>
Subject: Re: [PATCH 0/4] replace unsinged long with time_t
Date: Thu, 6 Nov 2008 10:37:22 -0800
Message-ID: <20081106183722.GL10996@eratosthenes.cryptobackpack.org>
References: <1225993728-4779-1-git-send-email-david@statichacks.org> <alpine.LFD.2.00.0811061000430.3419@nehalem.linux-foundation.org>
Reply-To: David Bryson <david@statichacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 06 19:39:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky9kq-0008Bg-Ej
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 19:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbYKFSh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 13:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbYKFSh0
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 13:37:26 -0500
Received: from cryptobackpack.org ([64.105.32.74]:56724 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbYKFShZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 13:37:25 -0500
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id 8C51810D0265; Thu,  6 Nov 2008 10:37:24 -0800 (PST)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	DNS_FROM_SECURITYSAGE autolearn=no version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id 2551C10D0023;
	Thu,  6 Nov 2008 10:37:24 -0800 (PST)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id DAC9D14462; Thu,  6 Nov 2008 10:37:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811061000430.3419@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100260>

Hi,

On Thu, Nov 06, 2008 at 10:13:46AM -0800 or thereabouts, Linus Torvalds wrote:
> So "time_t" really is a pretty damn worthless type. It's not _quite_ as 
> broken as "socklen_t" (which is just a broken name for "int", and anybody 
> who declares it to be anythign else is a total moron), but it's close.

I have always thought that time_t and similar were braindead, but hey
the Janitor page listed it as desireable so what do I know ?

> In theory, some platform might have a 64-but "unsigned long long" time_t 
> even if the architecture is 32-bit (apparently windows used to do that if 
> you included <time64.h>, for example), but since we wouldn't take 
> advantage of that anyway, even then there is no real advantage.

Having a problem between 32 and 64 bit implementations does seem
undesireable.

http://git.or.cz/gitwiki/Janitor?action=info

Janitor wiki log says Pasky added the time_t conversion section.  Care
to explain the reason for the request Pasky ?

Dave
