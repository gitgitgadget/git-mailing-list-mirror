From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Fri, 27 Apr 2007 19:03:31 +0100
Message-ID: <200704271903.33263.andyparkins@gmail.com>
References: <7v7is3inbw.fsf@assigned-by-dhcp.cox.net> <200704271019.56341.andyparkins@gmail.com> <alpine.LFD.0.98.0704271002310.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 20:03:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhUnQ-0004um-K1
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 20:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251AbXD0SDt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 14:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756396AbXD0SDt
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 14:03:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:55795 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251AbXD0SDs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Apr 2007 14:03:48 -0400
Received: by ug-out-1314.google.com with SMTP id 44so864601uga
        for <git@vger.kernel.org>; Fri, 27 Apr 2007 11:03:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YNhKXzXS9ZirefAUwWwPWckXuR4IcVlWZimzJ7HufJrIuXAnweqlikN/WlQJbeDSnAofL+ULTwdsgh9g5YG/8KEKIIHbALxthLvzb+mvYzPJGDN7xgJUR/4IorDdGyERl7872+JlcnEReWtrntiswYMxkLXX5FhhqsR5Enz16lU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QuEv0VDvrxQgFJyciT0BRMLHzkHHgoAELOXdpM6/9w66WMGv06rwcazwUDfRuqdaDxWCPLJpatUSMXwvWPdJD9Wg1NORprqIuCyMzvHxLbFzUSkGvohWXqxOmbh8gWguIsyQ1CHKfsRUT/VQjSfoXE8RrfgjLz2bqswFBRdn9QA=
Received: by 10.67.106.3 with SMTP id i3mr3174735ugm.1177697026625;
        Fri, 27 Apr 2007 11:03:46 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id s7sm1683535uge.2007.04.27.11.03.44;
        Fri, 27 Apr 2007 11:03:44 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <alpine.LFD.0.98.0704271002310.9964@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45738>

On Friday 2007, April 27, Linus Torvalds wrote:

> I'm personally really really sure. The whole point of subprojects (at

Fair enough.  I just hadn't seen very much talk about this issue and 
wanted to make sure.

> trouble with the new feature: at a minimum, git-fsck would always
> complain about the invalid mode (and things like "git diff" would too
> - I think it used to just die on unknown modes).

That kind of settles it really - if neither implementation would have 
worked with non-submodule git then the decision must come down to which 
is technically better - and I'm persuaded that the extra layer of 
indirection doesn't actually gain anything other than some extra 
objects to track.

>  - with 1.5.2, git will be good enough to _serve_ stuff, even if it
> might not be very usable for the client-side operations. So

>From my point of view, I don't really mind manually fetching the 
submodules.  I very much appreciate that I don't _have_ to have the 
submodules for the superproject to continue to work.

I was actually surprised how little I'm finding I need submodule support 
in the porcelain.  The only slight problem at the moment is with 
git-checkout; switching from a branch with the supermodule to a branch 
without it and back needs a bit of hoop jumping, but nothing too 
painful.  All in all - success all over.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
