From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: quick bare clones taking longer?
Date: Thu, 10 May 2007 11:38:59 -0400
Message-ID: <2FFB6305-AB01-4C78-9831-18522C0FFE79@silverinsanity.com>
References: <7virb1sm6h.fsf@assigned-by-dhcp.cox.net> <20070509.150256.59469756.davem@davemloft.net> <7v3b25siwk.fsf@assigned-by-dhcp.cox.net> <20070509.162301.48802460.davem@davemloft.net> <7vy7jxr35a.fsf@assigned-by-dhcp.cox.net> <7vd519r10c.fsf@assigned-by-dhcp.cox.net> <vpqtzul3xzm.fsf@bauges.imag.fr> <7vejlpkruy.fsf@assigned-by-dhcp.cox.net> <vpq4pmlys5b.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu May 10 17:39:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmAjZ-0007da-4y
	for gcvg-git@gmane.org; Thu, 10 May 2007 17:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758383AbXEJPjH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 11:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757610AbXEJPjG
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 11:39:06 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:59045 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756866AbXEJPjF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 11:39:05 -0400
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 060801FFC003;
	Thu, 10 May 2007 15:39:03 +0000 (UTC)
In-Reply-To: <vpq4pmlys5b.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46872>


On May 10, 2007, at 4:55 AM, Matthieu Moy wrote:

> Junio C Hamano <junkio@cox.net> writes:
>
>> Is that a serious question?
>
> It is. I have to admit that my knowledge about POSIX kind of things on
> windows approaches zero, but a hardcoded /bin/something path sounds
> suspicious to me.

I think every POSIX environment provides _something_ for /bin and / 
usr/bin.  There are too many scripts that start "#!/bin/bash" or "#!/ 
usr/bin/env interpreter" for it not to.  And to be POSIX, the basic  
utilities (like pwd and env) should be in there.  Someday Git may  
work on Windows without a funny (for MS) environment.  But that day  
is not today.  Tomorrow doesn't look too good either.  ;-)

~~ Brian
