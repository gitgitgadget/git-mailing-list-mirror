From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git merge --no-commit <branch>; does commit
Date: Sat, 15 Dec 2007 12:57:58 -0800 (PST)
Message-ID: <m33au3r7zf.fsf@roke.D-201>
References: <alpine.LSU.0.99999.0712132151080.5326@castor.milkiway.cos>
	<81b0412b0712131319h63609810m593f0e552d02a83c@mail.gmail.com>
	<alpine.LSU.0.99999.0712132224280.5606@castor.milkiway.cos>
	<20071214074925.GA3525@steel.home>
	<alpine.LSU.0.99999.0712151905280.4341@castor.milkiway.cos>
	<m37ijfrcm5.fsf@roke.D-201>
	<alpine.LSU.0.99999.0712152117060.5151@castor.milkiway.cos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Sat Dec 15 21:58:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3e5h-0007Mb-W1
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 21:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbXLOU6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 15:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754329AbXLOU6E
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 15:58:04 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:32902 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbXLOU6B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 15:58:01 -0500
Received: by fk-out-0910.google.com with SMTP id z23so543763fkz.5
        for <git@vger.kernel.org>; Sat, 15 Dec 2007 12:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=b1WVUbB1Cjqn2yItpEpY3dLJp3PcsFgIHEklm/kg9MM=;
        b=JqO8v2TCoz8OP7UZOWyn4dHhv9/KZz0lfoS/naQWcfOrbMSxIvccLeLsrK8IXFRPjZSHnzvLmfH6jvEAkTY0XPGqwiIix+hrPcil2TROIcvY8MBieGubP1THtnpPQl0kWaVcz8vwSgQ7FibhzNoytw/U050Yd3R5yi+8ZoHpADU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=P7v0UBCQZrRhX5Xtia+01LMKnKyUWRQeVeEp7dLOI0JCF3NBi4KWgPaQr5jXcD2NEXF28SLCsb97/RkXvfBCaX6tebMqS59TAmoP1+liFCGnTJHL/E1MmghZbtQyYjpPNu5jtw1hhYFRNGtZfW2lrCZa6Jzzlh2zCXia1FXjEfY=
Received: by 10.86.50.8 with SMTP id x8mr4530346fgx.61.1197752280005;
        Sat, 15 Dec 2007 12:58:00 -0800 (PST)
Received: from roke.D-201 ( [83.8.240.142])
        by mx.google.com with ESMTPS id e11sm473091fga.2007.12.15.12.57.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Dec 2007 12:57:58 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBFKvvlf023896;
	Sat, 15 Dec 2007 21:57:57 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id lBFKvuFb023893;
	Sat, 15 Dec 2007 21:57:56 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <alpine.LSU.0.99999.0712152117060.5151@castor.milkiway.cos>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68416>

Michael Dressel <MichaelTiloDressel@t-online.de> writes:
> On Sat, 15 Dec 2007, Jakub Narebski wrote:
>> Michael Dressel <MichaelTiloDressel@t-online.de> writes:
>>>
>>> Since "git merge --squash <branch>" does a merge of <branch> into the
>>> working tree why would you not call it a merge?
>>
>> A few illustrations. Commits A, B, C were made on 'trunk', commits
>> a, b, c were made on 'branch'. You are on 'trunk', running
>> "git merge <options> branch". We assume that there are no conflicts.
>>
>> 1. A non fast-forward case
>>
>>   1---2---3---A---B---C   <-- trunk    <-- HEAD
>>            \
>>             \-a---b---c   <-- branch

>> 1.2. "git merge --no-commit branch"
>>
>>                        /-------- trunk  <-- HEAD
>>                       v
>>   1---2---3---A---B---C--*
>>            \            /
>>             \-a---b---c/     <-- branch
>>                       ^
>>                        \-------- MERGE_HEAD
>>
>> The merge commit '*' is prepared, but not yet committed, just
>> as if there were merge conflict during merge. "git commit"
>> would commit a merge (and would tell you that it does a merge
>> commit).

>> 1.4. "git merge --squash branch"
>>
>>   1---2---3---A---B---C--[abc]'   <-- trunk <-- HEAD
>>            \
>>             \-a---b---c           <-- branch
>>
>> "[abc]'" is a _single parent_ commit (it is not a merge commit!)
>> which incorporates changes made on branch as if it were made in
>> a single, large (!) commit.
> 
> Thanks alot for the elaborate explanations.

You are welcome
 
>> Test of understanding the concepts: what does
>> "git merge --squash --no-commit" does?
>>
> 
> From the man page it sounds "git merge --squash --no-commit" would do
> the same as "git merge --squash". So in the example 1.4 [abc] should
> not be a commit.

                       /---------\
                       v          \
   1---2---3---A---B---C--*[abc]'  \-- trunk <-- HEAD
            \
             \-a---b---c           <-- branch

where *[abc]' is prepared state (staged but not committed changes)
squashing achanges into commits a, b, c into trunk.

Note that using "git rebase --interactive" you can squash, reorder
and edit commits; if you rather work in this way, reordering, editing
etc. "on the go" you perhaps should consider patch-management
interfaces like StGIT (Stacked GIT) or Guilt (formerly gq).

BTW. in practice [abc]' in squash case is the same as M in normal
case, only M has two parents recorded, and [abc]' does not.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
