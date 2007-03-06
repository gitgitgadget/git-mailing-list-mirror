From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Date: Tue, 06 Mar 2007 03:05:55 -0800
Message-ID: <7vlkiapr70.fsf@assigned-by-dhcp.cox.net>
References: <20070306093917.GA1761@coredump.intra.peff.net>
	<989B956029373F45A0B8AF02970818902DAA12@zch01exm26.fsl.freescale.net>
	<20070306104127.GA13096@coredump.intra.peff.net>
	<7vveheprsc.fsf@assigned-by-dhcp.cox.net>
	<20070306105629.GA13285@coredump.intra.peff.net>
	<7vps7mprj6.fsf@assigned-by-dhcp.cox.net>
	<20070306110156.GA13380@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Li Yang-r58472 <LeoLi@freescale.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 12:06:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOXUv-0002E0-SU
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 12:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbXCFLF5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 06:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbXCFLF5
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 06:05:57 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:40343 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964936AbXCFLF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 06:05:56 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306110556.KHYA26279.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 6 Mar 2007 06:05:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XP5v1W00H1kojtg0000000; Tue, 06 Mar 2007 06:05:56 -0500
In-Reply-To: <20070306110156.GA13380@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 6 Mar 2007 06:01:56 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41576>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 06, 2007 at 02:58:37AM -0800, Junio C Hamano wrote:
>
>> Sorry, what I meant to say was on top of Li's patch.
>
> Ah, I understand your point now. Yes, if other mod_perl CGIs can impact
> the value, then we should definitely set it explicitly, as per your
> patch (and we should use Li's patch for safety, then, not mine).

Reading "sub autoEscape", "sub escapeHTML" and "sub
self_or_default" again, I think other people cannot affect the
value of our $cgi->{'escape'} by calling autoEscape, so what I
said is probably bogus.  Let's use Li's original patch.
