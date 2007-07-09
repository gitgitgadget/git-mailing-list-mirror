From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch --track: code cleanup and saner handling of local branches
Date: Mon, 09 Jul 2007 15:01:25 -0700
Message-ID: <7vzm25tex6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
	<7vhcof2rur.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707081336020.4248@racer.site>
	<7vzm2620wp.fsf@assigned-by-dhcp.cox.net> <46919692.5020708@gnu.org>
	<7vhcoexqeh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707091228290.5546@racer.site>
	<7v4pkduw2f.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707092203100.5546@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 00:01:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I81IR-0003ae-5Y
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 00:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797AbXGIWB2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 18:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756780AbXGIWB2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 18:01:28 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:64685 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756696AbXGIWB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 18:01:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709220126.MMXC1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Jul 2007 18:01:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Ma1R1X00M1kojtg0000000; Mon, 09 Jul 2007 18:01:26 -0400
In-Reply-To: <Pine.LNX.4.64.0707092203100.5546@racer.site> (Johannes
	Schindelin's message of "Mon, 9 Jul 2007 22:05:14 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52022>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> It strikes me a bit odd if Daniel's remote.[ch] infrastructure
>> does not give you easy access to this kind of information...
>
> Yes, probably.  However, at the time he was sending that patch, I was 
> already preparing the patch.

I was talking about existing remote.[ch] patches, which has been
in tree since late May this year, not his recent round of
"approach to builtin git-fetch" series.
