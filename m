From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] A more sensible error message why 'git rebase --continue'
 failed
Date: Mon, 20 Aug 2007 21:59:02 +0800
Message-ID: <46C99E26.2020009@midwinter.com>
References: <11875724181583-git-send-email-evan@fallingsnow.net> <7vzm0m90ye.fsf@gitster.siamese.dyndns.org> <2D8BF484-7990-4DDC-9E52-69143D4BA413@fallingsnow.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Evan Phoenix <evan@fallingsnow.net>
X-From: git-owner@vger.kernel.org Mon Aug 20 15:59:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN7mq-0003vN-Hs
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 15:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177AbXHTN7L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 09:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752357AbXHTN7L
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 09:59:11 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:38613 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755452AbXHTN7K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 09:59:10 -0400
Received: (qmail 4634 invoked from network); 20 Aug 2007 13:59:10 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=rzW4FMnx+eSQzN7L/Tww8TIzJKUf4QpuCXq8buhNws+J2Ga2nuXcG/3z489mtGMP  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 20 Aug 2007 13:59:09 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <2D8BF484-7990-4DDC-9E52-69143D4BA413@fallingsnow.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56218>

Evan Phoenix wrote:
> How about something like
>
> "Please verify all merge conflicts in all modified files, then run
> 'git add' to resolve them."

Since we're nitpicking language here... "git add" doesn't resolve 
anything. *You* resolve the conflicts (by editing the file and removing 
the conflict markers and editing the code, by running git mergetool, 
etc.) then you run "git add" to tell git that you're done resolving.

If I literally followed the above, I would run "less" on a file, say, 
"Yep, git flagged all the merge conflicts correctly," then run "git add" 
figuring it would pop me into some kind of conflict resolution UI. 
Actually it's worse than that -- the above implies that all modified 
files will have merge conflicts, which is certainly not true in many cases.

How about:

"Please resolve all merge conflicts, then run 'git add' to tell git you've
finished resolving each file."

-Steve
