From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: Git 1.6.0.1 breaks git-svn with perl 5.8.0
Date: Mon, 1 Sep 2008 12:13:52 +0200
Message-ID: <48BBC060.6080809@statsbiblioteket.dk>
References: <48BBB59F.9080204@statsbiblioteket.dk> <vpqvdxggpw6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Sep 01 12:15:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka6Rf-0001kv-CU
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 12:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051AbYIAKNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 06:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbYIAKNy
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 06:13:54 -0400
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:14013 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753897AbYIAKNy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Sep 2008 06:13:54 -0400
Received: from [130.225.25.181] (130.225.25.181) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.1.291.1; Mon, 1 Sep 2008 12:13:52 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080820)
In-Reply-To: <vpqvdxggpw6.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94559>

Matthieu Moy wrote:
> "Tom G. Christensen" <tgc@statsbiblioteket.dk> writes:
> 
>> The problem is that Git.pm depends on the "new" method of File::Temp
>> introduced in 0.14.
>> perl 5.8.0 only has File::Temp 0.13 while 0.14 was included with 5.8.1
>> and later.
>> The breakage was introduced in this commit:
>> e41352b24e29eba43d00a3fd117befaef1d594bc
> 
> Isn't that fixed by c14c8ceb13b299892f286757e22e6af4f6cffab5 ?
> (Git.pm: Make File::Spec and File::Temp requirement lazy, a few
> commits before 1.6.0)
> 
I don't see how it is relevant.
It does not remove the implicit requirement on File::Temp > 0.13.

-tgc
