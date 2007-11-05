From: Michael Cohen <michaeljosephcohen@mac.com>
Subject: Re: [RFC PATCH] OSX Mail.app IMAP cache support for git-mailsplit?
Date: Mon, 5 Nov 2007 07:09:26 -0500
Message-ID: <7B84FFB7-5FE9-4D24-AEC5-43F667B59876@mac.com>
References: <06FE21A2-20D0-4AAA-B0C7-35783C604B68@mac.com> <7B209F05-B720-41D6-AE98-39FAFF04B9F6@mac.com> <Pine.LNX.4.64.0711051034060.4362@racer.site>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 05 13:09:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip0m2-0003nt-HH
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 13:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbXKEMJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 07:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbXKEMJd
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 07:09:33 -0500
Received: from smtpoutm.mac.com ([17.148.16.74]:57853 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977AbXKEMJc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 07:09:32 -0500
Received: from mac.com (asmtp007-s [10.150.69.70])
	by smtpoutm.mac.com (Xserve/smtpout011/MantshX 4.0) with ESMTP id lA5C9UlE002882;
	Mon, 5 Nov 2007 04:09:30 -0800 (PST)
Received: from mac-pro.lan (c-71-196-112-35.hsd1.fl.comcast.net [71.196.112.35])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp007/MantshX 4.0) with ESMTP id lA5C9RFi006111
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 5 Nov 2007 04:09:28 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711051034060.4362@racer.site>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63501>

On Nov 5, 2007, at 5:39 AM, Johannes Schindelin wrote:

> Hi,
>
> you have a very weird mail setting; I had to add the git list back  
> to the
> Cc.  This is just annoying enough for me to write an extra paragraph  
> to
> annoy you back ;-)
Have to get used to this; thank you. :)

> Several comments (your patch not inlined, since you did not inline it
> either):
>
> - there needs to be a space between the ) and the { in the first if  
> line.
Doh. done.

> - you probably forgot to remove the original "if (populate...)...".   
> That
>  means that populate would be called _twice_, even if successful.

good catch.

> - git is written in C.  Therefore, "//" as a way to comment out is  
> wrong.

> - if you still return -1 when the dir could not be opened, I wonder  
> what
>  the rationale is to comment the error out.

More work needs to be done in there and in builtin-mailinfo.c to  
massage the mail format that Apple is using.  Also what I think I need  
to do there is check the path that is being tested and print something  
like "%s/cur could not be found, trying alternate path" on the first  
test?


> P.S.: You might want to send patches as these right away, without  
> asking
> if anybody cares (you'll see that very soon), but rather in accord  
> with
> Documentation/SubmittingPatches.

Thanks for that. 
  
