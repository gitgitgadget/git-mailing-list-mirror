From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Getting started contributing.
Date: Sun, 3 Feb 2013 13:34:54 -0000
Organization: OPDS
Message-ID: <77A6ABB842334FFFA04970DEAFAB6D0D@PhilipOakley>
References: <1359872508519-7576834.post@n2.nabble.com> <7vd2whalax.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
To: "adamfraser" <adamfraser0@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 14:35:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1zj5-0007EG-Jh
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 14:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab3BCNe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 08:34:56 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:46146 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752698Ab3BCNey (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Feb 2013 08:34:54 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlYJALFmDlFcHmfN/2dsb2JhbAA+BowEsioEgQAXc4IaBQEBBQgBAS4eAQEhCwIDBQIBAxUBCyUUAQQIEgYHCQENBhMIAgECAwGHbgMTCLUPDYlSBIwdgRkJDIMmYQOIMIVXhkCNF4USgnw
X-IronPort-AV: E=Sophos;i="4.84,593,1355097600"; 
   d="scan'208";a="564693792"
Received: from host-92-30-103-205.as13285.net (HELO PhilipOakley) ([92.30.103.205])
  by out1.ip06ir2.opaltelecom.net with SMTP; 03 Feb 2013 13:34:52 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215308>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Sunday, February 03, 2013 7:49 AM
> adamfraser <adamfraser0@gmail.com> writes:
>
>> I've done a little searching and
>> haven't been able to find an official bug tracker for git is there 
>> somewhere
>> I can find some bugs to help fix?
>
> You came to the right place.  A new bug or regression is reported to
> this list, and it often is fixed (or often diagnosed as pebcak)
> fairly quickly by list regulars.  Nobody maintains a bugzilla that
> is not maintained and is full of stale/invalid bug reports.
>
> The best contribution a new person can make is to use the software
> regularly and find issues.  It is very hard to find real bugs that
> can easily be fixed by somebody totally new to the codebase in Git
> these days.
>
> On the other hand, there probably still are many loose ends.  When a
> command is supposed to take only two arguments because taking more
> than three does not make any sense, for example, it has not been
> unusual for us to document the two-argument form of the command,
> reject if the user gives only one argument with an error message,
> but we simply ignore the third argument if the user mistakenly runs
> the command with three arguments, instead of erroring out (i.e. the
> code does not bother to help insane or too inexperienced users).
> That kind of things are hard to find by users experienced with Git
> exactly because they know running such a command with three or more
> arguments is nonsense, and they do not even try to make such a
> mistake.  Still, it would be very nice to find and fix such issues.
>
A review of the git-user list 
https://groups.google.com/forum/?fromgroups#!forum/git-users is one 
place to discover some of the user issues and thinking about how to 
address them. Or resurrect issues from this Git list. E.g. There are a 
number of sub-module improvements available there.

If you have any Windows experience the MSysGit team 
https://github.com/msysgit/msysgit is always looking for help on some of 
the compatibility issues, e.g. where the Linux optimisations conflict 
with the Windows approaches.

Another area is picking out documentation issues you have seen and 
submitting patches for them, whether in the command man pages or in the 
guides. On my 'todo' list is to make the `help` command actually list 
the "Help me" (i.e. guides and articles) pages, not just the command man 
pages.

I also had -
* Bulk move detection (when folk change/move upper level directory 
names).
* add a .gitnevermerge option to stop private files you don't want in 
'master' (or any other branch) to be merged

Philip
