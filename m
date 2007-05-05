From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 04 May 2007 18:15:21 -0700
Message-ID: <7vtzusoyty.fsf@assigned-by-dhcp.cox.net>
References: <463ADE51.2030108@gmail.com>
	<56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
	<7v7irpuhhr.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
	<463AFAAE.853DEF7B@eudaptics.com>
	<7vabwktsng.fsf@assigned-by-dhcp.cox.net> <f1gg1o$p52$2@sea.gmane.org>
	<7vy7k4p24s.fsf@assigned-by-dhcp.cox.net>
	<56b7f5510705041752o74b59284x872480e4413f83ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 03:15:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk8ru-0003yW-Oy
	for gcvg-git@gmane.org; Sat, 05 May 2007 03:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423187AbXEEBPY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 21:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423346AbXEEBPY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 21:15:24 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:44063 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423187AbXEEBPW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 21:15:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070505011522.NCQB1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 4 May 2007 21:15:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vDFM1W00e1kojtg0000000; Fri, 04 May 2007 21:15:22 -0400
In-Reply-To: <56b7f5510705041752o74b59284x872480e4413f83ab@mail.gmail.com>
	(Dana How's message of "Fri, 4 May 2007 17:52:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46236>

"Dana How" <danahow@gmail.com> writes:

> On 5/4/07, Junio C Hamano <junkio@cox.net> wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> > I'm not sure about "<tree-ish>:<path>" with <path> being relative by
>> > default. For me it is <path> in <tree-ish> (like in
>> > "git-ls-tree -r <tree-ish>" result).
>>
>> That's right (and Dscho is also).
>>
>> "v1.5.1:git.c" IS "git.c that appears at the toplevel of
>> v1.5.1's tree."
>>
>> Ok, for now let's forget about this relative stuff.
>
> Hmm, most of the work I do in the parts of our
> perforce repository I want to convert to git is
> far enough down...

The key word in my statement is "for now".  I simply declared
that I do not want to think about it further until 1.5.2 final,
that's all.

I am not opposed to give an escape hatch for your problem; I am
quite in favor of that, and I think Alex/J6t's "./" syntax is a
reasonable compromise.
