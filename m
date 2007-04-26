From: "Mike Coleman" <tutufan@gmail.com>
Subject: Re: suggested feature: completely expunge a file (or just a delta) a la rebase
Date: Thu, 26 Apr 2007 09:50:08 -0500
Message-ID: <3c6c07c20704260750o68b1d296kc30c17e54a593023@mail.gmail.com>
References: <3c6c07c20704252248q3cd82d4cgcffb9852fa261a70@mail.gmail.com>
	 <7virbju17h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 16:50:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh5Ic-0007y2-SQ
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 16:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031236AbXDZOuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 10:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031233AbXDZOuR
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 10:50:17 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:25104 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031236AbXDZOuP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 10:50:15 -0400
Received: by an-out-0708.google.com with SMTP id b33so253325ana
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 07:50:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g5Q8IY9Jkh5blfurKg9fGonNkT/LXVgWkl171klw1h5/tYIiX3t6aIQqcO6i3zo4m7vvTCUE8nkABfz8e0Fl8XCOFJEwQMxOarrPJNx62ulgn5zgttilXjgyFLxpzMkzkxzLZOZRHh6/PgtW1sgdV/3ifpfB8j9JUsbLJH/bfEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SrM9iU2wbTdHN+0kqvr5Yuben+VX2mPBPM+JbQSmRmxqwI2lhx4gfKxeLRGLzDA5avRJVxt03uOeX02/6TWsceemgi85ktYzBZhbttL4e137f8fGAKY3XO+VyD3K7tx7blJ72FELBGf7dgrDUHqLJ6nVSayCfWfaduwcny6fP2w=
Received: by 10.100.171.16 with SMTP id t16mr1170072ane.1177599009023;
        Thu, 26 Apr 2007 07:50:09 -0700 (PDT)
Received: by 10.100.131.10 with HTTP; Thu, 26 Apr 2007 07:50:08 -0700 (PDT)
In-Reply-To: <7virbju17h.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45636>

On 4/26/07, Junio C Hamano <junkio@cox.net> wrote:
> There have been talks about polishing cg-rewritehist into a
> shape suitable for inclusion in core git.git, now Cogito is not
> actively developed anymore.

Ah, that looks like it'd fit the bill.  I may see if it'll still work
for my simple case.  Thanks for the pointer.

> I think the first thing to fix is its name "rewritehist", which
> may technically be correct, feels a bit too ugly ;-)

Naming is very important.  I seem to recall hearing (from PE) that one
of the early Unix guys was later asked if there was anything they'd
change in hindsight.  Their response: they'd spell "creat" with an
'e'.
