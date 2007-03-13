From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Remove tab character from conflicted files list part of the merge message
Date: Tue, 13 Mar 2007 15:18:39 +0000
Message-ID: <200703131518.54076.andyparkins@gmail.com>
References: <200703131309.43767.andyparkins@gmail.com> <Pine.LNX.4.63.0703131539430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 16:19:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR8mZ-0003JN-SP
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 16:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbXCMPTQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 11:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753264AbXCMPTQ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 11:19:16 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:39054 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbXCMPTP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 11:19:15 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2043251wxd
        for <git@vger.kernel.org>; Tue, 13 Mar 2007 08:19:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tHbF5iY+MfIhxAex9El3AevtlfeZ36I0Fr97G3+hXbYW9LNMwPpfpbABVcMFXVjWbvFqSiOafE0UwdfqQQXSGKYcPa56YRQwm0KdsDcUiqDZNAWQZVoyS6nyS6HAlHoAsoep7UzlpRVpNLtyMryYVYxxHUQxH6hSAWsB5oiwB8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KQrSU/HM1mwQB8YtNx1P3Ol3N5XHU8os9axolBTZc4Clv7HNmi9bZpxeEfSxoh+IUUfG3A1trH9UR5Jh+hYcmAaSP0TXfnGZ2Ygsc8hlfV/O+nbyU+ChY7l6ahW5GYPZPizXVQF6XvOrYFgUy20BzSbjcTUN/FDuI3/ki7bE4xE=
Received: by 10.90.32.14 with SMTP id f14mr5935558agf.1173799153915;
        Tue, 13 Mar 2007 08:19:13 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c10sm21674770nfb.2007.03.13.08.19.13;
        Tue, 13 Mar 2007 08:19:13 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0703131539430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42120>

On Tuesday 2007 March 13 14:42, Johannes Schindelin wrote:

> And of course the next guy will have the reverse problem, because he typed
> <TAB><SPACE> instead of <SPACE>*5. What do you tell _him_ after "fixing"
> this issue? "Do as _I_ do"?

That's basically what you're telling me by saying I can't have that change.  
But as it happens, no I wasn't doing this as a "do it my way" kind of thing.  
As it happens I /like/ tabs in my source code.  However, this isn't source 
code.

Let's forget my own problem - I was only offering it as backstory.  Consider a 
log message with no additional comments about the conflicts.  The current 
output looks like this:

Conflicts:
\tfile1.c
\tfile2.c

Now, view this message on the terminal with git-log, now view it in gitk, now 
view it in qgit, now view it in git-gui.  All of these could be set for 
different tab widths, and will hence display the log message differently.

git-merge has to pick one or the other - tabs or spaces - for me, I'd rather 
pick the one that means the message displays the same regardless of what the 
author of the viewer/terminal thought tabs should be set to that day.  I'd 
also prefer that when others view the log there is more chance that they'll 
see the same as I do.

Of course, there is nothing we can do if a log message author chooses to put 
tabs in - but at least if git uses spaces the choice isn't already made.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
