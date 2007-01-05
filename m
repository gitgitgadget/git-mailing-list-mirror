From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] [gitweb] Blame "linenr" link jumps to previous state at "orig_lineno"
Date: Fri, 5 Jan 2007 14:56:16 -0800 (PST)
Message-ID: <46370.61489.qm@web31814.mail.mud.yahoo.com>
References: <7vk602jfo7.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 23:56:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2xz6-0007YR-7B
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 23:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbXAEW4S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 17:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbXAEW4S
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 17:56:18 -0500
Received: from web31814.mail.mud.yahoo.com ([68.142.206.167]:42708 "HELO
	web31814.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750833AbXAEW4R (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jan 2007 17:56:17 -0500
Received: (qmail 62326 invoked by uid 60001); 5 Jan 2007 22:56:17 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=KKGVACfSevB0GJzoPtTGvk45/M2kwSwN03GvEywzo4aM2zS3I/jjDmCeSMpEgZQa/SbZZfnaygH+rrOinSakCGE17ZGQ9kZUVJcYX4bb/FedhUcf/RF8dUxuR1aoK+qmOar4fV/FMl7qRtmwhq1zYnxoO7WiqIV/M13S76Bli4k=;
X-YMail-OSG: S_fAcu0VM1nh3oqUWwvvKytBlk7D0h7dY34lsYtQtLvZXLNIv_RghKYwKhUL6zc6Xuu7Ng9xQsjjYoyM7Hf7w3RmsR7zUEfUONeYdfE1mBtwLlUGVAlnVZOvB4HjORqw06vmhBWSlIM-
Received: from [64.215.88.90] by web31814.mail.mud.yahoo.com via HTTP; Fri, 05 Jan 2007 14:56:16 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk602jfo7.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36037>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > A quick show-and-tell of this patch is after applying it, open
> > "blame" on a file, click on a linenr link of a block which
> > has only a single line changed -- the diff between what
> > you're seeing now and before is at least that line.  This you can
> > data-mine with gitweb back to where the line was introduced.  Similar
> > argument applies to blocks of more than one line.
> 
> One non-question and one question:
> 
>  - This favors the first parent, which is obviously the right
>    thing for most of the time.  I wonder what happens to a
>    merge, though, but I realize that a line attributed to a
>    merge is even rarer, and such a line is introduced by the
>    "evil merge".
> 
>  - I wonder if the line number is correct for the parent
>    commit.  How well does this work when you clicked a line that
>    was added at the end of the file, where the $orig_lineno goes
>    beyond the whole file in the parent?

It displayed the whole file, since the previous state of the
file I was looking at was short.  In effect for the case in
point it displays the bottom of the file.

If you remember, this had been my "white whale" for about a
year and a half now.  I accidentally "got it" while using
git-blame from shell prompt.

I think it's a worthwhile thing to have in gitweb.

   Luben
