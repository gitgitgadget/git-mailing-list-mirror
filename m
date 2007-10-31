From: Andreas Ericsson <ae@op5.se>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 22:07:33 +0100
Message-ID: <4728EE95.1020004@op5.se>
References: <20071030160232.GB2640@hermes.priv> <alpine.LFD.0.999.0710301037120.30120@woody.linux-foundation.org> <vpq8x5kh4rr.fsf@bauges.imag.fr> <alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org> <4727839B.9070205@obry.net> <alpine.LFD.0.999.0710301232000.30120@woody.linux-foundation.org> <20071030235823.GA22747@coredump.intra.peff.net> <fg8h9l$b4n$1@ger.gmane.org> <85lk9jzsxb.fsf@lola.goethe.zz> <alpine.LFD.0.999.0710310816180.30120@woody.linux-foundation.org> <20071031204729.GB13300@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Kastrup <dak@gnu.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 22:08:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InKn6-0000bO-Ok
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916AbXJaVHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 17:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbXJaVHl
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:07:41 -0400
Received: from mail.op5.se ([193.201.96.20]:54321 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbXJaVHl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 17:07:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 745F9173072B;
	Wed, 31 Oct 2007 22:07:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id laaCDddwhALX; Wed, 31 Oct 2007 22:07:16 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id D4B7D1730729;
	Wed, 31 Oct 2007 22:07:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071031204729.GB13300@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62869>

Jeff King wrote:
> On Wed, Oct 31, 2007 at 08:28:36AM -0700, Linus Torvalds wrote:
> 
>> Because we don't care! This is *exactly* why I brought up the whole 
>> discussion about "interoperability with a web browser", and pointed out 
>> that there is no such thing *anyway*, since a GIT URL is generally not 
>> suitable for browsing _regardless_ of any encoding issues!
>>
>> So it doesn't matter one whit if a mail client recognizes GIT URL's or 
>> not! Because the mail client cannot do the right thing with them anyway, 
>> and would generally think that it's something that it should highlight so 
>> that you can browse it!
> 
> Two points:
> 
>  1. Just because _your_ mail client can't do anything useful with git
>     URLs^H^H^H^H repo specifications, doesn't mean that others can't.
> 
>  2. You are conflating syntax and semantics. Think of the task I
>     mentioned as two subtasks: pulling the location specifier from the
>     email, and then doing something useful with it (in this case,
>     git-cloning it it). The first subtask depends _only_ on a parseable
>     syntax. The user can provide the context necessary for accomplishing
>     the second subtask.
> 
> For example, consider a terminal that, upon pressing some keyboard
> combination, will highlight the first URL-ish looking blob on the
> screen, prompt you for a command, and then execute '$command $url'.  The
> terminal doesn't have to know the semantics of the blob, but it has to
> know the syntax. The user provides the semantics.
> 
> And yes, such a terminal exists, and I'm using it right now.
> 

Great. Now you just need a git-repo with an url that needs quoting, and
this discussion could at least potentially solve a real problem for someone.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
