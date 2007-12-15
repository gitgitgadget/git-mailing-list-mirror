From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git merge --no-commit <branch>; does commit
Date: Sat, 15 Dec 2007 19:26:53 +0100
Message-ID: <20071215182653.GB22485@atjola.homenet>
References: <alpine.LSU.0.99999.0712132151080.5326@castor.milkiway.cos> <81b0412b0712131319h63609810m593f0e552d02a83c@mail.gmail.com> <alpine.LSU.0.99999.0712132224280.5606@castor.milkiway.cos> <20071214074925.GA3525@steel.home> <alpine.LSU.0.99999.0712151905280.4341@castor.milkiway.cos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Sat Dec 15 19:27:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3bjL-0005Tl-Fl
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 19:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563AbXLOS05 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Dec 2007 13:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755144AbXLOS05
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 13:26:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:42310 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753250AbXLOS04 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 13:26:56 -0500
Received: (qmail invoked by alias); 15 Dec 2007 18:26:54 -0000
Received: from i577B8893.versanet.de (EHLO localhost) [87.123.136.147]
  by mail.gmx.net (mp002) with SMTP; 15 Dec 2007 19:26:54 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19jh9oVpQljh/sd/1zf67rh+AmX9OMdD3VIPdu59z
	UUGmTwu5DIBShI
Content-Disposition: inline
In-Reply-To: <alpine.LSU.0.99999.0712151905280.4341@castor.milkiway.cos>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68404>

On 2007.12.15 19:14:48 +0100, Michael Dressel wrote:
>
>
> On Fri, 14 Dec 2007, Alex Riesen wrote:
>
>> Michael Dressel, Thu, Dec 13, 2007 22:28:30 +0100:
>>> On Thu, 13 Dec 2007, Alex Riesen wrote:
>>>> On 13/12/2007, Michael Dressel wrote:
>>>>> git merge --no-commit <branch> does "create" a commit. At lesat t=
he
>>>>> head and index are moved to the new commit fetched from <branch>.=
 Maybe
>>>>> that is because git was able to do a fast forward?
>>>>
>>>> Yes. Because fast-forward is what it called: fast-forward.
>>>> It does not do any commits at all.
>>>>
>>>
>>> It looks like I misunderstood the meaning of --no-commit. I have to=
 use
>>> --squash in this case.
>>>
>>
>> Maybe. Or maybe you misunderstood the meaning of --squash, which als=
o
>> is not a merge.
>
> Since "git merge --squash <branch>" does a merge of <branch> into the=
=20
> working tree why would you not call it a merge?

A "real" merge commit has at least two parents, and retains the
individual commits of each branch in the history. It just connects two
lines of history. --squash just takes all changes and produces a
single-parented commit, destroying the individual commits that
originally introduced the changes.

> Anyway that was what I wanted. Merging <branch> (a topic branch) into=
 my=20
> current branch (the main branch) but being able to create commits tha=
t are
> more suitable for keeping in the history of the current branch than t=
he
> commits I created during developing on <branch>.
> Would you recommend a different way of doing this?

If you didn't publish your topic branch, use interactive rebasing to
re-order/edit your commits.

Bj=F6rn
