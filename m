From: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Mon, 05 Sep 2005 10:26:33 +1000
Message-ID: <431B90B9.4000108@bigpond.net.au>
References: <200509042143.j84LhDZo020359@laptop11.inf.utfsm.cl> <7vmzmsbcuc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 02:26:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EC4ot-0007j8-9B
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 02:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVIEA0k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 20:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVIEA0k
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 20:26:40 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:63855 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932242AbVIEA0j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2005 20:26:39 -0400
Received: from [192.168.0.2] (really [147.10.133.38])
          by omta05ps.mx.bigpond.com with ESMTP
          id <20050905002634.OGSQ1454.omta05ps.mx.bigpond.com@[192.168.0.2]>;
          Mon, 5 Sep 2005 00:26:34 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzmsbcuc.fsf@assigned-by-dhcp.cox.net>
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 5 Sep 2005 00:26:34 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8072>

Junio C Hamano wrote:
> Horst von Brand <vonbrand@inf.utfsm.cl> writes:
> 
> 
>>>3. Non-binaries are called '*-scripts'.
>>>
>>>   In earlier discussions some people seem to like the
>>>   distinction between *-script and others; I did not
>>>   particularly like it, but I am throwing this in for
>>>   discussion.
>>
>>I for one think this makes the command name dependent on a non-essential
>>implementation detail, so -script should go.
> 
> 
> I had the same opinion.  The counter-argument people raised when
> this topic came up on the list was that it would help grepping
> in the source tree.
> 
> I'm tempted to suggest doing something along these lines:
> 
>  - Rename things that are implemented in shell from *-script to
>    *.sh, and perl to *.perl in the source tree;

*.pl is what is usually used for perl scripts.

> 
>  - Install them without .{sh,perl} suffix.
> 
> Once this is done, the users nor the 'git' wrapper do not have
> to deal with *-script.
> 
> Comments?
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
