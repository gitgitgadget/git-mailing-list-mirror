From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: [PATCH] Git.pm: Use File::Temp->tempfile instead of ->new
Date: Mon, 1 Sep 2008 13:03:06 +0200
Message-ID: <48BBCBEA.8000301@statsbiblioteket.dk>
References: <48BBB59F.9080204@statsbiblioteket.dk> <vpqvdxggpw6.fsf@bauges.imag.fr> <20080901100435.GC6555@toroid.org> <48BBC20E.20808@statsbiblioteket.dk> <20080901104222.GA10026@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Petr Baudis <pasky@suse.cz>
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Mon Sep 01 13:04:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka7D1-0007DV-9i
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 13:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756982AbYIALDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 07:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756006AbYIALDJ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 07:03:09 -0400
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:15168 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754703AbYIALDJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Sep 2008 07:03:09 -0400
Received: from [130.225.25.181] (130.225.25.181) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.1.291.1; Mon, 1 Sep 2008 13:03:06 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080820)
In-Reply-To: <20080901104222.GA10026@toroid.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94574>

Abhijit Menon-Sen wrote:
> Perl 5.8.0 ships with File::Temp 0.13, which does not have the new()
> interface introduced in 0.14, as pointed out by Tom G. Christensen.
> 
> Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
> ---
> 
> At 2008-09-01 12:21:02 +0200, tgc@statsbiblioteket.dk wrote:
>> Wouldn't it be possible to accomplish the same as File::Temp->New with
>> the old File::Temp?
> 
> OK, does this one work for you?
> 
Nope.
I applied it to 1.6.0.1 and now get this error instead:

Parentheses missing around "my" list at 
/builddir/build/BUILD/git-1.6.0.1/t/../git-svn line 4387.
Attempt to release temp file '' that has not been locked at 
/builddir/build/BUILD/git-1.6.0.1/t/../git-svn line 3294
Can't call method "opened" on an undefined value at 
/builddir/build/BUILD/git-1.6.0.1/t/../perl/blib/lib/Git.pm line 1001.

-tgc
