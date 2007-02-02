From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 17:59:22 +0100
Message-ID: <200702021759.22603.jnareb@gmail.com>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <epvnln$fmn$1@sea.gmane.org> <Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mercurial@selenic.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 17:58:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD1jl-0000Is-Kk
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 17:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945990AbXBBQ6F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 11:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945987AbXBBQ6F
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 11:58:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:41839 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945986AbXBBQ6D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 11:58:03 -0500
Received: by ug-out-1314.google.com with SMTP id 44so811046uga
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 08:58:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ontMkgBuL8v6fCG+TyDGX5X/0sHBBsWoCb0+lLfnULZ5U6/X7+sgSV2fGk8XHrTQ/Q/4K0/EeQtAF4K1jVviR1IDIfhFLHzxACONwjLUmcpw2L8/JYrNH94qY2FO+hvWV5tjwPLafM4mDB0wf7W9IHxI5tF3ZQwKArqkASN9q6s=
Received: by 10.67.89.5 with SMTP id r5mr4662042ugl.1170435481338;
        Fri, 02 Feb 2007 08:58:01 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id s1sm4587826uge.2007.02.02.08.58.00;
        Fri, 02 Feb 2007 08:58:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38515>

Linus Torvalds wrote:
> 
> On Fri, 2 Feb 2007, Jakub Narebski wrote:
>> 
>> Gaaah. Why anyone would want to have non-propagated tags?
> 
> That's *definitely* not the mistake.

Ermmm... right. Now that I thought about it a bit...

> I use private tags (and branches, for that matter) all the time. I'd be 
> very upset indeed if all my tags were always pushed out when I push 
> something out.

Well, in git you can have private tags (anything not under refs/tags
or under refs/heads is by default private), but I think you can only
have not published branches (which are not pushed to public repository).
If it is not true, then how one can have private branches 
(i.e. branches which 'push --all' would not push)?

-- 
Jakub Narebski
Poland
