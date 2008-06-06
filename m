From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Fri, 06 Jun 2008 16:04:10 -0500
Message-ID: <Jx4nZtFGdU-iUxlX24G6lzMyWe99Z53jtjQp9T9qkMJ1iZC0eZW6xg@cipher.nrlssc.navy.mil>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com> <alpine.DEB.1.00.0806051946100.21190@racer> <484969F0.1030704@gnu.org> <alpine.DEB.1.00.0806061911300.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Cedric Vivier <cedricv@neonux.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 23:06:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4j7k-0007V4-C7
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 23:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755082AbYFFVEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 17:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755520AbYFFVEb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 17:04:31 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60152 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbYFFVEa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 17:04:30 -0400
Received: by mail.nrlssc.navy.mil id m56L4BL2021343; Fri, 6 Jun 2008 16:04:11 -0500
In-Reply-To: <alpine.DEB.1.00.0806061911300.1783@racer>
X-OriginalArrivalTime: 06 Jun 2008 21:04:11.0353 (UTC) FILETIME=[DE3F7490:01C8C818]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84116>

Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 6 Jun 2008, Paolo Bonzini wrote:
> 
>>> What about people preferring the status quo?  I think a command line 
>>> option would be in order.'
>> config option seems more useful.
> 
> Except, of course, if you have a script that wants to override whatever 
> the user set in her config.

But can't that be just as easily done by piping through sort? (I understand
there is a platform which lacks the sort utility, boohoo)

Is there some legitimate function that depends on the order of listed
branches (or tags)?

Rather this seems like one of those things where everyone should either
welcome the functionality or be indifferent to it. Adding yet another
toggle for this sort of user-interface tweak seems like over-kill. It is
not costless, it adds complexity to the code and to the user interface.

If someone wants to list their branches alphabetically, or reverse
alphabetically, or if they only want to see branches beginning with 'BUG-',
why isn't it enough to just use the functionality provided by the command line?

bikeshedmode = off

-brandon
