From: Abhijit Bhopatkar <bain@devslashzero.com>
Subject: Re: [RFC] teamGIT bonjour support
Date: Fri, 28 Aug 2009 14:09:13 +0530
Message-ID: <2fcfa6df0908280139q66051a4aubc9b289b46f50b43@mail.gmail.com>
References: <2fcfa6df0908280002y221a22e6md27db56865472144@mail.gmail.com> 
	<43d8ce650908280105x70327db0p7fce1bd6575297d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, teamgit@googlegroups.com
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 10:40:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgwzn-0001kY-3g
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 10:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbZH1Ije (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 04:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbZH1Ijd
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 04:39:33 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:54634 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320AbZH1Ijc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 04:39:32 -0400
Received: by bwz19 with SMTP id 19so1468677bwz.37
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 01:39:34 -0700 (PDT)
Received: by 10.204.34.73 with SMTP id k9mr690316bkd.45.1251448773819; Fri, 28 
	Aug 2009 01:39:33 -0700 (PDT)
In-Reply-To: <43d8ce650908280105x70327db0p7fce1bd6575297d2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127279>

>> good. But it has its usual problems of forcing everyone to religiously
>> publish _AND_ keep rebasing on main branch every so often. Also my
>> major problem is that we discover conflicts only _after_ a developer
>> tries to rebase his work, typically (by design) after he has fully
>> coded and tested a feature.
>
> What sort of time frame are you talking about?  How long are your
> sprints, or however you partition your work.
>
> I can't help but feel the problem should be solved elsewhere.  Do you
> have daily scrums?  Everyone should know, roughly, what everyone is
> doing.  If you are using 2-3 week sprints (or however you partition
> the time) and everyone is roughly aware of what everyone else around
> them is doing, there shouldn't really be so much of a problem.

Well as i said in informal way we do shout out loud (managers: read as
'daily meetings') when we want to make changes that might conflict
with some one else and i have been blessed with a rather good dev team
who can spot this right, and it works well for now for these short
sprints. However see below for my itch.

>> The current way to get around this is shouting aloud before you start
>> working on a new feature/file/section.
>
> How do you allocate the features in the first place?  At the start of
> a sprint?  If so, it should be the person in charge of that that
> should see if there are going to be conflicts.  If you don't have
> sprints, then how do you divide up tasks?

Yes as i said this generally works.
But and this is a big BUT, this essentially makes the developer the
point of failure (in reporting the conflict). And in my view (exactly
contrary to yours) the problem should be solved else where.

Also we are working on many porting projects which need changes to the
same file but not essentially logically conflicting, which if,
everyone is aware of at the moment the change is made (commited?) is
trivial to resolve.
However when you have 100 such changes at the end of a sprint thats a
problem. Yes git makes it extremely easy to merge i can't even begin
to think about the current style of development in svn deployment. And
we can resolve those conflicts fairly easy. Its just that I have to
depend then on individual's ability to persist through what seems like
million merge conflicts.
And no its not avoidable, we _have_ to do those conflicting changes in
order to keep the pace of development. Its just about reporting them
sanely and quickly which is ok to be done manually, but it pains me
that the info can be available with some tool as well with obvious
benifits of automation.

So the idea is sort of local linux-next style automation for small teams.

BAIN

> John
