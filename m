From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 4 May 2007 22:21:43 +0200
Message-ID: <20070504202143.GA4033@steel.home>
References: <463ADE51.2030108@gmail.com> <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com> <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net> <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com> <463AFAAE.853DEF7B@eudaptics.com> <7vabwktsng.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 04 22:21:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk4Hn-0005CL-4S
	for gcvg-git@gmane.org; Fri, 04 May 2007 22:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031359AbXEDUVr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 16:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031529AbXEDUVr
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 16:21:47 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:55209 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031359AbXEDUVq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 16:21:46 -0400
Received: from tigra.home ([195.4.202.37] [195.4.202.37])
	by post.webmailer.de (klopstock mo57) (RZmta 5.8)
	with ESMTP id I01559j44GKbEy ; Fri, 4 May 2007 22:21:44 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 64EA5277BD;
	Fri,  4 May 2007 22:21:44 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id BB613D171; Fri,  4 May 2007 22:21:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vabwktsng.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl9Ag==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46210>

Junio C Hamano, Fri, May 04, 2007 19:17:39 +0200:
> Do people like that plan?
> 
> (soon after 1.5.2)
> 
>  - start accepting "<something>:./<path>" as "relative to where I am".
> 
>  - start accepting "<something>:?<string>" as "look back to find
>    the string".

Still don't like the feature. It makes things special: suddenly we
have to be careful about not having files with a "?" as their first
symbol (well, scripts always can prepend "./" or "/")

And it is hard to use: only prefix, must be unambiguous and is
case sensitive.

>  - clearly explain the plan and prepare the users.
> 
> (a big release in the future, perhaps 1.6.0)
> 
>  - "<something>:<path>" becomes relative to where you are.
>  - stop "<something>:/<string>" and start "<something>:/<fullpath>".

I like the plan.
