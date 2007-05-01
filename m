From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: "Producting Open Source Software" book and distributed SCMs
Date: Tue, 1 May 2007 20:30:10 +0200
Message-ID: <200705012030.11747.jnareb@gmail.com>
References: <200704300120.42576.jnareb@gmail.com> <Pine.LNX.4.64.0705011057130.29859@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 02 00:15:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj0dD-0007es-4V
	for gcvg-git@gmane.org; Wed, 02 May 2007 00:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946040AbXEAWPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 18:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946043AbXEAWPb
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 18:15:31 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:26911 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946040AbXEAWPa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 18:15:30 -0400
Received: by py-out-1112.google.com with SMTP id a29so1679145pyi
        for <git@vger.kernel.org>; Tue, 01 May 2007 15:15:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QkRCMAvV+FJiZOSfJY5cwGg7dQvkSXoknIrwPypLbJe0twwmYl1FKaZxIPlibf3/zEoYvA0SpgnK6AbK1iRejFlCe8EZRWDuf72qeVuR0hHXQ82qxFgZ1VmjhTQzh/iOwxERsYvuOlUVeDFUKI/D5iJ53IzQMeW2YRlG4WZKDOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=a8tVEPQp4incfeV+GEb5lN3/R2nVpGefh7+/saDQREa+ysLvC/WgqNgFBw5Y/nDs98a3yVEkAqBSHrQcxSklS2cGgjea2IE+70vz17/gSXmHRc/vcmjBH00whEpLCIcPPZJBJXg94aWQlzFzOMj+cE0XXxDnP09FKgKeZtzv1CE=
Received: by 10.64.199.8 with SMTP id w8mr14729940qbf.1178057729401;
        Tue, 01 May 2007 15:15:29 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id m1sm33722uge.2007.05.01.15.15.27;
        Tue, 01 May 2007 15:15:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0705011057130.29859@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45983>

Hi

On Thursday, 1 May 2007, Johannes Schindelin wrote:
> On Mon, 30 Apr 2007, Jakub Narebski wrote:
> 
>> Linus has said that fully distributed SCM improves forkability:
>>
>> [...] 
>> 
>>   I think that "forking" is what keeps people honest. The _biggest_
>>   downside with CVS is actually that a central repository gets so much
>>   _political_ clout, that it's effectively impossible to fork the
>>   project: [...]
>> 
>> According to "Producting Open Source Software" it is very important 
>> feature for an OSS project.
>>
>> [...]
>> 
>>   Because a fork is bad for everyone (for reasons examined in detail in 
>>   the section called "Forks" in Chapter 8, Managing Volunteers, 
>>   http://producingoss.com/producingoss.html#forks), the more serious the 
>>   threat of a fork becomes, the more willing people are to compromise to 
>>   avoid it.
> 
> This is a lousy argument, IMHO.
> 
> Why are forks bad? They are not. But if you "learnt" that merges are hard, 
> they are.
> 
> It is a pity that so many people were trained in CVS, and keep thinking 
> some of the lectures were true, when they are no longer.
> 
> Forks are good. In fact, we all "forked" with CVS as soon as we began 
> hacking. Everybody who claims to never have started over from a fresh 
> checkout, or from an "update -C"ed state, is probably lying, or a bad 
> developer. Thinking about it, I believe that the difference between 
> forking and branching is philosophical, not technical. You can always 
> merge a fork.

IIRC Compiz and Beryl (fork of Compiz) plan to be merged. Both projects
use git as SCM. We will see how this "merge a fork" will work.

In "Producting Open Source Software" Karl Fogel gives an example of
GCC/EGCS fork, which resulted in "fast forward" merge (EGCS which was
fork of GCC, became next version of GCC). Similar example is XFree86/X.Org
fork; Linux distributions went from packaging XFree86 to packaging X.Org.

But for example GNU Emacs / XEmacs fork will never be merged, I think.
So not always you can merge a fork - you can try, unless codebase diverged
too much.

>> Is distributed SCM better geared towards "benovolent dictator"
>> model than "consensus-based democracy" model, as described in
>> OSSbook?
>
> Not at all. I think the best example is kernel.org, where you find
> tons of forks. IMHO it is really helping the benevolent dictator cave
> into the consensus-based model, since forks can be preferred at any
> time. Hey, even switching from one to another upstream is just a
> git-pull away!

What is or is not a fork is a bit blurry in the world of distributed
version control systems. Is a clone of repository a fork? I think that
everybody would agree that it is not. Is for example *-mm tree a fork?
I'd say not. But I'd say that Beryl is a fork of Compiz...

-- 
Jakub Narebski
ShadeHawk on #git
Poland
