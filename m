From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 0/2] git-credential-cache--daemon on Cygwin
Date: Thu, 27 Oct 2011 18:18:30 +0100
Message-ID: <4EA99266.7030002@ramsay1.demon.co.uk>
References: <4EA2FC0D.5060404@ramsay1.demon.co.uk> <20111022191509.GB1785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 27 19:31:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJTni-00072s-W5
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 19:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998Ab1J0Rb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 13:31:29 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:55166 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753524Ab1J0Rb3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2011 13:31:29 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1RJTnb-0007NC-hn; Thu, 27 Oct 2011 17:31:28 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20111022191509.GB1785@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184302>

Jeff King wrote:
> On Sat, Oct 22, 2011 at 06:23:25PM +0100, Ramsay Jones wrote:
> 
>> Assuming that a modified http-auth-keyring series will make a return to pu
>> sometime, could you please squash these patches into (the patch corresponding to)
>> commit 2d6874d (credentials: add "cache" helper, 18-07-2011). Thanks!
> 
> I'm planning a reroll, so I'll squash them (or something similar) in.

Thanks!

> It's definitely coming back, so if you feel like working on it, please
> do. Also note that if it would be easier to have an alternate
> abstraction for inter-process communication on windows, I'm open to
> doing that in the cache daemon.

My initial reaction was to use a "named pipe" (aka fifo), but on reflection,
I don't think it would be any easier; the unix socket emulation should not be too
difficult (famous last words!).  :-D

ATB,
Ramsay Jones
