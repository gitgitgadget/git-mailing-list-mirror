From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fix git-revert command-line options
Date: Thu, 03 Aug 2006 12:31:58 -0700
Message-ID: <7vmzalpqdt.fsf@assigned-by-dhcp.cox.net>
References: <20060803153742.109978@dial-up-mi-12.lombardiacom.it>
	<20060803184141.GA5476@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 21:32:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8ivN-0001Wc-O4
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 21:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWHCTcB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 15:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWHCTcB
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 15:32:01 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:5782 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964869AbWHCTcA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 15:32:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060803193200.IYHD554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Aug 2006 15:32:00 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060803184141.GA5476@admingilde.org> (Martin Waitz's message of
	"Thu, 3 Aug 2006 20:41:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24750>

Martin Waitz <tali@admingilde.org> writes:

> On Thu, Aug 03, 2006 at 05:42:23PM +0200, Michael wrote:
>> -	-n|--n|--no|--no-|--no-c|--no-co|--no-com|--no-comm|\
>> +	-n|--no-c|--no-co|--no-com|--no-comm|\
>
>> -	--n|--no|--no-|--no-e|--no-ed|--no-edi|--no-edit)
>> +	--n|--no-e|--no-ed|--no-edi|--no-edit)
>
> well spottet, but now we still have "-n" versus "--n".
> Perhaps we should drop the single-letter options or at least only
> keep one of them and then explicitly document that in the manpage.

Good suggestion.
