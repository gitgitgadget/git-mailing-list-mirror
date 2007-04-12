From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-clone: Error meaningfully on failed HTTP fetches of HEAD
Date: Wed, 11 Apr 2007 17:38:11 -0700
Message-ID: <7vk5wimnpo.fsf@assigned-by-dhcp.cox.net>
References: <11763291192402-git-send-email-martin@catalyst.net.nz>
	<7vwt0imoc3.fsf@assigned-by-dhcp.cox.net>
	<461D7D36.4000407@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Apr 12 02:38:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbnKQ-0001CB-FB
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 02:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbXDLAiN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 20:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753729AbXDLAiN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 20:38:13 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:58480 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724AbXDLAiN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 20:38:13 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412003812.KXRN1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 20:38:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id m0eB1W00o1kojtg0000000; Wed, 11 Apr 2007 20:38:12 -0400
In-Reply-To: <461D7D36.4000407@catalyst.net.nz> (Martin Langhoff's message of
	"Thu, 12 Apr 2007 12:28:38 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44295>

Martin Langhoff <martin@catalyst.net.nz> writes:

> Junio C Hamano wrote:
>>> A bare clone that fails to fetch HEAD will still complete
>>> "successfully". I'm not sure if that's expected/desired. Is a
>>> HEADless repo valid in any situation?
>> 
>> You would get "fatal: Not a git repository".  Why not default to
>> 'master' (if found) and issue a warning?
>
> And if not found die() for real...? Ok. I'll rework and resend.

Yeah, after making sure we have 'master' there, though ;-).
