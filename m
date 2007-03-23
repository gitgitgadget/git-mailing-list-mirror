From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: Errors pushing tags in "next"
Date: Fri, 23 Mar 2007 00:44:49 -0700 (PDT)
Message-ID: <382665.13897.qm@web31804.mail.mud.yahoo.com>
References: <7vmz24sid9.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 08:44:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUeSD-0007ip-O1
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 08:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbXCWHov (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 03:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbXCWHov
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 03:44:51 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:36012 "HELO
	web31804.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751947AbXCWHou (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Mar 2007 03:44:50 -0400
Received: (qmail 17046 invoked by uid 60001); 23 Mar 2007 07:44:49 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=sXzHOzbp/RuTNBzRb+SqGqay73EaTDZyljTZjnytCmh5iKkQupFcWQdC0HeYso22uAjKwm7e0wfIrwFYeZf3DbXSuq0fR7inYW5KbyxjlMuyGDPC0uxZ72mXn4xJJEWyPQ2AFzTkFclmxbGdUagNvGoZQS96PQbjDjeDs8xBDYo=;
X-YMail-OSG: n0cWnxgVM1nRT.cE58T3DUQ4GD6ckzLhAPQAjoqwdOlLo2HUZUbZxNloM0imarOMITMl7itu8eM5tT8GCXwYVyUJM_XyotF3WFiRssixRu12zH7cUkGXhihIYZgy1_xFOINVXsVOUOmNIW72JLfO7g--
Received: from [68.186.59.161] by web31804.mail.mud.yahoo.com via HTTP; Fri, 23 Mar 2007 00:44:49 PDT
In-Reply-To: <7vmz24sid9.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42909>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > --- Junio C Hamano <junkio@cox.net> wrote:
> >
> >> Luben Tuikov <ltuikov@yahoo.com> writes:
> >> 
> >> > Is this of any concern?
> >> 
> >> Sorry, I cannot tell without a command line.
> >
> > Sorry, I didn't include that.  It is:
> >
> > git-push --tags web
> >
> >    Luben
> >> 
> >> > ### Pushing version 'v2.6.21-rc4' to the masses
> >> > fatal: ambiguous argument 'v2.6.21-rc3-329..bac6eefe96204d0ad67d144f2511a6fc487aa594':
> unknown
> >> > revision or path not in the working tree.
> >> > Use '--' to separate paths from revisions
> >> > fatal: ambiguous argument 'v2.6.21-rc3-329..bac6eefe96204d0ad67d144f2511a6fc487aa594':
> unknown
> 
> Well, *I* don't say '### Pushing version blah to the masses', so
> it's hard to diagnose from this output.  Is it coming from some
> of your own script (perhaps update hook on the receiving end)?

No, I don't have a script hooked onto git-push.

BTW, git has always said to me "Pushing version ... to the masses"
whenever I'd do "git-push --tags web".

On the receiving end, I've only the standard git hooks enabled.
In fact only "post-update" is enabled.

   Luben


    Luben
