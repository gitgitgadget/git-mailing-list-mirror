From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Wed, 09 May 2007 19:27:40 -0700
Message-ID: <4642831C.2090401@midwinter.com>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>	<alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>	<vpqbqgxak1i.fsf@bauges.imag.fr>	<46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com>	<alpine.LFD.0.98.0705072137450.3974@woody.linux-foundation.org>	<20070509134151.GT4489@pasky.or.cz>	<alpine.LFD.0.98.0705090825090.4062@woody.linux-foundation.org> <7vzm4dplhu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 10 04:28:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlyO9-0004lF-Tg
	for gcvg-git@gmane.org; Thu, 10 May 2007 04:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410AbXEJC1n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 22:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbXEJC1n
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 22:27:43 -0400
Received: from tater.midwinter.com ([216.32.86.90]:47359 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754241AbXEJC1m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 22:27:42 -0400
Received: (qmail 27476 invoked from network); 10 May 2007 02:27:41 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=pEXXEkAuk63jNR5PEhJURsYnQl10RgDXQaufqkUOvWtNt67v5DYOtDxu59XunTpu  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 10 May 2007 02:27:41 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <7vzm4dplhu.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46826>

Junio C Hamano wrote:
> I obviously agree with this.  As I said a few times I regret
> introducing "add -i" --- it encourages a wrong workflow, in that
> what you commit in steps never match what you had in the working
> tree and could have tested until the very end.
>   

On the other hand, not all changes require any testing at all. For 
example, if you're using git to manage documentation, it is totally 
reasonable to commit a fix for a simple spelling error in one part of a 
file while not committing an in-progress rewrite of another part.

-Steve
