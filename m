From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] cvsimport move over to using git for each ref to read
 refs
Date: Thu, 21 Sep 2006 13:06:36 +0100
Message-ID: <4512804C.8060807@shadowen.org>
References: <20060920085200.GA21865@shadowen.org> <eer19l$6hm$1@sea.gmane.org>	<4511173D.7020702@shadowen.org>	<7vodtak00n.fsf@assigned-by-dhcp.cox.net>	<45116888.4050806@shadowen.org> <7vwt7yij12.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 14:07:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQNKn-0002RD-Au
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 14:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWIUMHA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 08:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWIUMHA
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 08:07:00 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:54546 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751053AbWIUMG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 08:06:59 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GQNK3-0001dr-0O; Thu, 21 Sep 2006 13:06:31 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwt7yij12.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27475>

Junio C Hamano wrote:
> Andy Whitcroft <apw@shadowen.org> writes:
> 
>>> About the quoting and parsing, language specific quoting mode is
>>> meant for git-for-each-ref to produce a string that can be eval'ed
>>> in the host language.  Think of the command as a tool to write a
>>> short program for you.
>> Thanks for the education.  Very simple, and very powerful.  I knew there
>> was a reason for it out there.  Will respin a V3 patch in a bit.
> 
> This probably showed that my initial description and example for
> the feature found in Documentation/git-for-each-ref was lacking.
> 
> I would appreciate a separate patch to enhance it if you are so
> inclined.

Actually the description in that manual page is pretty good.  But I
thought it was undocumented as the standard install does not install the
manual pages and I was getting the ones from my stable install to fool
me into thinking they were installed.  New developer error, doh.

That said I've taken the liberty of updating and clarifying the language
to make it very obvious from the outset that the language specific
output formats are for generating eval'able snippets and added a simple
example of it to complement your complex one.

Patch to follow.

-apw
