From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Thu, 02 Aug 2007 18:58:07 +0200
Message-ID: <46B20D1F.1020308@alum.mit.edu>
References: <46AFCF3E.5010805@alum.mit.edu> <f8r09t$qdg$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 18:58:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGe0A-0007cB-FB
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 18:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbXHBQ6P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 12:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbXHBQ6P
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 12:58:15 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40391 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbXHBQ6O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 12:58:14 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.178.20] (p5B17FC13.dip.t-dialin.net [91.23.252.19])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l72Gw8N5030116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 2 Aug 2007 18:58:09 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
In-Reply-To: <f8r09t$qdg$1@sea.gmane.org>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54570>

Jakub Narebski wrote:
> Michael Haggerty wrote:
> Have you contacted Jon Smirl about his unpublished work on cvs2git,
> cvs2svn based CVS to Git converter?

Yes, I am familiar with Jon Smirl's work, and as soon as he let us know
what he was working on, we tried to help.  Unfortunately the cooperation
was not very fruitful.

- While Jon was (unknown to us) working on his git output patch, I was
working on a big cvs2svn rewrite to make cvs2svn more robust and easier
to hack.  By the time he contacted us, his patch did not apply to the
cvs2svn code.  The refactoring that obsoleted the patch, in fact, was
largely to remedy the very same architectural problems that were
hampering his work.

- In my opinion, Jon misdiagnosed the reason for the "fragmented branch
creation" problem that he claimed was preventing a clean conversion to
git, and he felt that we were not interested in fixing the problem.  In
fact, I was working on fixing another problem that I believe was the
*real* reason for the fragmented branch creation.  This fix is
implemented in cvs2svn version 2.0.

> Footnotes:
> ----------
> [*] If I remember correctly authors of cvs2svn were talking about separating
> the code dealing with disentangling CVS repository structure from the part
> translating it into Subversion repository (with its quirks), and the part
> generating Subversion repository.

Yes, this is now done, which was why it was only a couple of days of
programming for me to add a git output option.

Michael
