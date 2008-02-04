From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: New to git: sorry for obvious question.
Date: Mon, 04 Feb 2008 12:51:23 +0200
Message-ID: <47A6EE2B.7050500@panasas.com>
References: <47A6E130.7090909@glidos.net> <vpq4pcp6moq.fsf@bauges.imag.fr> <47A6EBBD.9060500@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 11:52:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLyvw-0006Xq-Tb
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 11:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbYBDKvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 05:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbYBDKvm
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 05:51:42 -0500
Received: from bzq-219-195-70.pop.bezeqint.net ([62.219.195.70]:36060 "EHLO
	bh-buildlin2.bhalevy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbYBDKvl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 05:51:41 -0500
Received: from bh-buildlin2.bhalevy.com (localhost.localdomain [127.0.0.1])
	by bh-buildlin2.bhalevy.com (8.14.1/8.14.1) with ESMTP id m14ApNxi025134;
	Mon, 4 Feb 2008 12:51:24 +0200
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47A6EBBD.9060500@glidos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72488>

On Mon, Feb 04 2008 at 12:41 +0200, Paul Gardiner <osronline@glidos.net> wrote:
> Matthieu Moy wrote:
>> Paul Gardiner <osronline@glidos.net> writes:
>>
>>> Hi,
>>>
>>> I've moved a project from CVS on sourceforge to git on repo.or.cz.  I
>>> want a local mirror on my own home server, so that it appears amongst
>>> the projects shown by my own gitweb set up, and so it gets caught by
>>> my backup system.  I've created the mirror with
>>>
>>>   git clone --bare <remote-url> <local-dir>
>>>
>>> and that seems fine.  But how do I now keep it up to date.  I was
>>> guessing a cron job doing some sort of git pull, but pull doesn't
>>> look to work on --bare proj.git type repositories.
>> You probably want "git fetch". Actually, "git pull" does a fetch first
>> (get the remote revisions that you don't have), and then a merge with
>> your working tree.
> 
> Yeah, that's what I thought, but it doesn't seem to work with --bare
> repositories that are of the form proj.git, rather than having a dir 
> proj containing checkout files and a .git folder. Both pull and fetch
> say that it isn't a git repository (although I can view it under gitweb,
> and I can clone and pule from it).
> 
> 
git-remote update is your friend then

Boaz
